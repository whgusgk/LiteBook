package com.fp.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;


public class UserFindIdConfirmController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		String user_name = request.getParameter("user_name");
		String user_email = request.getParameter("user_email");
				
		String checkId;
		
		// 회원가입 시 닉네임과 아이디를 받아오기 위함 
		checkId = dao.findUserId(user_name, user_email);
					
		mav.addObject("checkId", checkId);
		
		mav.setViewName("/WEB-INF/userView/UserIdConfirmForm.jsp");
		
		return mav;
	}

}
