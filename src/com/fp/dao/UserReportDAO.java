package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.ReportDTO;

public class UserReportDAO implements IUserReportDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	
	// 다른 회원의 게시글 신고 시 신고폼에 출력할 내용
	@Override
	public ReportDTO list(String type, String num) throws SQLException
	{
		ReportDTO result = new ReportDTO();
		
		Connection conn = dataSource.getConnection();
		String sql = "SELECT TYPE, NUM, WRITER, CONTENT"
				+ " FROM VIEW_RECORDLIST"
				+ " WHERE TYPE = ? AND NUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, type);
		pstmt.setString(2, num);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setType(rs.getString("TYPE"));
			result.setReport_num(rs.getString("NUM"));
			result.setWriter(rs.getString("WRITER"));
			result.setReport_content(rs.getString("CONTENT"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 여행책 신고 인서트
	@Override
	public int bInsert(BookDTO dto, ReportDTO rdto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
	
		 String sql = "INSERT INTO BOOK_REPORT(BREPORT_NUM, SIGN_NUM, BOOK_NUM" +
		 ", RREASON_NUM, BREPORT_TITLE, BREPORT_CONTENT)" +
		 " VALUES(BOOK_REPORT_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";

		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getSign_num());
		pstmt.setInt(2, dto.getBook_num());
		pstmt.setString(3, rdto.getReason_num());
		pstmt.setString(4, rdto.getReport_title());
		pstmt.setString(5, dto.getBreport_content());
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 여행카드 신고 인서트
	@Override
	public int cInsert(CardDTO dto, ReportDTO rdto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "INSERT INTO CARD_REPORT(CREPORT_NUM, SIGN_NUM, CARD_NUM"
				+ ", RREASON_NUM, CREPORT_TITLE, CREPORT_CONTENT)"
				+ " VALUES(CARD_REPORT_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getSign_num());
		pstmt.setInt(2, dto.getCard_num());
		pstmt.setString(3, rdto.getReason_num());
		pstmt.setString(4, rdto.getReport_title());
		pstmt.setString(5, rdto.getReport_content());
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 댓글 신고 인서트
	@Override
	public int coInsert(CommentDTO dto, ReportDTO rdto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "INSERT INTO COMMENT_REPORT(COREPORT_NUM, SIGN_NUM, COMMENT_NUM"
				+ ", RREASON_NUM, COREPORT_TITLE, COREPORT_CONTENT)"
				+ " VALUES(COMMENT_REPORT_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getSign_num());
		pstmt.setString(2, dto.getComment_num());
		pstmt.setString(3, rdto.getReason_num());
		pstmt.setString(4, rdto.getReport_title());
		pstmt.setString(5, rdto.getReport_content());
		
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
}




