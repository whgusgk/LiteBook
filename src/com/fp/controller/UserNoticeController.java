package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserNoticeDAO;
import com.fp.dto.NoticeDTO;

public class UserNoticeController implements Controller
{
	private IUserNoticeDAO dao;
	
	public void setDao(IUserNoticeDAO dao)
	{
		this.dao = dao;
	}

	// 공지사항 게시글 세부열람 페이지 요청
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인 필요 없음 - 누구나 접근 가능한 페이지
		
		// 공지사항 번호로 게시글 조회
		//-- 이전페이지에서 공지사항 게시글 번호 가져오기
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		
		NoticeDTO notice = new NoticeDTO();
		
		notice = dao.search(notice_num);
		
		mav.addObject("notice", notice);
		
		mav.setViewName("/WEB-INF/userView/UserNotice.jsp");
		
		return mav;
	}
	
}





