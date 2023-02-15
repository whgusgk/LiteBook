package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserBookDAO;
import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;

public class UserAjaxNotedCardController implements Controller
{
	//추후 인기여행책 리스트를 위한 UserBookDAO관련 처리 필요
	private IUserBookDAO dao;
	
	public void setDao(IUserBookDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		
		//카드리스트 객체를 담을 ArrayList선언
		ArrayList<CardDTO> cardList = new ArrayList<CardDTO>();
		
		String note_num = request.getParameter("noteSelect");
		
		try
		{
			//노드리스트에 담아서 셀렉트박스 옵션으로 띄워줄 리스트 담아내기
			cardList = dao.notedCardList(note_num);
			//카드리스트 담아서 넘겨주기
			mav.addObject("cardList", cardList);
			
			
			mav.setViewName("/WEB-INF/userView/AjaxNotedCard.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}

