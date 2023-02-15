package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class UserQuestionFormController implements Controller
{
	// 질문하기 폼 요청
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인
		HttpSession session = request.getSession();
		 
		if(session.getAttribute("userSession") == null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		mav.setViewName("/WEB-INF/userView/UserQuestionForm.jsp");
		
		return mav;
	}
	
}
