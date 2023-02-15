package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;



public class UserScrapOtherProfileCardListController implements Controller
{
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인
		HttpSession session = request.getSession();
		   
	      if (session.getAttribute("userSession")==null)
	      {
	         mav.setViewName("redirect:userloginform.action");
	         return mav;
	      }
		
		// 유저 메인 페이지 
		mav.setViewName("/WEB-INF/userView/UserOtherProfileCard.jsp");
		
		return mav;
	}
}
