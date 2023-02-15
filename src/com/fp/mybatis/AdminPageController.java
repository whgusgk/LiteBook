// AdminController

package com.fp.mybatis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fp.dto.AdminDTO;
import com.fp.util.sessionCheck;

@Controller
@SessionAttributes("adminSession")
public class AdminPageController
{
	// 의존성 주입
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 폼 요청
	@RequestMapping(value = "/adminloginform.action", method = RequestMethod.GET)
	public String adminLoginForm()
	{
		String result = null;
		
		result = "/WEB-INF/adminView/AdminLoginForm.jsp";

		return result;
	}
	
	// 입력한 아이디와 비밀번호 일치여부 확인 - 일치하면 아이디 출력
	@RequestMapping(value = "/ssncheck.action", method = RequestMethod.POST)
	public String ssnCheck(ModelMap model, String admin_id, String admin_pw)
	{	
		String result = null;
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		String searchId = String.valueOf(dao.searchId(admin_id));	// 0이면 없음, 1인 경우 아이디 존재
		
		// 입력한 아이디와 패스워드가 동일한 경우
		
		if(dao.searchId(admin_id).contains("1"))	// 아이디가 존재할 때
		{
			//String searchSsn = dao.searchPw(admin_id, admin_pw);
			model.addAttribute("ssn", dao.searchPw(admin_id, admin_pw));
			result = "/WEB-INF/adminView/SsnCheck.jsp";
		}
		else	// 아이디가 존재하지 않을 때
		{
			model.addAttribute("ssn", "1");
			result = "/WEB-INF/adminView/SsnCheck.jsp";
		}
		
		
		return result;
	}
	
	
	// 관리자 번호로 관리자 개인정보 조회 - 로그인
	// 메인페이지 > 개인정보 메뉴
	@RequestMapping(value = "/adminmyinfo.action", method = RequestMethod.GET)
	public String AdminList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String admin_num = session.getAttribute(request, response);
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		model.addAttribute("list", dao.searchAccount(admin_num)); 
		result = "/WEB-INF/adminView/AdminMyInfo.jsp";
		
		return result;
	}
	
	// 관리자 개인정보 수정 폼 요청
	@RequestMapping(value = "adminmyinfoupdateform.action")
	public String AdminInfoUpdateForm(HttpServletRequest request, Model model, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String admin_num = session.getAttribute(request, response);
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		
		model.addAttribute("list", dao.searchAccount(admin_num)); 
		result = "/WEB-INF/adminView/AdminMyInfoUpdateForm.jsp";
		
		return result;
	}
	
	// 관리자 개인정보 수정 액션
	@RequestMapping(value = "adminmyinfoupdate.action")
	public String AdminInfoUpdate(HttpServletRequest request, AdminDTO dto, HttpServletResponse response)
	{
		String result = null;
		
		// 세션 확인
		sessionCheck session = new sessionCheck();
		String admin_num = session.getAttribute(request, response);
		
		IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
		AdminDTO update = new AdminDTO();
		
		if(dto.getAdmin_birth()!=null)
			update.setAdmin_birth(dto.getAdmin_birth());
		else
			update.setAdmin_birth("");
		
		update.setAdmin_email(dto.getAdmin_email());
		update.setAdmin_name(dto.getAdmin_name());
		update.setAdmin_tel(dto.getAdmin_tel());
		update.setAdmin_num(admin_num);
		update.setGender_num(dto.getGender_num());
		
		dao.update(update);
		
		return "redirect:adminmyinfo.action";
	}
	
}





