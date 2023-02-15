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

import com.fp.dto.QnaDTO;
import com.fp.util.Pagination;
import com.fp.util.sessionCheck;

@Controller
public class AdminQnaController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 고객지원 > 질문관리 리스트 페이지 요청
	@RequestMapping(value = "/adminquestionlist.action", method = RequestMethod.GET)
	public String QuestionList(String question_done, String pageNum, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
				
		IAdminQnaDAO dao = sqlSession.getMapper(IAdminQnaDAO.class);
		Pagination page = new Pagination();
		
		// 현재 페이지
		int currentPage = 1;
		
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		// -- 최초 요청이 아니라면 직전 열람 페이지로 갱신
		
		if (question_done != null)
			question_done = URLDecoder.decode(question_done, "UTF-8");
		else
			question_done = "";
		
		// 총 게시물 개수
		int count = dao.count(question_done);
		
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
		model.addAttribute("list", dao.list(start, end, question_done));
		
		// 페이지 링크 뒤에 붙을 매개변수 구성
		String param = "";
		
		if (!question_done.equals(""))
			param += "?question_done=" + question_done;
		
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminquestionlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		// 제목을 눌렀을 때 이동할 링크 구성
		String questionUrl = "adminquestion.action";
		
		if (param.equals(""))
			questionUrl = questionUrl + "?pageNum=" + currentPage;
		else
			questionUrl = questionUrl + param + "&pageNum=" + currentPage;
		
		model.addAttribute("pageList", pageList);
		model.addAttribute("questionUrl", questionUrl);
		
		return "/WEB-INF/adminView/AdminQuestionList.jsp";
	
	}
	
	// 고객지원 > 질문관리 - 게시글 상세열람 페이지 요청
	@RequestMapping(value = "adminquestion.action", method = RequestMethod.GET)
	public String QuestionSearch(int question_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminQnaDAO dao = sqlSession.getMapper(IAdminQnaDAO.class);
		
		model.addAttribute("question", dao.searchQuestion(question_num));
		
		return "/WEB-INF/adminView/AdminQuestion.jsp";
	}
	
	// 고객지원 > 질문관리 - 게시글 답변 폼 요청
	@RequestMapping(value = "adminquestionreplyform.action", method = RequestMethod.GET)
	public String AnswerInsertForm(int question_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminQnaDAO dao = sqlSession.getMapper(IAdminQnaDAO.class);
		
		model.addAttribute("question", dao.searchQuestion(question_num));
		
		return "/WEB-INF/adminView/AdminQuestionReplyForm.jsp";
		
	}
	
	// 고객지원 > 질문관리 - 게시글 답변 인서트 액션 요청
	@RequestMapping(value = "adminquestionreply.action", method = RequestMethod.POST)
	public String AnswerInsert(QnaDTO qna, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		IAdminQnaDAO dao = sqlSession.getMapper(IAdminQnaDAO.class);
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String adminNum = session.getAttribute(request, response);
		int admin_num = Integer.parseInt(adminNum); 
		
		qna.setAdmin_num(admin_num);
		dao.insert(qna);
		
		return "redirect:adminquestionlist.action";
	}
	
	
	
	

}
