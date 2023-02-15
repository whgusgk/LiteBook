package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.RecordDTO;

public class UserRecordDAO implements IUserRecordDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 전체 검색 카드 리스트 - rnum, card_num, card_location, user_name, card_date
	@Override
	public ArrayList<RecordDTO> list(String title, String type) throws SQLException
	{
		ArrayList<RecordDTO> result = new ArrayList<RecordDTO>();
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT TYPE, RNUM, NUM, TITLE, USER_NAME, S_DATE"
				+ " FROM VIEW_SEARCHLIST WHERE TITLE LIKE '%'||?||'%'"
				+ " AND TYPE LIKE ?||'%'";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, type);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			RecordDTO dto = new RecordDTO();
			
			dto.setType(rs.getString("TYPE"));
			dto.setNum(rs.getString("NUM"));
			dto.setTitle(rs.getString("TITLE"));
			dto.setUser_name(rs.getString("USER_NAME"));
			dto.setS_date(rs.getString("S_DATE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
}
