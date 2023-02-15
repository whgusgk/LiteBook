package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.fp.dao.IUserPageDAO;
import com.fp.dto.LikedDTO;
import com.fp.dto.UserDTO;
import com.fp.util.Pagination;

public class UserMyPageLikedbookController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}
	private IUserPageDAO userDao;
	
	
	public void setUserDao(IUserPageDAO userDao)
	{
		this.userDao = userDao;
	}


	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		Pagination page = new Pagination();
		
		UserDTO user = new UserDTO();
		ArrayList<String> fregionList = new ArrayList<String>();
		ArrayList<String> fcategoryList = new ArrayList<String>();
		ArrayList<LikedDTO> likeBookList = new ArrayList<LikedDTO>();
		
		String sign_num = (String)session.getAttribute("userSession");
		
		String pageNum = "";
		
		// 페이징 작업
		int currentPage = 1;
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			pageNum = request.getParameter("pageNum");
			
			if (pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
			
			int lcount = userDao.liked(sign_num);
			int ccount = userDao.comment_Count(sign_num);
			int bcount = userDao.book_Count(sign_num);
			int wcount = userDao.warning_Count(sign_num);
			
			int count = dao.likedBookCount(sign_num);
			
			int totalPage = page.PageCount(count);
			
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage -1) * 15 + 1;
			int end = currentPage * 15;
			
			// 페이징 문자열
			String pageUrl = "usermypagelikedbook.action";
			
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
			mav.addObject("pageList", pageList);
			
			// 제목을 눌렀을 때 이동할 링크 구성
			String bookUrl = "userbook.action?pageNum=" + currentPage;
			mav.addObject("bookUrl", bookUrl);

			// 마이페이지 상단에 들어갈 정보 처리
			user = dao.search(sign_num);
			fregionList = dao.searchFregion(sign_num);
			fcategoryList = dao.searchFcategory(sign_num);
			
			mav.addObject("user", user);
			mav.addObject("fregionList", fregionList);
			mav.addObject("fcategoryList", fcategoryList);

			// 좋아요를 누른 리스트
			likeBookList = dao.likedBookList(sign_num, start, end);
			
			mav.addObject("likeBookList", likeBookList);
			mav.addObject("lcount", lcount);
			mav.addObject("ccount", ccount);
			mav.addObject("bcount", bcount);
			mav.addObject("wcount", wcount);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserMyPageLikedbook.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}
