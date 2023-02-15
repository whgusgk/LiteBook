package com.fp.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fp.dto.AdminMemberDTO;
import com.fp.util.Pagination3;
import com.fp.util.sessionCheck;


@Controller
public class AdminMemberController
{
	@Autowired
	private SqlSession sqlSession;

	// 회원관리 리스트 페이지 요청
	@RequestMapping(value="/adminmemberlist.action", method = RequestMethod.GET)
	public String adminMemberList(Model model, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		
		
		// 총 게시물 개수
		int count = dao.memberCount();
		
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
		model.addAttribute("memberList", dao.memberList(start, end));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminmemberlist.action" + param;
		
		if (param.equals(""))
			pageUrl = pageUrl + "?pageNum=" + currentPage;
		else
			pageUrl = pageUrl + param + "&pageNum=" + currentPage;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
	
		model.addAttribute("pageList", pageList);
		model.addAttribute("memberCount", dao.memberCount());
		
		result = "/WEB-INF/adminView/AdminMemberList.jsp";
				
		return result;
	}
	
	// 회원관리 > 여행책 리스트 페이지 요청
	@RequestMapping(value="/adminmemberbooklist.action", method = RequestMethod.GET)
	public String memberInfo(Model model, String sign_num, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		int count = dao.memberBookCount(sign_num);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		model.addAttribute("memberInfo", dao.memberInfo(sign_num));
		model.addAttribute("bookList", dao.bookList(sign_num, start, end));
		model.addAttribute("memberBookCount", dao.memberBookCount(sign_num));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
			param += "?sign_num=" + sign_num;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminmemberbooklist.action" + param;
		
		if (param.equals(""))
			pageUrl = pageUrl + "?pageNum=" + currentPage;
		else
			pageUrl = pageUrl + param + "&pageNum=" + currentPage;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
	

		result = "/WEB-INF/adminView/AdminMemberBookList.jsp";
		
		return result;
		
	}
	
	// 회원관리 > 여행카드 리스트 페이지 요청
	@RequestMapping(value="/adminmembercardlist.action", method = RequestMethod.GET)
	public String memberCardList(Model model, String sign_num, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		//------------------------------------------------------------------------------
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		if (pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		// 총 게시물 개수
		int count = dao.memberCardCount(sign_num);
		
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
		
		model.addAttribute("cardList", dao.cardList(sign_num, start, end));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		param += "?sign_num=" + sign_num;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminmembercardlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
		
		model.addAttribute("memberInfo", dao.memberInfo(sign_num));		
		model.addAttribute("memberCardCount", dao.memberCardCount(sign_num));
	
		
		result = "/WEB-INF/adminView/AdminMemberCardList.jsp";
		
		return result;
		
		//-------------------------------------------------------------------------------
	}
	
	// 회원관리 > 댓글 리스트 페이지 요청
	@RequestMapping(value="/adminmembercommentlist.action", method = RequestMethod.GET)
	public String memberCommentList(Model model, String sign_num, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		int count = dao.memberCommentCount(sign_num);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		model.addAttribute("memberInfo", dao.memberInfo(sign_num));
		model.addAttribute("commentList", dao.commentList(sign_num, start, end));
		model.addAttribute("memberCommentCount", dao.memberCommentCount(sign_num));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
			param += "?sign_num=" + sign_num;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminmembercommentlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
	

		result = "/WEB-INF/adminView/AdminMemberCommentList.jsp";
		
		return result;
		
	}
	
	// 회원관리 > 댓글 리스트 페이지 요청
	@RequestMapping(value="/adminmemberwarninglist.action", method = RequestMethod.GET)
	public String memberWarningList(Model model, String sign_num, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		model.addAttribute("memberInfo", dao.memberInfo(sign_num));
		model.addAttribute("warningList", dao.warningList(sign_num));
		model.addAttribute("memberWarningCount", dao.memberWarningCount(sign_num));

		
		result = "/WEB-INF/adminView/AdminMemberWarningList.jsp";
		
		return result;
		
	}
	
	// 회원관리 > 경고이력 리스트 페이지 요청 
	@RequestMapping(value="/adminwarningcanclereasoninsertform.action", method= RequestMethod.GET)
	public String adminWarningCancleReasoninsert(HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		result = "/WEB-INF/adminView/AdminWarningCancleReasonInsertForm.jsp";
		return result;
	}
	
	// 회원관리 > 경고이력 > 여행책 경고해제 인서트 액션 요청
	@RequestMapping(value="/bwarningcancelinsert.action", method = RequestMethod.GET)
	public String bWarningCancelInsert(AdminMemberDTO admin, HttpServletRequest request, HttpServletResponse response)
	{
		String result =null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
			
		admin.setBstatus_num(admin.getStatus_num());
		
		if (admin.getCancel_memo()=="")
		{
			admin.setBcancel_memo("");
		}
		else
		{
			admin.setBcancel_memo(admin.getCancel_memo());
		}
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		dao.bWarningCancelInsert(admin);
		
		result = "redirect:adminmemberwarninglist.action?sign_num="+ admin.getSign_num();
		return result;
		
	}

	// 회원관리 > 경고이력 > 여행카드 경고해제 인서트 액션 요청
	@RequestMapping(value="/cwarningcancelinsert.action", method = RequestMethod.GET)
	public String cWarningCancelInsert(AdminMemberDTO admin, HttpServletRequest request, HttpServletResponse response)
	{
		String result =null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		admin.setCstatus_num(admin.getStatus_num());
		if (admin.getCancel_memo()=="")
		{
			admin.setCcancel_memo("");
		}
		else
		{
			admin.setCcancel_memo(admin.getCancel_memo());
		}

		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		dao.cWarningCancelInsert(admin);
		
		result = "redirect:adminmemberwarninglist.action?sign_num="+ admin.getSign_num();
		return result;
		
	}
	
	// 회원관리 > 경고이력 > 댓글 경고해제 인서트 액션 요청
	@RequestMapping(value="/cowarningcancelinsert.action", method = RequestMethod.GET)
	public String coWarningCancelInsert(AdminMemberDTO admin, HttpServletRequest request, HttpServletResponse response)
	{
		String result=null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		admin.setCostatus_num(admin.getStatus_num());
		
		if (admin.getCancel_memo()=="")
		{
			admin.setCocancel_memo("");
		}
		else
		{
			admin.setCocancel_memo(admin.getCancel_memo());
		}
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		
		dao.coWarningCancelInsert(admin);
		
		result = "redirect:adminmemberwarninglist.action?sign_num="+ admin.getSign_num();
		return result;
	}
	
	// 회원관리 리스트 페이지 - 하단 검색 필드에서 아이디로 검색 요청
	// 아이디로 검색한 결과 리스트 페이지 요청
	@RequestMapping(value="/idsearchmemberlist.action", method = RequestMethod.GET)
	public String adminIdSearchMemberList(Model model, String value, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		int count = dao.idMemberCount(value);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		model.addAttribute("memberList", dao.idSearchMemberList(value, start, end));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
			param += "?value=" + value;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "idadminmemberlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
	

		result = "/WEB-INF/adminView/AdminMemberList.jsp";
		
		return result;
		
	}
	
	// 회원관리 리스트 페이지 - 하단 검색 필드에서 닉네임으로 검색 요청
	// 닉네임으로 검색한 결과 리스트 페이지 요청
	@RequestMapping(value="/namesearchmemberlist.action", method = RequestMethod.GET)
	public String adminNameSearchMemberList(Model model, String value, String pageNum, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMemberDAO dao = sqlSession.getMapper(IAdminMemberDAO.class);
		Pagination3 page = new Pagination3();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		int count = dao.nameMemberCount(value);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 이동 시에 삭제되어 전체 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 가져올 게시글의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		model.addAttribute("memberList", dao.nameSearchMemberList(value, start, end));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
			param += "?value=" + value;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "nameadminmemberlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
	

		result = "/WEB-INF/adminView/AdminMemberList.jsp";
		
		return result;
	}
	
	
}
