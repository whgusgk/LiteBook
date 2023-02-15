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

import com.fp.util.Pagination;
import com.fp.util.sessionCheck;

@Controller
public class AdminRecordController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 기록관리 > 여행카드 리스트 페이지 요청 
	@RequestMapping(value = "adminrecordcardlist.action", method = RequestMethod.GET)
	public String CardList(String keyword, String pageNum, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminRecordDAO dao = sqlSession.getMapper(IAdminRecordDAO.class);
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		if (pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		if (keyword != null)
			keyword = URLDecoder.decode(keyword, "UTF-8");
		else
			keyword = "";
		
		// 총 게시물 개수
		int count = dao.cardCount(keyword);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 페이지 이동 시에 게시글 하나가 삭제되어 총 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 리스트 한 페이지에 불러올 게시글 줄번호(RNUM)의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		// list() 메소드를 쓰기 위한 형 변환
		// 매개변수가 String 이기 때문!
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		// 각 페이지에 맞는 게시글 리스트를 출력할 수 있도록 model에 add
		model.addAttribute("list", dao.cardList(start, end, keyword));
		
		// 페이징 번호를 눌렀을 때 이동할 링크 뒤의 get 매개변수 값 지정
		String param = "";
		
		// 검색한 값이 있다면
		// get 방식으로 다시 넘겨줘서 목록으로 버튼을 눌렀을 때
		// 해당 검색 페이지로 다시 이동할 수 있도록 구성
		if (!keyword.equals(""))
			param += "?keyword=" + keyword;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminrecordcardlist.action" + param;
		
		// 페이징 문자열 (Pagination 클래스의 getIndexList 함수 참조)
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 리스트에서 제목을 눌렀을 때 이동할 링크 구성
		// <a>title</a>에 들어갈 예정
		// -- 현재 뷰페이지 없어서 임시로 주소 만들어 놓음
		String recordUrl = "adminrecordbook.action";
		
		// 검색한 값이 없다면
		// 게시글 열람 전에 머물렀던 페이지 번호로 다시 이동할 수 있도록 구성
		if (param.equals(""))
			recordUrl = recordUrl + "?pageNum=" + currentPage;
		else
			recordUrl = recordUrl + "&pageNum=" + currentPage;
		
		// 페이징 문자열과 a 태그에 사용할 Url model에 add
		model.addAttribute("pageList", pageList);
		model.addAttribute("recordUrl", recordUrl);
		
		return "/WEB-INF/adminView/AdminRecordCardList.jsp";
	}
	
	// 기록관리 > 여행카드 상세열람 페이지 요청 및 카드제목 검색 기능
	@RequestMapping(value = "adminrecordcard.action", method = RequestMethod.GET)
	public String CardSearch(int card_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminRecordDAO dao = sqlSession.getMapper(IAdminRecordDAO.class);
		
		model.addAttribute("card", dao.cardSearch(card_num));
		
		return "/WEB-INF/adminView/AdminRecordCard.jsp";
	}
	
	// 기록관리 > 여행책 리스트 페이지 요청 
	@RequestMapping(value = "adminrecordbooklist.action", method = RequestMethod.GET)
	public String BookList(String keyword, String pageNum, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminRecordDAO dao = sqlSession.getMapper(IAdminRecordDAO.class);
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		if (pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		if (keyword != null)
			keyword = URLDecoder.decode(keyword, "UTF-8");
		else
			keyword = "";
		
		// 총 게시물 개수
		int count = dao.bookCount(keyword);
		
		// 총 페이지
		int totalPage = page.PageCount(count);
		
		// 페이지 이동 시에 게시글 하나가 삭제되어 총 페이지 수가 줄어들었을 경우,
		// 표시할 페이지를 최대 페이지로 구성
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		// 리스트 한 페이지에 불러올 게시글 줄번호(RNUM)의 시작과 끝 번호
		int startInt = (currentPage - 1) * 15 + 1;
		int endInt = currentPage * 15;
		
		// list() 메소드를 쓰기 위한 형 변환
		// 매개변수가 String 이기 때문!
		String start = String.valueOf(startInt);
		String end = String.valueOf(endInt);
		
		// 각 페이지에 맞는 게시글 리스트를 출력할 수 있도록 model에 add
		model.addAttribute("list", dao.bookList(start, end, keyword));
		
		// 페이징 번호를 눌렀을 때 이동할 링크 뒤의 get 매개변수 값 지정
		String param = "";
		
		// 검색한 값이 있다면
		// get 방식으로 다시 넘겨줘서 목록으로 버튼을 눌렀을 때
		// 해당 검색 페이지로 다시 이동할 수 있도록 구성
		if (!keyword.equals(""))
			param += "?keyword=" + keyword;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminrecordbooklist.action" + param;
		
		// 페이징 문자열 (Pagination 클래스의 getIndexList 함수 참조)
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 리스트에서 제목을 눌렀을 때 이동할 링크 구성
		// <a>title</a>에 들어갈 예정
		// -- 현재 뷰페이지 없어서 임시로 주소 만들어 놓음
		String recordUrl = "adminrecordbook.action";
		
		// 검색한 값이 없다면
		// 게시글 열람 전에 머물렀던 페이지 번호로 다시 이동할 수 있도록 구성
		if (param.equals(""))
			recordUrl = recordUrl + "?pageNum=" + currentPage;
		else
			recordUrl = recordUrl + "&pageNum=" + currentPage;
		
		// 페이징 문자열과 a 태그에 사용할 Url model에 add
		model.addAttribute("pageList", pageList);
		model.addAttribute("recordUrl", recordUrl);
		
		return "/WEB-INF/adminView/AdminRecordBookList.jsp";
	}
	
	// 기록관리 > 여행책 상세열람 페이지 요청 및 책제목 검색 기능
	@RequestMapping(value = "adminrecordbook.action", method = RequestMethod.GET)
	public String BookSearch(int book_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminRecordDAO dao = sqlSession.getMapper(IAdminRecordDAO.class);
		
		model.addAttribute("book", dao.bookSearch(book_num));
		
		return "/WEB-INF/adminView/AdminRecordBook.jsp";
	}
}
