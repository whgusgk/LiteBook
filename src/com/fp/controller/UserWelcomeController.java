
package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;

public class UserWelcomeController implements Controller
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
		
		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) --------------------------
	      
	      HttpSession session = request.getSession();
	       session.getAttribute("userSession");
	         
	         if (session.getAttribute("userSession")==null)
	         {
	            mav.setViewName("redirect:userloginform.action");
	            return mav;
	         }

	         String sign_num = (String)session.getAttribute("userSession");
	         
	      // -------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
	         
	        String user_name = dao.searchName(sign_num);
	         
	        mav.addObject("user_name", user_name);
	         
			
			mav.setViewName("/WEB-INF/userView/UserWelcome.jsp");
			
		
		return mav;
	}
	

      

	
}
