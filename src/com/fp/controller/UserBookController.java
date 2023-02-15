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
import com.fp.dto.CommentDTO;

public class UserBookController implements Controller
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
			sign_num = " ";
		else
			sign_num = (String)session.getAttribute("userSession");
		/* 책 열람은 세션이 없더라도 접근이 가능해야함
		 * 세션이 없더라도 접근이 가능해야함*
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		*/
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		//여행책 객체 생성
		BookDTO book = new BookDTO();
		
		//카드리스트 객체를 담을 ArrayList선언
		ArrayList<CardDTO> cardList = new ArrayList<CardDTO>();
		ArrayList<CommentDTO> commentList = new ArrayList<CommentDTO>();
		
		try
		{
			//이전 페이지로부터 데이터 수신
			String book_num = request.getParameter("book_num");
			
			//여행책 조회수 +1
			dao.hitUpdate(book_num);
			
			//여행책 객체 정보 담아서 넘겨주기
			book = dao.search(book_num);
			mav.addObject("book",book);
			
			int likedCheck= 2;
		    
			if(sign_num!=" ")
		    	likedCheck = dao.likedCheck(book_num, sign_num);
		    
		    mav.addObject("likedCheck", likedCheck);
		    mav.addObject("book_num", book_num);
			
			//카드리스트 담아서 넘겨주기
			cardList = dao.cardList(book_num);
			mav.addObject("cardList", cardList);

			//댓글 리스트 담아서 넘겨주기
			commentList = dao.commentList(book_num);
			mav.addObject("commentList",commentList);
			
			//추후에 인기여행책 리스트를 위한 책관련 값을 넘겨줘야함.
			mav.setViewName("/WEB-INF/userView/UserBook.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}

