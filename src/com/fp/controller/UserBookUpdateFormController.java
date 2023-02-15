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

public class UserBookUpdateFormController implements Controller
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
		
		//해당 여행책이 무엇인지 알아낼 Book_num 잡아오기
		String book_num = request.getParameter("book_num");
		
		//노트리스트 객체를 담을 ArrayList선언
		ArrayList<NoteDTO> noteList = new ArrayList<NoteDTO>();
		ArrayList<CardDTO> bookedCardList = new ArrayList<CardDTO>();
		BookDTO userBook = new BookDTO();
		
		try
		{	
			
			mav.addObject("book_num",book_num);
			
			//노드리스트에 담아서 셀렉트박스 옵션으로 띄워줄 리스트 담아내기
			noteList = dao.noteList(sign_num);
			mav.addObject("noteList", noteList);
			
			//해당 여행책 정보를 넘겨줄 객체
			userBook = dao.searchForUpdate(book_num);
			mav.addObject("userBook",userBook);
			
			//해당 여행책에 담긴 카드리스트 출력 
			bookedCardList = dao.bookedCardList(book_num);
			mav.addObject("bookedCardList", bookedCardList);
			
			
			//추후에 인기여행책 리스트를 위한 책관련 값을 넘겨줘야함.
			mav.setViewName("/WEB-INF/userView/UserBookUpdateForm.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}

