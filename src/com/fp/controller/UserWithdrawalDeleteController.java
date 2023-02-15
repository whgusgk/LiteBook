package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;

public class UserWithdrawalDeleteController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	// 회원 탈퇴 액션 수행
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		String sign_num = request.getParameter("sign_num");

		try
		{
			dao.delete(sign_num);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 세션 삭제
		HttpSession session = request.getSession();
		session.removeAttribute("userSession");
		
		mav.setViewName("redirect:usermain.action");
		return mav;
	}
	
}
