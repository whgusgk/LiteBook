package com.fp.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IMyPageDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserFileUploadController implements Controller
{
	private IMyPageDAO dao;
	
	public void setDao(IMyPageDAO dao)
	{
		this.dao = dao;
	}

	// 회원 프로필 사진 변경 요청
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		int result = 0;
		
		// 세션 확인
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		String uploadFile = request.getParameter("uploadFile");
		
		// 실제 파일 저장 경로 설정
		// 루트 확인 필요 ▼
		//String savePath = "C:\\SpringMVCStudy\\finalProject\\WebContent\\profile"; - 테스트
		String savePath = request.getServletContext().getRealPath("profile");
		String contextPath = request.getServletContext().getContextPath();	// 프로젝트 위치
		String userProfile = null;	// DB에 들어갈 변수 : 위치
		
		// 파일 객체 생성 → 파일 저장 경로 전달							  
		File dir = new File(savePath);			
									  
		// 경로상 디렉터리가 존재하지 않으면 생성한다.
		if (!dir.exists())
			dir.mkdirs();
		
		// 인코딩 방식(UTF-8)과 파일 저장 시 최대 크기(10MB) 지정
		String encType = "UTF-8";
		int maxFileSize = 10*1024*1024;
		
		MultipartRequest req = null;
		String urlFile = "";
		
		try
		{
			// MultipartRequest 객체의 생성자에 전달하는 인자 리스트
			// → request, 파일저장경로, 최대크기, 인코딩방식, 중복파일명처리정책
			req = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
					
			String serverFileName = req.getFilesystemName("uploadFile");
			//String userProfile = "profile//" + serverFileName;
			userProfile = contextPath + "/profile/" + serverFileName; // DB에 저장할 값
			
			// 요청 객체(request)를 활용하여 생성한 MultipartRequest 객체로부터
			// 얻어낸 파일 객체 생성
			File f = req.getFile("uploadFile");
			
			result = dao.profileUpdate(sign_num, userProfile);
			
			
				mav.setViewName("redirect:usermyinfoupdateform.action");
			
			
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
