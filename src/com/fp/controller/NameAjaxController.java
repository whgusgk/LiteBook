
package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;



// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class NameAjaxController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		String user_name = request.getParameter("user_name");
		 
		String result = "";
		String check = "";
		
		try
		{
			result = dao.nameCheck(user_name);
			
			if (!result.equals("0"))
			{
				check = "이미 존재하는 닉네임입니다.";
			}
			else
			{
				check = "사용 가능한 닉네임입니다.";
			}
				
			

			mav.addObject("check", check);
			mav.setViewName("/WEB-INF/userView/Nameajax.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
