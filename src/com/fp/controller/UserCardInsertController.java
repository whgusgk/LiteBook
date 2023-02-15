package com.fp.controller;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.fp.dao.IUserCardDAO;
import com.fp.dao.IUserNoteDAO;
import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserCardInsertController implements Controller
{
	private IUserCardDAO dao;
	private IUserNoteDAO noteDao;
	
	public void setDao(IUserCardDAO dao)
	{
		this.dao = dao;
	}
	public void setNoteDao(IUserNoteDAO noteDao)
	{
		this.noteDao = noteDao;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sign_num = (String)session.getAttribute("userSession");
		
		if (session.getAttribute("userSession")==null)
		{
			mav.setViewName("redirect:userloginform.action");
			return mav;
		}
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		// 실제 파일 저장 경로 설정
		String savePath = request.getServletContext().getRealPath("cardImages");
		// 프로젝트 저장 위치
		String contextPath = request.getServletContext().getContextPath();
		String card_img1 = null;
		String card_img2 = null;
		String card_img3 = null;
		
		// 파일 객체에 파일 저장 경로 전달
		File dir = new File(savePath);

		// 폴더가 없으면 만들어줘!
		if (!dir.exists())
			dir.mkdirs();
		
		// 인코딩 방식과 파일 최대 크기(10MB) 지정
		String encType = "UTF-8";
		int maxFileSize = 10*1024*1024;
		
		MultipartRequest req = null;
		String urlFile = "";
		
		try
		{
			// MultipartRequest 객체의 생성자에게 인자 전달
			// -- request, 파일저장경로, 최대크기, 인코딩방식, 중복파일명처리정책
			req = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
			
			String serverFileName1 = req.getFilesystemName("uploadFile1");
			String serverFileName2 = req.getFilesystemName("uploadFile2");
			String serverFileName3 = req.getFilesystemName("uploadFile3");
			
			// DB에 저장될 링크 (업로드 된 내용이 있다면)
			if (req.getFilesystemName("uploadFile1") != null)
				card_img1 = contextPath + "/cardImages/" + serverFileName1;
			
			if (req.getFilesystemName("uploadFile2") != null)
				card_img2 = contextPath + "/cardImages/" + serverFileName2;
			
			if (req.getFilesystemName("uploadFile2") != null)
				card_img3 = contextPath + "/cardImages/" + serverFileName3;
			
			// 저장할 데이터 변수에 옮겨 담기 (카드)
			String card_lat = req.getParameter("lat");
			String card_lng = req.getParameter("lng");
			String card_address = req.getParameter("address");
			String card_location = req.getParameter("place");
			String card_budget = req.getParameter("budget");
			String card_comment = req.getParameter("memo");
			String day = req.getParameter("day");
			String open_num = req.getParameter("switch");
			String hour = req.getParameter("hour");
			String minute = req.getParameter("minute");
			String place_url = req.getParameter("place_url");
			
			String note_num = req.getParameter("note_num");
			
			// card_visitdate 추가 가공
			Date visitDate = format.parse(day);
			String card_visitdate = format.format(visitDate);
			
			// open_num 추가 가공 (비공개일 경우)
			if (open_num==null)
				open_num = "2";
			
			// card_time 추가 가공 (시와 분 합치기)
			String card_time = hour + minute;
			
			// CardDTO에 담기
			CardDTO card = new CardDTO();
			card.setSign_num(sign_num);
			card.setCard_lat(card_lat);
			card.setCard_lng(card_lng);
			card.setCard_address(card_address);
			card.setCard_location(card_location);
			card.setCard_budget(card_budget);
			card.setCard_comment(card_comment);
			card.setCard_img1(card_img1);
			card.setCard_img2(card_img2);
			card.setCard_img3(card_img3);
			card.setCard_visitdate(card_visitdate);
			card.setOpen_num(open_num);
			card.setCard_time(card_time);
			card.setPlace_url(place_url);
			card.setNote_num(Integer.parseInt(note_num));

			dao.cardInsert(card);
			
			// startdate와 lastdate를 add 해주기 위한 과정
			NoteDTO note = new NoteDTO();
			
			note = noteDao.search(note_num);
			String startDate = note.getNote_startdate();
			String lastDate = note.getNote_lastdate();
			
			mav.addObject("note_num", note_num);
			mav.addObject("startdate", startDate);
			mav.addObject("lastdate", lastDate);
			
			mav.setViewName("redirect:usernoteupdateform.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return mav;
	}
}
