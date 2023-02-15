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

public class UserNoteInsertController implements Controller
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
			/*
			int note_budget = 0;
			
			if (budgetStr!="")
				note_budget = Integer.parseInt(budgetStr);*/
			
			note.setNote_title(note_title);
			note.setRegion_num(region_num);
			note.setNote_startdate(note_startDate);
			note.setNote_lastdate(note_lastDate);
			note.setNote_budget(note_budget);
			note.setNote_company(note_company);
			note.setSign_num(sign_num);
			
			dao.insert(note);
			
			// 뷰 페이지 set
			// mav.setViewName("/WEB-INF/userView/UserNotedCardInsertForm.jsp");
			// -- 노트 인서트와 새 폼 출력을 한 번에 처리해주면 노트가 무한대로 인서트 되는 문제 발견
			//	  UserNoteInsertForm > UserNoteInsertController > UserNotedCardInsertFormController > UserNotedCardInsertForm
			//	  순으로 진행 필요
			
			// note_num을 다음 페이지로 넘겨줌
			int note_num = dao.max(sign_num);
			
			mav.addObject("note_num", note_num);
			mav.addObject("startdate", note_startDate);
			mav.addObject("lastdate", note_lastDate);
			
			// 뷰 네임을 전달하는 것이 아니라
			// 리다이렉트를 통해 새로운 명령을 전달할 객체를 부르는 메소드
			mav.setView(new RedirectView("usernoteupdateform.action"));

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
			
			
		return mav;

	}
}
