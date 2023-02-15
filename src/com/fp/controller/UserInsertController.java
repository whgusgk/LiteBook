
package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserPageDAO;
import com.fp.dto.UserDTO;


// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class UserInsertController implements Controller
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
		String user_pw = request.getParameter("user_pw");
		String user_name = request.getParameter("user_name");
		String user_tel = request.getParameter("user_tel");
		String user_email = request.getParameter("user_email");
		String user_birth = request.getParameter("user_birth");
		String gender_num = request.getParameter("gender_num");
		String region_num1 = request.getParameter("region_num1");
		String region_num2 = request.getParameter("region_num2");
		String region_num3 = request.getParameter("region_num3");
		String tcategory_num1 = request.getParameter("tcategory_num1");
		String tcategory_num2 = request.getParameter("tcategory_num2");
		String tcategory_num3 = request.getParameter("tcategory_num3");
		
		try
		{
			UserDTO dto = new UserDTO();
			
			dto.setUser_id(user_id);
			dto.setUser_pw(user_pw);
			dto.setUser_name(user_name);
			dto.setUser_tel(user_tel);
			dto.setUser_email(user_email);
			dto.setUser_birth(user_birth);
			dto.setGender_num(gender_num);
			
			int result = dao.add(dto);
			
			if (result == 0)
			{
				mav.setViewName("redirect:userresiform.jsp");
				return mav;
			}
			else {
				HttpSession session = request.getSession();
				String userSession;
				userSession = dao.sessionSignNum(user_id);
				session.setAttribute("userSession", userSession);
			
			if (!region_num1.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setRegion_num(region_num1);
				dao.regionAdd(dto);
			}
			if (!region_num2.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setRegion_num(region_num2);
				dao.regionAdd(dto);
			}
			if (!region_num3.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setRegion_num(region_num3);
				dao.regionAdd(dto);
			}
			
			if (!tcategory_num1.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setTcategory_num(tcategory_num1);
				dao.categoryAdd(dto);
			}
			if (!tcategory_num2.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setTcategory_num(tcategory_num2);
				dao.categoryAdd(dto);
			}
			if (!tcategory_num3.equals("0"))
			{
				dto.setSign_num(userSession);
				dto.setTcategory_num(tcategory_num3);
				dao.categoryAdd(dto);
			}
			}
			
			mav.setViewName("/WEB-INF/userView/UserWelcome.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	

      

	
}
