package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserRecordDAO;
import com.fp.dto.RecordDTO;

public class UserSearchController implements Controller
{
	private IUserRecordDAO dao;
	
	public void setDao(IUserRecordDAO dao)
	{
		this.dao = dao;
	}

	// 메인화면 상단바에서 검색 시
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 누구나 접근 가능 세션 확인 필요없음
		
		// 이전페이지에서 값 받아오기
		//-- 검색값 title
		String title = request.getParameter("title");
		String type = request.getParameter("type");

		if(type == null)
			type = "";

		ArrayList<RecordDTO> result = new ArrayList<RecordDTO>();
		
		try
		{
			result = dao.list(title, type);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		mav.addObject("list", result);
		mav.addObject("type", type);
		mav.setViewName("/WEB-INF/userView/UserSearch.jsp");
		
		return mav;
	}
	
}
