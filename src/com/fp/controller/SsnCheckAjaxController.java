package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;

public class SsnCheckAjaxController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	// 회원(user)이 입력한 아이디, 비밀번호 일치 확인
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 회원이 입력한 아이디, 비밀번호 변수에 담기
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String idCheck = "";
		String pwCheck = "";
		
		int result = 0;
		
		try
		{
			idCheck = dao.idCheck(user_id);					// 0인 경우 존재하지 않는 아이디
			
			if(!idCheck.contains("0"))						// 아이디가 존재하는 경우
			{
				pwCheck = dao.pwCheck(user_id, user_pw);	// 비밀번호 맞는지 조회 - 일치할 경우 회원이 입력한 아이디 반환
				
				if(user_id.equals(pwCheck))
					result = 2;
				else
					result = 1;
			}
			
			mav.addObject("result", result);				// '0' 없는 아이디, '1' 비밀번호 오류, '2' 로그인 성공 
			mav.setViewName("/WEB-INF/userView/SsnCheckAjax.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}




