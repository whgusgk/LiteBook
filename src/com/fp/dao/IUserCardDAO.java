package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.fp.dto.PayDTO;

public interface IUserCardDAO
{
	public int cardInsert(CardDTO card) throws SQLException;
	public int maxCard(String sign_num) throws SQLException;
	public int payInsert(PayDTO pay) throws SQLException;
	
	public int cardUpdate(CardDTO card) throws SQLException;
	public int payUpdate(PayDTO pay) throws SQLException;
	
	// 생성일이 없을 경우 아예 삭제, 생성일이 있을 경우 바인딩 삭제
	public int delete(String card_num) throws SQLException;
	public int payDelete(String pay_num) throws SQLException;
	
	public CardDTO search(String card_num) throws SQLException;
	public ArrayList<PayDTO> paySearch(String card_num) throws SQLException;
	
	public NoteDTO searchNotedNote(String card_num) throws SQLException;
	
}
