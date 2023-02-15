package com.fp.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.sql.DataSource;

import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;

public class UserNoteDAO implements IUserNoteDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	@Override
	public int count(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM NOTE"
				  + " WHERE SIGN_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end count
	
	@Override
	public ArrayList<NoteDTO> list(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT RNUM, NOTE_NUM, NOTE_TITLE"
						+ ", TO_CHAR(NOTE_STARTDATE, 'YYYY-MM-DD') AS NOTE_STARTDATE"
						+ ", TO_CHAR(NOTE_LASTDATE, 'YYYY-MM-DD') AS NOTE_LASTDATE"
						+ ", TO_CHAR(NOTE_DATE, 'YYYY-MM-DD HH:MM') AS NOTE_DATE"
						+ ", SIGN_NUM"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT NOTE_NUM, NOTE_TITLE, NOTE_STARTDATE, NOTE_LASTDATE, NOTE_DATE, SIGN_NUM"
				  			  + " FROM NOTE"
				  			  + " WHERE SIGN_NUM = ?"
				  			  + " ORDER BY NOTE_REDATE DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNote_num(String.valueOf(rs.getInt("NOTE_NUM")));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_startdate(rs.getString("NOTE_STARTDATE"));
			dto.setNote_lastdate(rs.getString("NOTE_LASTDATE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end list
	
	@Override
	public NoteDTO search(String note_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_NUM, NOTE_TITLE"
						+ ", TO_CHAR(NOTE_STARTDATE, 'YYYY-MM-DD')  AS NOTE_STARTDATE"
						+ ", TO_CHAR(NOTE_LASTDATE, 'YYYY-MM-DD') AS NOTE_LASTDATE"
						+ ", TO_CHAR(NOTE_DATE, 'YYYY-MM-DD HH:MM') AS NOTE_DATE"
						+ ",REGION_NUM, REGION_NAME, NVL(NOTE_COMPANY, 0) AS NOTE_COMPANY, NVL(NOTE_BUDGET, 0) AS NOTE_BUDGET"
				  + " FROM VIEW_NOTESEARCH"
				  + " WHERE NOTE_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(note_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setNote_num(String.valueOf(rs.getInt("NOTE_NUM")));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_startdate(rs.getString("NOTE_STARTDATE"));
			result.setNote_lastdate(rs.getString("NOTE_LASTDATE"));
			result.setNote_date(rs.getString("NOTE_DATE"));
			result.setRegion_name(rs.getString("REGION_NAME"));
			result.setRegion_num(rs.getString("REGION_NUM"));
			result.setNote_company(String.valueOf(rs.getInt("NOTE_COMPANY")));
			result.setNote_budget(String.valueOf(rs.getString("NOTE_BUDGET")));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}// end search
	
	@Override
	public int paySum(String note_num, int ptype_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT SUM(PAY_AMOUNT) AS PAY_AMOUNT"
				  + " FROM VIEW_PAYSUM"
				  + " WHERE NOTE_NUM = ?"
				    + " AND PTYPE_NUM = ?"
				  + " GROUP BY PTYPE_NUM";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(note_num));
		pstmt.setInt(2, ptype_num);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("PAY_AMOUNT");

		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end paySum
	
	@Override
	public int dayCount(String startdate, String lastdate) throws SQLException, ParseException
	{
		int result = 0;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");

		Date start = format.parse(startdate);
		Date end = format.parse(lastdate);

		long daySec = end.getTime() - start.getTime();

		result = (int)(daySec / (24*60*60*1000));
		result++;
		
		return result;
		
	}// end dayCount
	
	@Override
	public HashMap<Integer, String> dateCal(int day, String startdate) throws SQLException, ParseException
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		HashMap<Integer, String> result = new HashMap<Integer, String>();
		result.put(1, startdate);
		
		// 문자열로 받아온 시작일을 연월일로 찢어주는 과정
		String[] strArr = startdate.split("-");
		
		int year = Integer.parseInt(strArr[0]);
		int month = Integer.parseInt(strArr[1])-1;
		int date = Integer.parseInt(strArr[2]);
		
		cal.set(year, month, date);
		
		for (int i = 2; i <= day ; i++)
		{
			cal.add(Calendar.DATE, 1);
			result.put(i, format.format(cal.getTime()));
		}
		
		return result;
	
	}// end dateCal
	
	@Override
	public ArrayList<CardDTO> dayCardList(String note_num, String card_visitdate) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		
		String sql = "SELECT V.CARD_NUM AS CARD_NUM, V.CARD_LOCATION AS CARD_LOCATION, V.CARD_BUDGET AS CARD_BUDGET"
						+ ", V.CARD_VISITDATE AS CARD_VISITDATE, V.CARD_TIME AS CARD_TIME, NC.NOTE_NUM AS NOTE_NUM"
						+ ", V.CARD_IMG1 AS CARD_IMG1"
				  + " FROM VIEW_CARDLIST V JOIN NOTED_CARD NC"
				  					   + " ON V.CARD_NUM = NC.CARD_NUM"
				  + " WHERE NOTE_NUM = ?"
				    + " AND CARD_VISITDATE = ?"
				   + "ORDER BY CARD_TIME";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(note_num));
		pstmt.setString(2, card_visitdate);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			CardDTO dto = new CardDTO();
			
			dto.setCard_num(rs.getInt("CARD_NUM"));
			dto.setCard_location(rs.getString("CARD_LOCATION"));
			dto.setCard_visitdate(rs.getString("CARD_VISITDATE"));
			dto.setCard_time(rs.getString("CARD_TIME"));
			dto.setNote_num(rs.getInt("NOTE_NUM"));
			dto.setCard_img1(rs.getString("CARD_IMG1"));
			dto.setCard_budget(rs.getString("CARD_BUDGET"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	
	}// end dayCardList
	
	@Override
	public int insert(NoteDTO note) throws SQLException, NullPointerException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "INSERT INTO NOTE(NOTE_NUM, NOTE_TITLE, NOTE_STARTDATE, NOTE_LASTDATE, REGION_NUM, NOTE_COMPANY, NOTE_BUDGET, SIGN_NUM)"
				  + " VALUES(NOTE_SEQ.NEXTVAL, ?, TO_DATE(?,'YYYY-MM-DD'),TO_DATE(?,'YYYY-MM-DD'), ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note.getNote_title());
		pstmt.setString(2, note.getNote_startdate());
		pstmt.setString(3, note.getNote_lastdate());
		pstmt.setString(4, note.getRegion_num());
		pstmt.setString(5, note.getNote_company());
		pstmt.setString(6, note.getNote_budget());
		pstmt.setString(7, note.getSign_num());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end insert
	
	@Override
	public int max(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT DATA.NOTE_NUM AS NOTE_NUM"
				  + " FROM (SELECT ROWNUM RNUM, N.SIGN_NUM, N.NOTE_NUM"
				  		+ " FROM NOTE N ORDER BY N.NOTE_NUM DESC) DATA"
				  + " WHERE SIGN_NUM = ?"
				    + " AND RNUM = 1";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("NOTE_NUM");
		
		
		pstmt.close();
		conn.close();
		return result;
	
	}// end max
	
	@Override
	public ArrayList<CardDTO> dayCardListAll(String note_num, String card_visitdate) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		
		String sql = "SELECT CARD_NUM, CARD_LOCATION, CARD_COMMENT, CARD_TIME, NOTE_NUM, CARD_VISITDATE, CARD_BUDGET"
				  + " FROM VIEW_NOTEDCARD_CARD"
				  + " WHERE NOTE_NUM = ?"
				    + " AND CARD_VISITDATE = ?"
				   + "ORDER BY CARD_TIME";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(note_num));
		pstmt.setString(2, card_visitdate);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			CardDTO dto = new CardDTO();
			
			dto.setCard_num(rs.getInt("CARD_NUM"));
			dto.setCard_location(rs.getString("CARD_LOCATION"));
			dto.setCard_comment(rs.getString("CARD_COMMENT"));
			dto.setCard_time(rs.getString("CARD_TIME"));
			dto.setNote_num(rs.getInt("NOTE_NUM"));
			dto.setCard_visitdate(rs.getString("CARD_VISITDATE"));
			dto.setCard_budget(rs.getString("CARD_BUDGET"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	
	}// end dayCardListAll
	
	@Override
	public int update(NoteDTO note) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "{call PRC_NOTE_UPDATE(?, ?, ?, ?, ?, ?, ?)}";
		
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setInt(1, Integer.parseInt(note.getNote_num()));
		cstmt.setString(2, note.getNote_title());
		cstmt.setString(3, note.getNote_startdate());
		cstmt.setString(4, note.getNote_lastdate());
		cstmt.setInt(5, Integer.parseInt(note.getRegion_num()));
		cstmt.setInt(6, Integer.parseInt(note.getNote_company()));
		cstmt.setInt(7, Integer.parseInt(note.getNote_budget()));
		
		result = cstmt.executeUpdate();
		
		cstmt.close();
		conn.close();
		
		return result;
	
	}// end update
	
	
	@Override
	public int delete(String note_num) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();

		String sql = "{call PRC_NOTE_DELETE(?)}";
		CallableStatement csmt = conn.prepareCall(sql);
		csmt.setInt(1, Integer.parseInt(note_num));

		result = csmt.executeUpdate();

		csmt.close();
		conn.close();

		return result;
	
	}// end delete
	
	@Override
	public int cardDelete(String note_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "{call PRC_NOTE_UPDATE_CANCEL(?)}";
		
		CallableStatement csmt = conn.prepareCall(sql);
		csmt.setInt(1, Integer.parseInt(note_num));
		
		result = csmt.executeUpdate();
		
		csmt.close();
		conn.close();
		
		return result;
	}// end cardDelete
}
