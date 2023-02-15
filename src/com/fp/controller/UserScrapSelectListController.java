package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IScrapDAO;
import com.fp.dto.ScrapDTO;
import com.fp.util.Pagination;


public class UserScrapSelectListController implements Controller
{
	private IScrapDAO scrapDAO;

	public void setScrapDAO(IScrapDAO scrapDAO)
	{
		this.scrapDAO = scrapDAO;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) --------------------------
		
		HttpSession session = request.getSession();
	    session.getAttribute("userSession");
	      
	      if (session.getAttribute("userSession")==null)
	      {
	         mav.setViewName("redirect:userloginform.action");
	         return mav;
	      }


		// -------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)

		ArrayList<ScrapDTO> scrapSelectList = new ArrayList<ScrapDTO>();

		try
		{
			// 이전 페이지(UserBook.jsp)로부터 데이터 수신
			// -- book_num
			String book_num = request.getParameter("book_num");
			
			String pageNum = request.getParameter("pageNum"); // 다른 페이지 이동했을 때 페이지 번호

			Pagination page = new Pagination();

			// 현재 페이지
			int currentPage = 1;

			if (pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신

			String keyword = "";

			// 총 게시물 개수
			int count = scrapDAO.selectCardListCount(book_num);

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
			// String start = String.valueOf(startInt);
			// String end = String.valueOf(endInt);
			
			scrapSelectList= scrapDAO.selectCardList(start, end, book_num);

			// 페이지 링크 뒤에 붙을 매개변수 구성
			String param = "";

			if (!keyword.equals(""))
				param += "?keyword=" + keyword;

			// 페이징 번호를 눌렀을 때 이동할 링크 구성
			String pageUrl = "userscrapselectlist.action" + param;

			// 페이징 문자열
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);

			mav.addObject("pageList", pageList);

			mav.addObject("scrapSelectList", scrapSelectList );
			mav.setViewName("/WEB-INF/userView/UserScrapSelectList.jsp");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;

	}

}
