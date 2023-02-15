package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dto.UserDTO;
import com.fp.util.Pagination;

public class UserMyInfoController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		// 세션 확인
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		Pagination page = new Pagination();
		
		UserDTO user = new UserDTO();
		ArrayList<String> fregionList = new ArrayList<String>();
		ArrayList<String> fcategoryList = new ArrayList<String>();
		
		try
		{
			// 마이페이지 상단에 들어갈 정보 처리
			user = dao.search(sign_num);
			fregionList = dao.searchFregion(sign_num);
			fcategoryList = dao.searchFcategory(sign_num);
			
			mav.addObject("user", user);
			mav.addObject("fregionList", fregionList);
			mav.addObject("fcategoryList", fcategoryList);

			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserMyInfo.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}
