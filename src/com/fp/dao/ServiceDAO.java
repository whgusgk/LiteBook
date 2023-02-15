package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.FaqDTO;
import com.fp.dto.QnaDTO;
import com.fp.dto.ReportDTO;
import com.fp.dto.WarningDTO;

public class ServiceDAO implements IServiceDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	
	// 자주 묻는 질문 리스트 출력 
		@Override
		public ArrayList<FaqDTO> list(int start, int end) throws SQLException
		{
			ArrayList<FaqDTO> result = new ArrayList<FaqDTO>();
			
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT RNUM, FAQ_NUM, QCATEGORY_NUM, FAQ_QUESTION, FAQ_ANSWER"
					+ " FROM (SELECT ROWNUM AS RNUM, DATA.*"
					+ " FROM (SELECT FAQ_NUM, QCATEGORY_NUM, FAQ_QUESTION, FAQ_ANSWER"
					+ " FROM VIEW_FAQLIST ORDER BY FAQ_NUM DESC) DATA)"
					+ " WHERE RNUM >= ? AND RNUM <= ?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				FaqDTO dto = new FaqDTO();
				dto.setFaq_num(rs.getInt("FAQ_NUM"));
				dto.setQcategory_num(rs.getInt("QCATEGORY_NUM"));
				dto.setFaq_question(rs.getString("FAQ_QUESTION"));
				dto.setFaq_answer(rs.getString("FAQ_ANSWER"));
				result.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}

		
		// 전체 자주 묻는 질문 개수 확인
		@Override
		public int count() throws SQLException
		{
			int result = 0;
			
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT COUNT(*) AS COUNT FROM FAQ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
				result = rs.getInt("COUNT");
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}

		// 카테고리에 따른 자주 묻는 질문 개수 확인
		@Override
		public int searchCount(int qcategory_num) throws SQLException
		{
			int result = 0;
			
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT COUNT(*) AS COUNT"
					+ " FROM FAQ WHERE QCATEGORY_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qcategory_num);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
				result = rs.getInt("COUNT");
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}

		// 카테고리에 따른 자주 묻는 질문 리스트 확인
		@Override
		public ArrayList<FaqDTO> searchList(int start, int end, int qcategory_num) throws SQLException
		{
			ArrayList<FaqDTO> result = new ArrayList<FaqDTO>();
			
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT RNUM, FAQ_NUM, QCATEGORY_NUM, FAQ_QUESTION, FAQ_ANSWER"
					+ " FROM (SELECT ROWNUM AS RNUM, DATA.*"
					+ " FROM (SELECT FAQ_NUM, QCATEGORY_NUM, FAQ_QUESTION, FAQ_ANSWER"
					+ " FROM VIEW_FAQLIST WHERE QCATEGORY_NUM = ?"
					+ " ORDER BY FAQ_NUM DESC) DATA)"
					+ " WHERE RNUM >= ? AND RNUM <= ?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qcategory_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				FaqDTO dto = new FaqDTO();
				dto.setFaq_num(rs.getInt("FAQ_NUM"));
				dto.setQcategory_num(rs.getInt("QCATEGORY_NUM"));
				dto.setFaq_question(rs.getString("FAQ_QUESTION"));
				dto.setFaq_answer(rs.getString("FAQ_ANSWER"));
				result.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}

		// 질문하기 인서트 액션
		@Override
		public int insert(QnaDTO dto, String sign_num) throws SQLException
		{
			int result = 0;
			
			Connection conn = dataSource.getConnection();
			String sql = "INSERT INTO QUESTION(QUESTION_NUM, QCATEGORY_NUM"
					+ ", QUESTION_TITLE, QUESTION_CONTENT, SIGN_NUM)"
					+ " VALUES(QUESTION_SEQ.NEXTVAL, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getQcategory_num());
			pstmt.setString(2, dto.getQuestion_title());
			pstmt.setString(3, dto.getQuestion_content());
			pstmt.setInt(4, Integer.parseInt(sign_num));
			
			result = pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
			return result;
		}
		
	
	@Override
	public int qnaCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_QNA"
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
		
	}// end qnaCount
	
	@Override
	public ArrayList<QnaDTO> qnaList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<QnaDTO> result = new ArrayList<QnaDTO>();
		
		String sql = "SELECT RNUM, QUESTION_NUM, QCATEGORY_CLASS, QUESTION_TITLE, ANSWER_NUM, QUESTION_DONE, QUESTION_DATE"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT QUESTION_NUM, QCATEGORY_CLASS, QUESTION_TITLE, ADMIN_NAME, USER_NAME, ANSWER_NUM"
				  					+ ", CASE WHEN ANSWER_NUM=0 THEN '미처리'ELSE '처리완료'END AS QUESTION_DONE"
				  					+ ", TO_CHAR(QUESTION_DATE, 'YYYY-MM-DD') AS QUESTION_DATE"
				  			  + " FROM VIEW_QNA"
				  			  + " WHERE SIGN_NUM = ?"
				  			  + " ORDER BY QUESTION_NUM DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			QnaDTO dto = new QnaDTO();
			
			dto.setQuestion_num(rs.getInt("QUESTION_NUM"));
			dto.setQcategory_class(rs.getString("QCATEGORY_CLASS"));
			dto.setQuestion_title(rs.getString("QUESTION_TITLE"));
			dto.setAnswer_num(rs.getInt("ANSWER_NUM"));
			dto.setQuestion_done(rs.getString("QUESTION_DONE"));
			dto.setQuestion_date(rs.getString("QUESTION_DATE"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end qnaList
	
	@Override
	public int reportCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_REPORTLIST"
				  + " WHERE REPORTER = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");
		
		return result;
	
	}// end reportCount
	
	@Override
	public ArrayList<ReportDTO> reportList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		ArrayList<ReportDTO> result = new ArrayList<ReportDTO>();
		
		String sql = "SELECT RNUM, TYPE, ARTICLE, REPORT_NUM, REPORT_TITLE, REASON, REPORT_DATE, REPORT_DONE"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT TYPE, ARTICLE, REPORT_NUM, REPORT_TITLE, REASON"
				  					+ ", TO_CHAR(REPORT_DATE, 'YYYY-MM-DD') AS REPORT_DATE"
				  					+ " , CASE WHEN STATUS_NUM = 0 THEN '미처리' ELSE '처리완료' END AS REPORT_DONE"
				  			  + " FROM VIEW_REPORTLIST"
				  			  + " WHERE REPORTER = ?"
				  			  + " ORDER BY REPORT_DATE DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			ReportDTO dto = new ReportDTO();
			
			dto.setReport_num(String.valueOf(rs.getInt("REPORT_NUM")));
			dto.setReport_title(rs.getString("REPORT_TITLE"));
			dto.setReason(rs.getString("REASON"));
			dto.setReport_date(rs.getString("REPORT_DATE"));
			dto.setReport_done(rs.getString("REPORT_DONE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end reportList
	
	@Override
	public int warningCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_REPORTLIST"
				  + " WHERE REPORTER = ?"
				    + " AND STATUS = 1"
				    + " AND CANCEL_NUM IS NULL";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");
		
		return result;
	
	}// end warningCount
	
	@Override
	public int fackWarnintCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_REPORTLIST"
				  + " WHERE REPORTER = ?"
				  + " AND STATUS = 3"
				  + " AND CANCEL_NUM IS NULL";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	
	}// end fackWarnintCount
	
	@Override
	public ArrayList<WarningDTO> warningList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<WarningDTO> result = new ArrayList<WarningDTO>();
		
		String sql = "SELECT RNUM, TYPE, TITLE, REASON, STATUS_DATE"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT TYPE, TITLE, REASON, TO_CHAR(STATUS_DATE, 'YYYY-MM-DD') AS STATUS_DATE"
				  			  + " FROM VIEW_MYWARNING"
				  			  + " WHERE WARNING_USER = ?"
				  			  + " ORDER BY STATUS_DATE DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ? ";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			WarningDTO dto = new WarningDTO();
			
			dto.setType(rs.getString("TYPE"));
			dto.setTitle(rs.getString("TITLE"));
			dto.setReason(rs.getString("REASON"));
			dto.setDate(rs.getString("STATUS_DATE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end warningList
	
}
