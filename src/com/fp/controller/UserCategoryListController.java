
package com.fp.controller;

//import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
//import com.fp.dto.UserDTO;



// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class UserCategoryListController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		//ArrayList<UserDTO> result = new ArrayList<UserDTO>();
		
		//result = dao.regionList();
		
		mav.addObject("list", dao.regionList());
		mav.addObject("tlist", dao.tcategoryList());
		mav.setViewName("/WEB-INF/userView/UserResiForm.jsp");
		
	  return mav;
	}			
	
}
