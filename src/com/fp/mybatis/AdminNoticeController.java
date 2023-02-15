package com.fp.mybatis;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fp.dto.NoticeDTO;
import com.fp.util.Pagination;
import com.fp.util.sessionCheck;

@Controller
public class AdminNoticeController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 고객지원 > 공지사항 관리 리스트 페이지 요청
	@RequestMapping(value = "/adminnoticelist.action", method = RequestMethod.GET)
	public String NoticeList(String keyword, String pageNum, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminNoticeDAO dao = sqlSession.getMapper(IAdminNoticeDAO.class);
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
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		// dao.list()를 쓰기 위한 형변환
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		// 각 페이지에 맞는 공지사항 리스트
		model.addAttribute("list", dao.list(start, end, keyword));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		if (!keyword.equals(""))
			param += "?keyword=" + keyword;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminnoticelist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 제목을 눌렀을 때 이동할 링크 구성
		String noticeUrl = "adminnotice.action";
		
		if (param.equals(""))
			noticeUrl = noticeUrl + "?pageNum=" + currentPage;
		else
			noticeUrl = noticeUrl + param + "&pageNum=" + currentPage;
		
		model.addAttribute("pageList", pageList);
		model.addAttribute("noticeUrl", noticeUrl);
		
		return "/WEB-INF/adminView/AdminNoticeList.jsp";
	
	}
	
	// 공지사항 인서트 폼 요청
	@RequestMapping(value = "/adminnoticeinsertform.action")
	public String NoticeInsertForm(HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		return "/WEB-INF/adminView/AdminNoticeInsertForm.jsp";
	}
	
	// 공지사항 인서트 액션 요청
	@RequestMapping(value = "adminnoticeinsert.action", method = RequestMethod.POST)
	public String NoticeInsert(NoticeDTO notice, HttpServletRequest request, HttpServletResponse response)
	{
		IAdminNoticeDAO dao = sqlSession.getMapper(IAdminNoticeDAO.class);
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String adminNum = session.getAttribute(request, response);
		int admin_num = Integer.parseInt(adminNum); 
		
		//HttpSession session = request.getSession();
		//int admin_num = (int)session.getAttribute("admin_num");
		
		notice.setAdmin_num(admin_num);
		
		dao.insert(notice);
		
		return "redirect:adminnoticelist.action";
	}
	
	// 공지사항 세부열람 페이지 요청
	@RequestMapping(value = "adminnotice.action", method = RequestMethod.GET)
	public String NoticeSearch(int notice_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminNoticeDAO dao = sqlSession.getMapper(IAdminNoticeDAO.class);
		
		model.addAttribute("notice", dao.search(notice_num));
		
		return "/WEB-INF/adminView/AdminNotice.jsp";
	}
	
	// 공지사항 세부열람 페이지 수정폼 요청
	@RequestMapping(value = "adminnoticeupdateform.action")
	public String NoticeUpdateForm(int notice_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminNoticeDAO dao = sqlSession.getMapper(IAdminNoticeDAO.class);
		model.addAttribute("notice", dao.search(notice_num));
		
		return "/WEB-INF/adminView/AdminNoticeUpdateForm.jsp";
	}
	
	// 공지사항 세부열람 페이지 수정 액션 -- 수정 처리 안되어있음!!(※ 확인 필요)
	@RequestMapping(value = "adminnoticeupdate.action")
	public String NoticeUpdate(NoticeDTO notice, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		return "redirect:adminnoticelist.action";
	}
	
	

}
