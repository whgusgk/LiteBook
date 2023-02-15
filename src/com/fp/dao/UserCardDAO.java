package com.fp.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.CardDTO;
import com.fp.dto.NoteDTO;
import com.fp.dto.PayDTO;

public class UserCardDAO implements IUserCardDAO
{
	// Connection 객체 의존성 주입
	private DataSource dataSource;
	
	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	@Override
	public int cardInsert(CardDTO card) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "{call PRC_CARD_INSERT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setString(1, card.getSign_num());
		cstmt.setString(2, card.getCard_lat());
		cstmt.setString(3, card.getCard_lng());
		cstmt.setString(4, card.getCard_address());
		cstmt.setString(5, card.getCard_location());
		cstmt.setString(6, card.getCard_budget());
		cstmt.setString(7, card.getCard_comment());
		cstmt.setString(8, card.getCard_img1());
		cstmt.setString(9, card.getCard_img2());
		cstmt.setString(10, card.getCard_img3());
		cstmt.setString(11, card.getCard_visitdate());
		cstmt.setInt(12, Integer.parseInt(card.getOpen_num()));
		cstmt.setString(13, card.getCard_time());
		cstmt.setString(14, card.getPlace_url());
		cstmt.setInt(15, card.getNote_num());
		
		result = cstmt.executeUpdate();
		
		cstmt.close();
		conn.close();
		
		return result;
	
	}//end cardInsert
	
	@Override
	public int maxCard(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT DATA.CARD_NUM AS CARD_NUM"
				  + " FROM (SELECT ROWNUM RNUM, CARD_NUM"
				  		+ " FROM CARD"
				  		+ " WHERE SIGN_NUM = ?"
				  		+ " ORDER BY CARD_NUM DESC) DATA"
				  + " WHERE RNUM = 1";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("CARD_NUM");
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	}
	
	@Override
	public int payInsert(PayDTO pay) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "INSERT INTO PAY(PAY_NUM, CARD_NUM, PTYPE_NUM, PAY_NAME, PAY_AMOUNT)"
				  + " VALUES(PAY_SEQ.NEXTVAL, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(pay.getCard_num()));
		pstmt.setInt(2, Integer.parseInt(pay.getPtype_num()));
		pstmt.setString(3, pay.getPay_name());
		pstmt.setString(4, pay.getPay_amount());
	
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	
	}// payInsert

	@Override
	public int cardUpdate(CardDTO card) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "UPDATE CARD"
				  + " SET CARD_LAT= ?, CARD_LNG= ?, CARD_ADDRESS= ?"
				     + ", CARD_LOCATION= ?, CARD_BUDGET= ?, CARD_COMMENT= ?"
				     + ", CARD_IMG1= ?, CARD_IMG2= ?, CARD_IMG3= ?"
				     + ", CARD_VISITDATE= TO_DATE(?, 'YYYY-MM-DD'), CARD_TIME = ?, OPEN_NUM = ?"
				     + ", PLACE_URL = ?"
				   + " WHERE CARD_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, card.getCard_lat());
		pstmt.setString(2, card.getCard_lng());
		pstmt.setString(3, card.getCard_address());
		pstmt.setString(4, card.getCard_location());
		pstmt.setString(5, card.getCard_budget());
		pstmt.setString(6, card.getCard_comment());
		pstmt.setString(7, card.getCard_img1());
		pstmt.setString(8, card.getCard_img2());
		pstmt.setString(9, card.getCard_img3());
		pstmt.setString(10, card.getCard_visitdate());
		pstmt.setString(11, card.getCard_time());
		pstmt.setString(12, card.getOpen_num());
		pstmt.setString(13, card.getPlace_url());
		pstmt.setInt(14, card.getCard_num());
		
		result = pstmt.executeUpdate();
		
	
		pstmt.close();
		conn.close();
		return result;
	}
	
	@Override
	public int payUpdate(PayDTO pay) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "UPDATE PAY"
				  + " SET PTYPE_NUM=?, PAY_NAME=?, PAY_AMOUNT=?"
				  + " WHERE PAY_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pay.getPtype_num());
		pstmt.setString(2, pay.getPay_name());
		pstmt.setString(3, pay.getPay_amount());
		pstmt.setString(4, pay.getPay_num());
		
		result = pstmt.executeUpdate();
		
		return result;
	}

	@Override
	public int delete(String card_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		  
		int result = 0;
		  
		String sql = "{call PRC_CARD_DELETE(?)}";
		CallableStatement cstmt = conn.prepareCall(sql);
		cstmt.setString(1, card_num);
		result = cstmt.executeUpdate();
		 
		cstmt.close();
		conn.close();
		 
		return result;
	}

	@Override
	public int payDelete(String pay_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "DELETE"
				  + " FROM PAY"
				  + " WHERE PAY_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(pay_num));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		return result;
	}
	
	@Override
	public CardDTO search(String card_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		CardDTO result = new CardDTO();
		
		String sql = "SELECT CARD_NUM, CARD_LAT, CARD_LNG, CARD_ADDRESS, CARD_LOCATION, CARD_BUDGET, PLACE_URL"
						+ ", CARD_COMMENT, CARD_IMG1, CARD_IMG2, CARD_IMG3, TO_CHAR(CARD_VISITDATE, 'YYYY-MM-DD') AS CARD_VISITDATE, OPEN_NUM, CARD_TIME"
				  + " FROM CARD"
				  + " WHERE CARD_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(card_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setCard_num(rs.getInt("CARD_NUM"));
			result.setCard_lat(rs.getString("CARD_LAT"));
			result.setCard_lng(rs.getString("CARD_LNG"));
			result.setCard_address(rs.getString("CARD_ADDRESS"));
			result.setCard_location(rs.getString("CARD_LOCATION"));
			result.setCard_budget(String.valueOf(rs.getInt("CARD_BUDGET")));
			result.setPlace_url(rs.getString("PLACE_URL"));
			result.setCard_comment(rs.getString("CARD_COMMENT"));
			result.setCard_img1(rs.getString("CARD_IMG1"));
			result.setCard_img2(rs.getString("CARD_IMG2"));
			result.setCard_img3(rs.getString("CARD_IMG3"));
			result.setCard_visitdate(rs.getString("CARD_VISITDATE"));
			result.setOpen_num(String.valueOf(rs.getInt("OPEN_NUM")));
			result.setCard_time(rs.getString("CARD_TIME"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end search
	
	@Override
	public ArrayList<PayDTO> paySearch(String card_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<PayDTO> result = new ArrayList<PayDTO>();
		
		String sql = "SELECT PAY_NUM, CARD_NUM, PTYPE_NUM, PTYPE_NAME, PAY_NAME, PAY_AMOUNT"
				  + " FROM VIEW_PAYTYPE"
				  + " WHERE CARD_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(card_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			PayDTO dto = new PayDTO();
			
			dto.setPay_num(rs.getString("PAY_NUM"));
			dto.setCard_num(rs.getString("CARD_NUM"));
			dto.setPtype_num(rs.getString("PTYPE_NUM"));
			dto.setPtype_name(rs.getString("PTYPE_NAME"));
			dto.setPay_name(rs.getString("PAY_NAME"));
			dto.setPay_amount(rs.getString("PAY_AMOUNT"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end paySearch
	
	@Override
	public NoteDTO searchNotedNote(String card_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NC.NOTE_NUM AS NOTE_NUM"
						+ ", TO_CHAR(N.NOTE_STARTDATE, 'YYYY-MM-DD') AS NOTE_STARTDATE"
						+ ", TO_CHAR(N.NOTE_LASTDATE, 'YYYY-MM-DD') AS NOTE_LASTDATE"
				  + " FROM NOTED_CARD NC JOIN NOTE N"
				  					 + " ON NC.NOTE_NUM = N.NOTE_NUM"
				  + " WHERE NC.CARD_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(card_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setNote_num(String.valueOf(rs.getInt("NOTE_NUM")));
			result.setNote_startdate(rs.getString("NOTE_STARTDATE"));
			result.setNote_lastdate(rs.getString("NOTE_LASTDATE"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	
	}// end searchNotedNote
	
	
	
}
