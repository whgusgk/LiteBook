package com.fp.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fp.dto.FaqDTO;
import com.fp.util.Pagination;
import com.fp.util.sessionCheck;

@Controller
public class AdminFaqController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 자주묻는질문 리스트 페이지 요청
	@RequestMapping(value = "/adminfaqlist.action", method = RequestMethod.GET)
	public String FaqList(String qcategoryNum, String pageNum, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminFaqDAO dao = sqlSession.getMapper(IAdminFaqDAO.class);
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
			model.addAttribute("list", dao.list(start, end));
		else
		{
			model.addAttribute("list", dao.searchList(start, end, qcategory_num));
			param += "?qcategoryNum=" + qcategory_num;
		}
			
		// 페이징 번호를 눌렀을 때 이동할 링크 구성
		String pageUrl = "adminfaqlist.action" + param;
		
		// 페이징 문자열
		String pageList = page.getIndexList(currentPage, totalPage, pageUrl);
		
		model.addAttribute("pageList", pageList);
		
		return "/WEB-INF/adminView/AdminFAQList.jsp";
	
	}
	
	// 자주묻는 질문 인서트 폼 요청
	@RequestMapping(value = "adminfaqinsertform.action")
	public String FaqInsertForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		return "/WEB-INF/adminView/AdminFAQInsertForm.jsp";
	}
	
	// 자주묻는 질문 인서트 액션 요청
	@RequestMapping(value = "adminfaqinsert.action", method = RequestMethod.POST)
	public String FaqInsert(FaqDTO faq, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		IAdminFaqDAO dao = sqlSession.getMapper(IAdminFaqDAO.class);
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String adminNum = session.getAttribute(request, response);
		int admin_num = Integer.parseInt(adminNum); 
		
		//HttpSession session = request.getSession();
		//int admin_num = (int)session.getAttribute("admin_num");
		
		faq.setAdmin_num(admin_num);
		dao.insert(faq);
		
		return "redirect:adminfaqlist.action";
	}
	
	// 자주묻는질문 수정 폼 요청
	@RequestMapping(value = "adminfaqupdateform.action", method = RequestMethod.GET)
	public String FaqUpdateForm(int faq_num, ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminFaqDAO dao = sqlSession.getMapper(IAdminFaqDAO.class);
		model.addAttribute("faq", dao.search(faq_num));
		
		return "/WEB-INF/adminView/AdminFAQUpdateForm.jsp";
	}
	

	
	
	
	
	

}
