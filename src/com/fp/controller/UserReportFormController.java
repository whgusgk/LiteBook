package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dto.UserDTO;

public class UserReportFormController implements Controller
{
	/*
	private IUserReportDAO dao;
	
	public void setDao(IUserReportDAO dao)
	{
		this.dao = dao;
	}
	*/
	private IMyPageDAO mydao;
	
	public void setMydao(IMyPageDAO mydao)
	{
		this.mydao = mydao;
	}


	// 여행책 신고 폼 요청 시
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
		
		// 타입, 번호 가져오기
		String num = request.getParameter("num");
		String type = request.getParameter("type");
		
		//ReportDTO result = new ReportDTO();
		//result = dao.list(type, num);
		
		UserDTO dto = new UserDTO();
		
		dto = mydao.search(sign_num);
		
		mav.addObject("num", num);
		mav.addObject("type", type);
		mav.addObject("user", dto);
		
		mav.setViewName("/WEB-INF/userView/UserReportForm.jsp");
		
		return mav;
	}
	
}
