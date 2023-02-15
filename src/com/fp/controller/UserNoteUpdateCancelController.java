package com.fp.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

//import com.fp.util.sessionCheck;
import com.fp.dao.IUserNoteDAO;

public class UserNoteUpdateCancelController implements Controller
{
	private IUserNoteDAO dao;

	public void setDao(IUserNoteDAO dao)
	{
		this.dao = dao;
	}



	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		// 세션 처리 과정 추가(로그인에 대한 확인 과정 추가) --------------------------
		//sessionCheck session = new sessionCheck();
		//String sign_num = (String)session.getUserAttribute(request, response);
		
		 HttpSession session = request.getSession();
	   
	      if (session.getAttribute("userSession")==null)
	      {
	         mav.setViewName("redirect:userloginform.action");
	         return mav;
	      }

		// -------------------------- 세션 처리 과정 추가(로그인에 대한 확인 과정 추가)
		
		try
		{
			// 이전 페이지(UserNote.jsp)로부터 데이터 수신
			// -- note_num
			
			String note_num = request.getParameter("note_num");

			dao.cardDelete(note_num);

			mav.setViewName("redirect:usernotelist.action");

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;

	}

}
