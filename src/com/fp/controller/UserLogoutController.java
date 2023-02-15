package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class UserLogoutController implements Controller
{
	// 유저 로그아웃 요청(userlogout.action)
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("userSession");
		session.removeAttribute("stopSession");
		session.removeAttribute("stopDate");
		mav.setViewName("redirect:usermain.action");
		
		return mav;
	}
	
}
