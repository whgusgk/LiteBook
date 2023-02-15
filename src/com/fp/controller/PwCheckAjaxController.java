package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dao.IUserPageDAO;
import com.fp.dto.UserDTO;

public class PwCheckAjaxController implements Controller
{
	private IUserPageDAO userdao;
	
	public void setUserdao(IUserPageDAO userdao)
	{
		this.userdao = userdao;
	}

	private IMyPageDAO mydao;

	public void setMydao(IMyPageDAO mydao)
	{
		this.mydao = mydao;
	}

	// 로그인한 등록번호로 비밀번호 조회해서, 회원이 입력한 값과 비교 
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();		
		
		// 이전 페이지에서 회원 등록번호, 회원이 입력한 비밀번호 값 가져오기
		String user_pw = request.getParameter("user_pw");
		String sign_num = request.getParameter("sign_num");
		String user_id = "";
		String result = "false";
		
		String dbUser_id = "";
		
		UserDTO dto = new UserDTO();
		
		try
		{
			dto = mydao.search(sign_num);						// 세션값에 해당하는 등록번호의 회원 정보 가져오기
			user_id = dto.getUser_id();					// 회원 정보 중 회원 아이디만 가져오기
			
			dbUser_id = userdao.pwCheck(user_id, user_pw);			// 조회한 회원 아이디와 회원이 입력한 비밀번호가 DB에 일치하는지 확인
																			//-- 일치할 경우 회원 아이디를 반환
			
			if(dbUser_id!=null && dbUser_id!="")		// 회원 아이디가 null 값이나 공백이 아닌 경우 
			{
				result = "true";						//-- 비밀번호 일치 true 
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	
		mav.addObject("result", result);
		mav.setViewName("/WEB-INF/userView/pwCheckAjax.jsp");
		
		return mav;
	}
	
}






