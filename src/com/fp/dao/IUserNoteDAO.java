package com.fp.dao;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.fp.dto.PayDTO;

public interface IUserNoteDAO 
{	
	public int count(String sign_num) throws SQLException;
	public ArrayList<NoteDTO> list(String sign_num, int start, int end) throws SQLException;
	
	public NoteDTO search(String note_num) throws SQLException;
	public int paySum(String note_num, int ptype_num) throws SQLException;
	
	public int dayCount(String startdate, String lastdate) throws SQLException, ParseException;
	public HashMap<Integer, String> dateCal(int day, String startdate) throws SQLException, ParseException;
	public ArrayList<CardDTO> dayCardList(String note_num, String card_visitdate) throws SQLException;
	
	public int insert(NoteDTO note) throws SQLException, NullPointerException;
	public int max(String sign_num) throws SQLException;
	
	// 생성일이 없어도 카트의 방문일을 기준으로 조회 (카드 최초 입력)
	public ArrayList<CardDTO> dayCardListAll(String note_num, String card_visitdate) throws SQLException;
	
	public int update(NoteDTO note) throws SQLException;
	public int delete(String note_num) throws SQLException;
	
	// 노트 업데이트 취소했을 때 생성일이 없는 카드 삭제
	public int cardDelete(String note_num) throws SQLException;
	
}
