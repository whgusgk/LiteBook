package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserBookDAO;
import com.fp.dto.BookDTO;
import com.fp.util.Pagination;

public class UserBookListController implements Controller
{
	//추후 인기여행책 리스트를 위한 UserBookDAO관련 처리 필요
	private IUserBookDAO dao;
	
	public void setDao(IUserBookDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		//페이지네이션 객체 생성
		Pagination page = new Pagination();
		
		//전체책리스트 객체를 담을 ArrayList선언
		ArrayList<BookDTO> bookList = new ArrayList<BookDTO>();
		
		String pageNum = "";
		int currentPage = 1;
		
		try
		{
			//이전 페이지로부터 데이터 수신
			pageNum = request.getParameter("pageNum");
			
			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
			
			int count = dao.count(sign_num);
			
			int totalPage = page.PageCount(count);
			
			if(currentPage > totalPage)
				currentPage = totalPage;
			int start = (currentPage - 1) * 15 + 1;
			int end = currentPage * 15;
			
			String pageUrl = "userbook.action";
			
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
			mav.addObject("pageList", pageList);
			
			String bookUrl = "userbook.action?pageNum=" + currentPage;
			mav.addObject("bookUrl", bookUrl);
			
			bookList = dao.bookList(sign_num, start, end);
			mav.addObject("bookList", bookList);
			
			
			//추후에 인기여행책 리스트를 위한 책관련 값을 넘겨줘야함.
			mav.setViewName("/WEB-INF/userView/UserBookList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}

