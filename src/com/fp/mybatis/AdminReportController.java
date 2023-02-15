// AdminReportController

package com.fp.mybatis;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fp.dto.ReportDTO;
import com.fp.util.Pagination;
import com.fp.util.sessionCheck;

@Controller
@SessionAttributes("adminSession")
public class AdminReportController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 신고처리 메뉴 - AdminReportList 신고 내역 리스트 출력
	@RequestMapping(value = "/adminreportlist.action", method = RequestMethod.GET)
	public String adminReportList(ModelMap model, String cstatusnum, String pageNum, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		String result = null;
		
		// 세션 확인 - 세션 없는 경우 로그인 폼으로 전환
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);

		// 페이징 처리
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		if (pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		// 총 게시물 개수
		int count = 0;
		if(cstatusnum == null || cstatusnum.contains("2")) 
		{
			count = dao.count();
		}
		else if(cstatusnum.contains("0")) 
		{
			count = dao.noneChekcount();
		}
		else if(cstatusnum.contains("1"))
		{
			count = dao.Checkcount();
		}
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제된다면!
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		// 가져올 게시글의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		// dao.list()를 쓰기 위한 형변환
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		// 리스트 출력
		if(cstatusnum == null || cstatusnum.contains("2")) 
		{
			model.addAttribute("list", dao.list(start, end));
		}
		else if(cstatusnum.contains("0")) 
		{
			cstatusnum = "미처리";
			//String cstatus_num = cstatusnum;
			model.addAttribute("list", dao.reportlist(cstatusnum, start, end));
		}
		else if(cstatusnum.contains("1"))
		{
			cstatusnum = "처리완료";
			//String cstatus_num = cstatusnum;
			model.addAttribute("list", dao.reportlist(cstatusnum, start, end));
		}
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		if (cstatusnum != null)
			param += "?cstatusnum=" + cstatusnum;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminreportlist.action";
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 제목을 눌렀을 때 이동할 링크 구성
		String reportUrl = "adminreportlist.action?pageNum=" + currentPage;
		
		if (param.equals(""))
			reportUrl = reportUrl + "?pageNum=" + currentPage;
		else
			reportUrl = reportUrl + param + "&pageNum=" + currentPage;
		
		model.addAttribute("pageList", pageList);
		//model.addAttribute("reportUrl", reportUrl);
		
		return "WEB-INF/adminView/AdminReportList.jsp";
	}
	
	// 신고처리 메뉴 - 신고된 게시글 검색 결과 페이지 요청(신고자 닉네임으로 검색)
	@RequestMapping(value = "/adminreportsearchlist.action", method = RequestMethod.GET)
	public String adminReportSearchList(ModelMap model, String keyword, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);
		
		model.addAttribute("list", dao.searchList(keyword));
		model.addAttribute("count", dao.count());
		
		return "WEB-INF/adminView/AdminReportList.jsp";
	}
	
	// 신고처리 메뉴 - 신고된 게시글 처리 폼 요청
	@RequestMapping(value = "/reportwarningreasoninsertform.action")
	public String adminReportWarningReasonInsertForm(ModelMap model, String type, String report_num, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);
		
		if(type.contains("book"))
		{
			model.addAttribute("report", dao.searchReportNum(type, report_num));
		}
		else if(type.contains("comment"))
		{
			model.addAttribute("report", dao.searchReportNum(type, report_num));
		}
		else if(type.contains("card"))
		{
			model.addAttribute("report", dao.searchReportNum(type, report_num));
		}
		
		result = "WEB-INF/adminView/AdminReportWarningReasonInsertForm.jsp";
		
		return result;
	}
	
	// 신고처리 메뉴 - 신고된 게시글 처리 인서트 액션(신고처리완료)
	@RequestMapping(value = "/reportwarningreasoninsert.action")
	public String reportWarningReasonInsert(ReportDTO dto, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String admin_num = session.getAttribute(request, response);
		
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);
		
		ReportDTO report = new ReportDTO();
		
		String type = dto.getType();
		
		if(type.contains("book"))
		{
			report.setAdmin_num(admin_num);
			report.setReport_num(dto.getReport_num());
			report.setType_num(dto.getType_num());
			dao.bStatusInsert(report);
		}
		else if(type.contains("comment"))
		{
			report.setAdmin_num(admin_num);
			report.setReport_num(dto.getReport_num());
			report.setType_num(dto.getType_num());
			dao.coStatusInsert(report);
		}
		else if(type.contains("card"))
		{
			report.setAdmin_num(admin_num);
			report.setReport_num(dto.getReport_num());
			report.setType_num(dto.getType_num());
			dao.cStatusInsert(report);
		}
		
		result = "redirect:adminreportlist.action";
		
		return result;
	}
	
}












