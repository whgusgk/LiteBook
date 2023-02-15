package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IServiceDAO;
import com.fp.dto.WarningDTO;
import com.fp.util.Pagination;

public class UserMyWarningController implements Controller
{
	private IServiceDAO dao;
	
	public void setDao(IServiceDAO dao)
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
		
		ArrayList<WarningDTO> warningList = new ArrayList<WarningDTO>();
		int warning = 0;
		int fakereport = 0;
		
		String pageNum = "";
		
		// 페이징 작업
		int currentPage = 1;
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			pageNum = request.getParameter("pageNum");
			
			if (pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
			
			warning = dao.warningCount(sign_num);
			fakereport = dao.fackWarnintCount(sign_num);
			
			int count = warning + fakereport;
			mav.addObject("count", count);
			
			int totalPage = page.PageCount(count);
			
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage-1) * 15 + 1;
			int end = currentPage * 15;
			
			// 페이징 문자열
			String pageUrl = "usermyreport.action";
			
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
			mav.addObject("pageList", pageList);
						
			// 경고 리스트
			warningList = dao.warningList(sign_num, start, end);
			
			mav.addObject("warningList", warningList);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserMyWarning.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}
