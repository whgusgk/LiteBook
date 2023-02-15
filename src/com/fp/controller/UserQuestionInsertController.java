package com.fp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IServiceDAO;
import com.fp.dto.QnaDTO;

public class UserQuestionInsertController implements Controller
{
	private IServiceDAO dao;
	
	public void setDao(IServiceDAO dao)
	{
		this.dao = dao;
	}

	// 질문하기 insert 액션
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
		
		// 이전 페이지에서 사용자가 입력한 값 가져오기
		//-- 질문 카테고리(qcategory), 제목(title), 내용(content), 사용자 등록번호
		String qcategoryStr = request.getParameter("qcategory");
		String title = request.getParameter("title");
		String content = request.getParameter("content");	
		int result = 0;
		int qcategory = Integer.parseInt(qcategoryStr);
		try
		{
			QnaDTO dto = new QnaDTO();
			dto.setQcategory_num(qcategory);
			dto.setQuestion_title(title);
			dto.setQuestion_content(content);
			result = dao.insert(dto, sign_num);
			
			if(result!=0)
				mav.setViewName("redirect:userfaqlist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}



