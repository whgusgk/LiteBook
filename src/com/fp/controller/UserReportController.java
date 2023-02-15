package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserReportDAO;
import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.ReportDTO;

public class UserReportController implements Controller
{
	private IUserReportDAO dao;
	
	public void setDao(IUserReportDAO dao)
	{
		this.dao = dao;
	}

	// 다른 회원의 게시글 신고하기 인서트 요청 시
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 확인 
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		  
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		int result;
		
		// 타입, 번호 가져오기
		String num = request.getParameter("num");
		String type = request.getParameter("type");
		
		// 제목, 신고사유 번호, 내용 가져오기
		String title = request.getParameter("title");
		String report_reason = request.getParameter("infoReason");
		
		String report_content = request.getParameter("content");
		  
		if (report_content == "" || report_content == null) report_content = " ";
		 
		
		ReportDTO rdto = new ReportDTO();
		
		if(type.contains("book")) // type == "book"
		{
			BookDTO dto = new BookDTO();
			dto.setSign_num(sign_num);
			dto.setBook_num(Integer.parseInt(num));
			dto.setBreport_content(report_content);
			rdto.setReason_num(report_reason);
			rdto.setReport_title(title);
			
			result = dao.bInsert(dto, rdto);
			mav.setViewName("userallbooklist.action?type="+type+"&num="+num);
		}
		if(type.contains("card"))
		{
			CardDTO dto = new CardDTO();
			dto.setSign_num(sign_num);
			dto.setCard_num(Integer.parseInt(num));
			rdto.setReason_num(report_reason);
			rdto.setReport_title(title);
			rdto.setReport_content(report_content);
			
			result = dao.cInsert(dto, rdto);
		}
		if(type.contains("comment"))
		{
			CommentDTO dto = new CommentDTO();
			dto.setSign_num(sign_num);
			dto.setComment_num(num);
			rdto.setReason_num(report_reason);
			rdto.setReport_title(title);
			rdto.setReport_content(report_content);
			
			result = dao.coInsert(dto, rdto);
		}
		
		// 신고 완료 후 내가 신고한 내역페이지로 이동
		mav.setViewName("usermyreport.action");
		
		return mav;
	}
	
}
