package com.fp.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.view.RedirectView;

import com.fp.dao.IUserCardDAO;

public class UserPayDeleteController implements Controller
{
	private IUserCardDAO dao;
	
	public void setDao(IUserCardDAO dao)
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
		
		int result = 0;

		try
		{
			// 이전 페이지로부터 데이터 수신
			String pay_num = request.getParameter("pay_num");
			
			result = dao.payDelete(pay_num);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
			
			
		return mav;

	}
}
