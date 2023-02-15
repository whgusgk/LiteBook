package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserBookDAO;
import com.fp.dto.BookDTO;

public class UserMainController implements Controller
{
	// 메인 페이지 전환 요청 (usermain.action)
	private IUserBookDAO dao;
		
	public void setDao(IUserBookDAO dao)
	{
		this.dao = dao;
	}

	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<BookDTO> bookList = new ArrayList<BookDTO>();
		ArrayList<BookDTO> bookList2 = new ArrayList<BookDTO>();
		
		try
		{
			bookList= dao.bestseller();
			bookList2= dao.bestseller2();

		
			mav.addObject("bookList", bookList );
			mav.addObject("bookList2", bookList2 );
			mav.setViewName("/WEB-INF/userView/UserMain.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;
	}
	
}
