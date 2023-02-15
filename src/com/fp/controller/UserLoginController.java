package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;

public class UserLoginController implements Controller
{
	private IUserPageDAO dao;
	
	public void setDao(IUserPageDAO dao)
	{
		this.dao = dao;
	}

	// 유저 로그인 요청(userlogin.action) - 세션 생성 후 메인페이지 이동
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse reponse) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 회원이 입력한 아이디 가져오기(세션 값으로 사용)
		String user_id = request.getParameter("user_id");
		String sign_num = "";
		String stop_type = "";
		String stop_date = "";
		
		HttpSession session = request.getSession();
		
		try
		{
			// 회원 등록번호로 세션 값 부여
			sign_num = dao.sessionSignNum(user_id);
			stop_type = dao.stopSearch(sign_num);
			
			// 모든 회원
			session.setAttribute("userSession", sign_num);
			
			// 정지회원인 경우 세션 속성 하나 추가
			// 정지 회원 아닌 경우 stopSession 속성 null값
			if (stop_type == "Y" || stop_type == "y")
			{
				stop_date = dao.stopDate(sign_num);
				session.setAttribute("stopSession", sign_num);
				session.setAttribute("stopDate", stop_date);
			}
				
			// 접속한 시간 인서트(Users 테이블)
			dao.updateFDate(sign_num);
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 메인 페이지로 이동
		mav.setViewName("redirect:usermain.action");
		
		return mav;
	}
	
}
