package com.fp.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserBookDAO;
import com.fp.dto.BookDTO;
import com.fp.dto.NoteDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserBookUpdateController implements Controller
{
	//추후 인기여행책 리스트를 위한 UserBookDAO관련 처리 필요
	private IUserBookDAO dao;
	
	public void setDao(IUserBookDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
	 
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		
		//실제 파일 저장 경로 설정
		String savePath = request.getServletContext().getRealPath("bookImages");
		//프로젝트 저장 위치
		String contextPath = request.getServletContext().getContextPath();
		String book_cover = null;
		

		//파일 객체에 파일 저장 경로 전달
		File dir = new File(savePath);
		
		//폴더가 없으면 만들 것
		if(!dir.exists())
			dir.mkdirs();
		
		//인코딩 방식과 파일 최대 크기(10MB)지정
		String encType = "UTF-8";
		int maxFileSize = 10*1024*1024;
		
		MultipartRequest req =null;
		String urlFile = "";
		
		try
		{
			// MultipartRequest 객체의 생성자에게 인자 전달
						// -- request, 파일저장경로, 최대크기, 인코딩방식, 중복파일명처리정책
			req = new MultipartRequest(request, savePath, maxFileSize, encType
									,	new DefaultFileRenamePolicy());
			String serverFileName = req.getFilesystemName("uploadFile");
			
			//DB에 저장될 링크(업로드된 내용이 있다면)
			if(req.getFilesystemName("uploadFile")!=null)
				book_cover = contextPath + "/bookImages/"+ serverFileName;
			
			//이전 페이지로부터 받아온 데이터 수신(책)
			String bcategory_num = req.getParameter("category");
			String book_title = req.getParameter("title");
			String book_comment = req.getParameter("comment");
			String bookNum = req.getParameter("bookNum");
			
			//bcategory_num , book_title, book_comment, sign_num, book_cover
			//저장할 데이터 변수에 옮겨담기(책)
			BookDTO book = new BookDTO();
			book.setBcategory_num(Integer.parseInt(bcategory_num));
			book.setBook_title(book_title);
			book.setBook_comment(book_comment);
			book.setSign_num(sign_num);
			book.setBook_cover(book_cover);
			book.setBook_num(Integer.parseInt(bookNum));
			
			int bookUpdateCheck = dao.update(book);
			if(bookUpdateCheck < 1)
				System.out.println("여행책 인서트 실패");
			
			//이전 페이지로부터 데이터 수신(여행카드 뭉치)
			String[] cardNums = req.getParameterValues("cardNum");
			String bcardNum = req.getParameter("bcardNum");
			int book_num = dao.maxBook(sign_num);
			for(int i=0; i<cardNums.length; i++)
			{	
				if(bcardNum.equals("0"))
				{
					dao.bookedCardInsert(String.valueOf(bookNum), cardNums[i]);
				}
			}
			
			mav.setViewName("redirect:userbooklist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return mav;
	}
}

