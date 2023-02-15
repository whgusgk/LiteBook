package com.fp.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserNoteDAO;
import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;

public class UserNoteController implements Controller
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
		
		NoteDTO note = new NoteDTO();
		
		int card = 0;
		int cash = 0;
		int etc = 0;
		int all = 0;
		int day = 0;
		
		HashMap<Integer, String> days = new HashMap<Integer, String>();
		ArrayList<ArrayList<CardDTO>> lists = new ArrayList<ArrayList<CardDTO>>();
		String card_visitDate = "";
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			String note_num = request.getParameter("note_num");
			
			note = dao.search(note_num);
			mav.addObject("note", note);
			
			card = dao.paySum(note_num, 1);
			cash = dao.paySum(note_num, 2);
			etc = dao.paySum(note_num, 3);
			
			all = card + cash + etc;
			
			mav.addObject("card", card);
			mav.addObject("cash", cash);
			mav.addObject("etc", etc);
			mav.addObject("all", all);
			
			// 몇 일짜리 여행인지 계산
			day = dao.dayCount(note.getNote_startdate(), note.getNote_lastdate());
			mav.addObject("day", day);
			
			// 일자별 날짜 계산
			String startdate = note.getNote_startdate();
			days = dao.dateCal(day, startdate);
			mav.addObject("days", days);
			
			// 일자별 카드 리스트 구하기 (1 ~ n일차)
			for (int i = 1; i <= day; i++)
			{
				card_visitDate = days.get(i);

				ArrayList<CardDTO> cards = new ArrayList<CardDTO>();
				cards = dao.dayCardList(note_num, card_visitDate);
				
				// if (cards.size() > 0)
					lists.add(cards);
				
			}
			
			mav.addObject("lists", lists);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserNote.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;

	}
}
