package com.fp.controller;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserNoticeDAO;
import com.fp.util.Pagination;

public class UserNoticeListController implements Controller
{
	private IUserNoticeDAO dao;
	
	public void setDao(IUserNoticeDAO dao)
	{
		this.dao = dao;
	}

	// 공지사항 리스트 페이지 요청
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 누구나 접근 가능한 페이지 - 세션확인 필요없음
		
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지에서 받아올 정보 
		String keyword = request.getParameter("keyword");	// 검색했을 경우 회원이 입력한 값
		String pageNum = request.getParameter("pageNum");	// 다른 페이지 이동했을 때 페이지 번호
		
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		
		if (keyword != null)
			keyword = URLDecoder.decode(keyword, "UTF-8");
		else
			keyword = "";
		
		// 총 게시물 개수
		int count = dao.count(keyword);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int start = (currentPage - 1) * 15 + 1;
		int end = currentPage * 15;
		
		// dao.list()를 쓰기 위한 형변환
		//String start = String.valueOf(startInt);
		//String end = String.valueOf(endInt);
		
		// 각 페이지에 맞는 공지사항 리스트
		//mav.addAttribute("list", dao.list(start, end, keyword));
		mav.addObject("list", dao.list(start, end, keyword));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		if (!keyword.equals(""))
			param += "?keyword=" + keyword;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "usernoticelist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 제목을 눌렀을 때 이동할 링크 구성
		String noticeUrl = "usernotice.action";
		
		if (param.equals(""))
			noticeUrl = noticeUrl + "?pageNum=" + currentPage;
		else
			noticeUrl = noticeUrl + param + "&pageNum=" + currentPage;
		
		mav.addObject("pageList", pageList);
		mav.addObject("noticeUrl", noticeUrl); 
		mav.setViewName("/WEB-INF/userView/UserNoticeList.jsp");
		
		return mav;
	}
	
}
