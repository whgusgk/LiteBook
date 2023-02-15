package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserCardDAO;
import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.fp.dto.PayDTO;

public class UserCardController implements Controller
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
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		CardDTO card = new CardDTO();
		ArrayList<PayDTO> pays = new ArrayList<PayDTO>();
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			String card_num = request.getParameter("card_num");
			
			
			card = dao.search(card_num);
			mav.addObject("card", card);
			
			pays = dao.paySearch(card_num);
			mav.addObject("pays", pays);
			
			// 목록으로 버튼을 클릭했을 때 돌아갈 수 있도록 처리
			NoteDTO note = new NoteDTO();
			note = dao.searchNotedNote(card_num);
			
			String note_num = note.getNote_num();
			String startdate = note.getNote_startdate();
			String lastdate = note.getNote_lastdate();
			
			mav.addObject("note_num", note_num);
			mav.addObject("startdate", startdate);
			mav.addObject("lastdate", lastdate);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserCard.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;

	}
}
