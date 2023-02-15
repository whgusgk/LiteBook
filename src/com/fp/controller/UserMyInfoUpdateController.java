package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dto.UserDTO;

public class UserMyInfoUpdateController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}

	// 개인정보 수정 액션
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		int userResult = 0;
		
		// 이전 페이지에서 데이터 가져오기
		//-- id(닉네임), intro(자기소개), email, phone1, phone2, phone3, gender
		//	, area1, area2, area3, category1, category2, category3 
		String user_name = request.getParameter("id");
		String user_intro = request.getParameter("intro");
		String user_email = request.getParameter("email");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String user_tel = phone1 + "-" + phone2 + "-" + phone3;
		String gender = request.getParameter("gender");
		
		UserDTO dto = new UserDTO();
		dto.setUser_name(user_name);
		dto.setUser_intro(user_intro);
		dto.setUser_email(user_email);
		dto.setUser_tel(user_tel);
		dto.setUser_gender(gender);
		dto.setSign_num(sign_num);
		
		String region1 = request.getParameter("area1");
		String region2 = request.getParameter("area2");
		String region3 = request.getParameter("area3");
		
		String category1 = request.getParameter("category1");
		String category2 = request.getParameter("category2");
		String category3 = request.getParameter("category3");
		
		try
		{
			// 개인정보 기본 사항 수정
			userResult = dao.update(dto);
			
			// 이전에 회원이 선택했던 관심지역 딜리트
			dao.fregionDelete(sign_num);
			
			// 이전에 회원이 선택했던 관심 카테고리 딜리트
			dao.fcategoryDelete(sign_num);
			 
			// 회원이 선택한 관심지역 인서트
			if (region1 != null || region1 != "0")
				dao.fregionInsert(region1, sign_num);
			if (region2 != null || region2 != "0")
				dao.fregionInsert(region2, sign_num);
			if (region3 != null || region3 != "0")
				dao.fregionInsert(region3, sign_num);
			
			// 회원이 선택한 관심카테고리 인서트
			if (category1 != null || category1 != "0")
				dao.fcategoryInsert(category1, sign_num);
			if (category2 != null || category2 != "0")
				dao.fcategoryInsert(category2, sign_num);
			if (category3 != null || category3 != "0")
				dao.fcategoryInsert(category3, sign_num);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.setViewName("redirect:usermyinfo.action");
		
		return mav;
	}
	
}





