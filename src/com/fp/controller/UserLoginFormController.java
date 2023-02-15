package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class UserLoginFormController implements Controller
{
	// Controller 인터페이스의 handleRequest() 메소드 재정의
	// userloginform.action 요청 시 
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 유저로그인폼 페이지 반환 
		mav.setViewName("/WEB-INF/userView/UserLoginForm.jsp");
		
		return mav;
	}
	
}



