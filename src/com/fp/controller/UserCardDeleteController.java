package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserCardDAO;
import com.fp.dto.NoteDTO;

public class UserCardDeleteController implements Controller
{
	private IUserCardDAO dao;
	
	public void setDao(IUserCardDAO dao)
	{
		this.dao = dao;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		int result = 0;
		NoteDTO note = new NoteDTO();
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			String card_num = request.getParameter("card_num");
			
			note = dao.searchNotedNote(card_num);
			String note_num = note.getNote_num();
			String startdate = note.getNote_startdate();
			String lastdate = note.getNote_lastdate();
			
			result = dao.delete(card_num);
			
			mav.addObject("note_num", note_num);
			mav.addObject("startdate", startdate);
			mav.addObject("lastdate", lastdate);
			
			mav.setViewName("redirect:usernoteupdateform.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
			
			
		return mav;

	}
}
