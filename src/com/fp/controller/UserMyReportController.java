package com.fp.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IServiceDAO;
import com.fp.dto.ReportDTO;
import com.fp.util.Pagination;


public class UserMyReportController implements Controller
{
	private IServiceDAO dao;
	
	public void setDao(IServiceDAO dao)
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
		
		Pagination page = new Pagination();
		
		
		ArrayList<ReportDTO> reportList = new ArrayList<ReportDTO>();
		
		String pageNum = "";
		
		// 페이징 작업
		int currentPage = 1;
		
		try
		{
			// 이전 페이지로부터 데이터 수신
			pageNum = request.getParameter("pageNum");
			
			if (pageNum!=null)
				currentPage = Integer.parseInt(pageNum);
			
			int count = dao.reportCount(sign_num);
			mav.addObject("count", count);
			
			int totalPage = page.PageCount(count);
			
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage-1) * 15 + 1;
			int end = currentPage * 15;
			
			// 페이징 문자열
			String pageUrl = "usermyreport.action";
			
			String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
			mav.addObject("pageList", pageList);
			
			// 제목을 눌렀을 때 이동할 링크 구성
			String reportUrl = "userreport.action?pageNum=" + currentPage;
			mav.addObject("reportUrl", reportUrl);
			
			// 신고 리스트
			reportList = dao.reportList(sign_num, start, end);
			
			mav.addObject("reportList", reportList);
			
			// 뷰 페이지 set
			mav.setViewName("/WEB-INF/userView/UserMyReport.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}
