package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IServiceDAO;
import com.fp.util.Pagination;

public class UserFAQListController implements Controller
{
	private IServiceDAO dao;
	
	public void setDao(IServiceDAO dao)
	{
		this.dao = dao;
	}

	// 자주 묻는 질문 리스트 페이지 요청
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인 필요 없음 - 누구나 접근 가능 (질문하기 불가능)
		
		// 이전 페이지에서 받아올 정보 
		String pageNum = request.getParameter("pageNum");	// 다른 페이지 이동했을 때 페이지 번호
		String qcategoryNum = request.getParameter("qcategoryNum");
		
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		
		// 총 게시물 개수
		int count = 0;
		
		// qcategoryNum을 int 타입으로 변환
		int qcategory_num = 0;
		
		if (qcategoryNum!=null)
			qcategory_num = Integer.parseInt(qcategoryNum);
		
		if (qcategoryNum==null)
			count = dao.count();
		else
			count = dao.searchCount(qcategory_num);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int start = (currentPage - 1) * 15 + 1;
		int end = currentPage * 15;
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		// 각 페이지에 맞는 자주 묻는 질문 리스트
		if (qcategoryNum==null)
			mav.addObject("list", dao.list(start, end));
		else
		{
			mav.addObject("list", dao.searchList(start, end, qcategory_num));
			param += "?qcategoryNum=" + qcategory_num;
		}
			
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "userfaqlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		mav.addObject("pageList", pageList);
		
		mav.setViewName("/WEB-INF/userView/UserFAQList.jsp");
		
		return mav;
	}
	
}



