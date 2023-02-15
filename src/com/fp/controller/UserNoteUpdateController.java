package com.fp.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.view.RedirectView;

import com.fp.dao.IUserNoteDAO;
import com.fp.dto.NoteDTO;

public class UserNoteUpdateController implements Controller
{
	private IUserNoteDAO dao;
	
	public void setDao(IUserNoteDAO dao)
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
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		NoteDTO note = new NoteDTO();

		try
		{
			// 이전 페이지로부터 데이터 수신
			String note_num = request.getParameter("note_num");
			String note_title = request.getParameter("title");
			String region_num = request.getParameter("region");
			//String note_startDate = format.format(request.getParameter("startDate"));
			// String note_lastDate = format.format(request.getParameter("lastDate"));
			String note_budget = request.getParameter("totalMoney");
			String note_company = request.getParameter("companion");
			
			Date startDate = format.parse(request.getParameter("startDate"));
			String note_startDate = format.format(startDate);
			
			Date lastDate = format.parse(request.getParameter("lastDate"));
			String note_lastDate = format.format(lastDate);
			
			// 예산, 동행자 추가 작업
			if (note_budget==null)
				note_budget = "0";
			
			if (note_company==null)
				note_company = "0";
			
			note.setNote_num(note_num);
			note.setNote_title(note_title);
			note.setRegion_num(region_num);
			note.setNote_startdate(note_startDate);
			note.setNote_lastdate(note_lastDate);
			note.setNote_budget(note_budget);
			note.setNote_company(note_company);
			note.setSign_num(sign_num);
			
			dao.update(note);
			
			mav.setViewName("redirect:usernotelist.action");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
			
			
		return mav;

	}
}
