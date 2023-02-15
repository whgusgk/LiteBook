package com.fp.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dao.IUserNoteDAO;
import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.fp.dto.UserDTO;

public class UserNoteUpdateFormController implements Controller
{
	private IUserNoteDAO dao;
	private IMyPageDAO myPageDao;
	
	public void setDao(IUserNoteDAO dao)
	{
		this.dao = dao;
	}
	public void setMyPageDao(IMyPageDAO myPageDao)
	{
		this.myPageDao = myPageDao;
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
		
		HashMap<Integer, String> days = new HashMap<Integer, String>();
		ArrayList<ArrayList<CardDTO>> lists = new ArrayList<ArrayList<CardDTO>>();
		NoteDTO note = new NoteDTO();
		ArrayList<UserDTO> regionList = new ArrayList<UserDTO>();
		
		String card_visitDate = "";
		
		int date = 0;
		
		try
		{
			// 전달 받은 데이터 수신
			String note_startDate = request.getParameter("startdate");
			String note_lastDate = request.getParameter("lastdate");
			String note_num = request.getParameter("note_num");
			
			if (note_num == null)
			{
				// 방금 전에 인서트 된 노트 번호 찾기
				note_num = String.valueOf(dao.max(sign_num));
			}
			
			note = dao.search(String.valueOf(note_num));
			mav.addObject("note", note);
			
			// 몇 일 여행인지 계산
			date = dao.dayCount(note_startDate, note_lastDate);
			mav.addObject("date", date);
			
			// 여행 날짜 배열
			days = dao.dateCal(date, note_startDate);
			mav.addObject("days", days);
			
			// 일자별 카드 리스트 구하기 (1 ~ n일차)
			for (int i = 1; i <= date; i++)
			{
				card_visitDate = days.get(i);

				ArrayList<CardDTO> cards = new ArrayList<CardDTO>();
				cards = dao.dayCardListAll(String.valueOf(note_num), card_visitDate);
				
				lists.add(cards);
				
			}
			
			mav.addObject("lists", lists);
			
			// 지역 리스트 set
			regionList = myPageDao.regionList();
			mav.addObject("regionList", regionList);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserNoteUpdateForm.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
			
			
		return mav;

	}
}
