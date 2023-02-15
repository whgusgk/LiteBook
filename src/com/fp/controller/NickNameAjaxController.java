package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;

public class NickNameAjaxController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	// 닉네임 중복확인 
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지에서 사용자가 입력한 닉네임 가져오기
		String nickName = request.getParameter("nickname");
		//String checkNickName = "이미 사용중인 닉네임입니다.";
		int result = 0;
		
		try
		{
			result = dao.nickNameCheck(nickName);
			/*
			if(result == 0)
			{
				checkNickName = "사용 가능합니다.";
			}
			*/
			mav.addObject("result", result);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("/WEB-INF/userView/nickNameCheckAjax.jsp");
		
		return mav;
	}
	
}


