package com.fp.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController
{
	// 의존성 주입
	@Autowired
	public SqlSession sqlSession;
	
	/* Admin 관리자 */
	
	// 로그인 요청
	@RequestMapping(value = "/adminlogin.action")
	public ModelAndView adminLogin(String admin_id, String admin_pw, HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView mav = new ModelAndView();
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		HttpSession session = request.getSession();
		session.setAttribute("adminSession", dao.sessionAdminNum(admin_id));
		
		mav.setViewName("redirect:adminmain.action");
		
		return mav;
	}
	
	// 로그아웃 요청
	@RequestMapping(value = "/adminlogout.action")
	public String adminLogout(HttpSession session)
	{
		session.removeAttribute("adminSession");
		return "redirect:adminloginform.action";
	}
	
	
}







