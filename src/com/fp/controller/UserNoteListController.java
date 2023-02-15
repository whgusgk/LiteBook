package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserNoteDAO;
import com.fp.dto.NoteDTO;
import com.fp.util.Pagination;

public class UserNoteListController implements Controller
{
	private IUserNoteDAO dao;
	
	public void setDao(IUserNoteDAO dao)
	{
		this.dao = dao;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		Pagination page = new Pagination();
		
		ArrayList<NoteDTO> noteList = new ArrayList<NoteDTO>();
		
		String pageNum = "";
		int currentPage = 1;
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			pageNum = request.getParameter("pageNum");
			
			if (pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
			
			int count = dao.count(sign_num);
			
			int totalPage = page.PageCount(count);
			
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage - 1) * 15 + 1;
			int end = currentPage * 15;
			
			String pageUrl = "usernote.action";
			
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
			mav.addObject("pageList", pageList);
			
			String noteUrl = "usernote.action?pageNum=" + currentPage;
			mav.addObject("noteUrl", noteUrl);
			
			noteList = dao.list(sign_num, start, end);
			mav.addObject("noteList", noteList);
			
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserNoteList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;

	}
}
