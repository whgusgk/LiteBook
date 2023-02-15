package com.fp.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserBookDAO;

public class UserLikedInsertController implements Controller
{
	private IUserBookDAO dao;

	public void setDao(IUserBookDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) --------------------------
		//sessionCheck session = new sessionCheck();
		//String sign_num = (String)session.getUserAttribute(request, response);
		
		
		 HttpSession session = request.getSession();
	   
	      if (session.getAttribute("userSession")==null)
	      {
	         mav.setViewName("redirect:userloginform.action");
	         return mav;
	      }
	      
	      String sign_num = (String)session.getAttribute("userSession");
	     

		// -------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
		
		try
		{
			// 이전 페이지(UserBook.jsp)로부터 데이터 수신
			// -- book_num
			
			String book_num = request.getParameter("book_num");
			dao.likedInsert(book_num, sign_num);

			
			mav.setViewName("userbook.action?book_num="+book_num);

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;

	}

}
