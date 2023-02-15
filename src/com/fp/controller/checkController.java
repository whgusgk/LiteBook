package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dto.UserDTO;
import com.fp.util.Pagination;

public class checkController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		/*
		HttpSession session = request.getSession();
		
		if (session.getAttribute("sign_num")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		*/
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		
		String startdate = request.getParameter("startDate");
		mav.addObject("startdate", startdate);
		
		mav.setViewName("/WEB-INF/userView/check.jsp");
		
		return mav;
	}
}
