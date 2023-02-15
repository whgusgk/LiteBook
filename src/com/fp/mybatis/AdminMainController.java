package com.fp.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fp.util.sessionCheck;


@Controller
public class AdminMainController
{
	@Autowired
	private SqlSession sqlSession;

	// 관리자 메인페이지 요청
	@RequestMapping(value="/adminmain.action", method = RequestMethod.GET)
	public String adminMain(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		session.getSession(request, response);
		
		IAdminMainDAO dao = sqlSession.getMapper(IAdminMainDAO.class);
		
		model.addAttribute("memberCount", dao.memberCount());
		model.addAttribute("bookCount", dao.bookCount());
		model.addAttribute("newReportList", dao.newReportList());
		model.addAttribute("newQuestionList", dao.newQuestionList());
		
		result = "/WEB-INF/adminView/AdminMain.jsp";
		
		return result;
		
	}

	
}
