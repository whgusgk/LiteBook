package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.NoticeDTO;

public class UserNoticeDAO implements IUserNoticeDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	// 공지사항 리스트 출력 기능
	@Override
	public ArrayList<NoticeDTO> list(int start, int end, String keyword) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<NoticeDTO> result = new ArrayList<NoticeDTO>();
		
		String sql = "SELECT RNUM, NOTICE_NUM, NOTICE_TITLE"
				+ ", TO_CHAR(NOTICE_DATE, 'YYYY-MM-DD') AS NOTICE_DATE"
				+ " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				+ " FROM (SELECT NOTICE_NUM, NOTICE_TITLE, NOTICE_DATE"
				+ " FROM NOTICE WHERE NOTICE_TITLE LIKE '%'||?||'%'"
				+ " ORDER BY NOTICE_NUM DESC) DATA)"
				+ " WHERE RNUM >= ?"
				+ " AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, keyword);
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			NoticeDTO dto = new NoticeDTO();
			dto.setNotice_num(rs.getInt("NOTICE_NUM"));
			dto.setNotice_title(rs.getString("NOTICE_TITLE"));
			dto.setNotice_date(rs.getString("NOTICE_DATE"));
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 공지사항 게시글 총 개수
	@Override
	public int count(String keyword) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT"
				+ " FROM NOTICE"
				+ " WHERE NOTICE_TITLE LIKE '%'||?||'%'";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, keyword);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 공지사항 게시글 상세 열람 페이지 출력
	@Override
	public NoticeDTO search(int notice_num) throws SQLException
	{
		NoticeDTO result = new NoticeDTO();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT NOTICE_NUM, NOTICE_TITLE"
				+ ", TO_CHAR(NOTICE_DATE, 'YYYY-MM-DD') AS NOTICE_DATE"
				+ ", NOTICE_CONTENT FROM NOTICE WHERE NOTICE_NUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, notice_num);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result.setNotice_num(rs.getInt("NOTICE_NUM"));
			result.setNotice_title(rs.getString("NOTICE_TITLE"));
			result.setNotice_date(rs.getString("NOTICE_DATE"));
			result.setNotice_content(rs.getString("NOTICE_CONTENT"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
}
