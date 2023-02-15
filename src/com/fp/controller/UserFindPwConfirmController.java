package com.fp.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;


public class UserFindPwConfirmController implements Controller
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
			
			String user_id = request.getParameter("user_id");
			String user_email = request.getParameter("user_email");
			String result="";
			String result2="";
			
			try
			{
				result = dao.findPwd1(user_id);
				result2 = dao.findPwd2(user_email);
				
				String sign_num = dao.searchId(user_id);
				
				if (result.equals("1") && result2.equals("1"))
					{
						mav.addObject("sign_num", sign_num);
						mav.setViewName("/WEB-INF/userView/UserPwConfirmForm.jsp");
						
					}
					else
					{
						mav.setViewName("redirect:userpwfindform.action");
						
					}
					
				
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		
			return mav;
		}
		
	}
