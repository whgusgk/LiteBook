package com.fp.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.fp.dto.UserDTO;

public class UserPageDAO implements IUserPageDAO
{
	// Connection 객체 의존성 주입
	private DataSource dataSource;
	
	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 오버라이딩

	// 입력한 아이디가 존재하는지 확인 - 로그인 > 존재하는 경우 개수 반환(1,0)
	@Override
	public String idCheck(String user_id) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = null;
		
		String sql = "SELECT TO_CHAR(COUNT(USER_ID)) AS COUNT" 
					+ " FROM USERS" 
					+ " WHERE USER_ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getString("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 아이디 일치할 경우 비밀번호 확인 - 로그인 > 일치하면 아이디 반환
	@Override
	public String pwCheck(String user_id, String user_pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = null;
		
		String sql = "SELECT USER_ID" 
				+ " FROM USERS" 
				+ " WHERE USER_ID = ?" 
				+ " AND USER_PW = CRYPTPACK.ENCRYPT(?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		pstmt.setString(2, user_pw);
		pstmt.setString(3, user_pw);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result = rs.getString("USER_ID");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public String nameCheck(String user_name) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = "";
		
		String sql = "SELECT TO_CHAR(COUNT(USER_NAME)) AS COUNT" 
					+ " FROM USERS" 
					+ " WHERE USER_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_name);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getString("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	// 회원 아이디로 유저 등록번호 조회(세션 값 부여 시 사용)
	@Override
	public String sessionSignNum(String user_id) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT SIGN_NUM"
				+ " FROM USERS"
				+ " WHERE USER_ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_id);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result = rs.getString("SIGN_NUM");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	// 회원가입
	@Override
	public int add(UserDTO dto) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		//String sql = "EXEC PRC_USER_INSERT(?, ? , ?, ?, ?, ?, ?)";
		String sql = "{call PRC_USER_INSERT(?, ?, ?, ?, ?, ?, ?) }";
		
		//PreparedStatement pstmt = conn.prepareStatement(sql);
		CallableStatement cstmt = conn.prepareCall(sql);
		
		cstmt.setString(1, dto.getUser_id());
		cstmt.setString(2, dto.getUser_pw());
		cstmt.setString(3, dto.getUser_name());
		cstmt.setString(4, dto.getUser_tel());
		cstmt.setString(5, dto.getUser_email());
		cstmt.setString(6, dto.getGender_num());
		cstmt.setString(7, dto.getUser_birth());
		
		result = cstmt.executeUpdate();
		cstmt.close();
		conn.close();
		
		return result;
	}
	
	// 지역 카테고리 등록
	public int regionAdd(UserDTO dto) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		String sql = "INSERT INTO FAVOR_REGION(FREGION_NUM, SIGN_NUM, REGION_NUM) VALUES(FAVOR_REGION_SEQ.NEXTVAL, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getSign_num());
		pstmt.setString(2, dto.getRegion_num());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	

	// 관심 카테고리 등록
	public int categoryAdd(UserDTO dto) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		String sql = "INSERT INTO FAVOR_CATEGORY(FCATEGORY_NUM, SIGN_NUM, TCATEGORY_NUM) VALUES(FAVOR_CATEGORY_SEQ.NEXTVAL, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getSign_num());
		pstmt.setString(2, dto.getTcategory_num());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	

	// 이름과 이메일을 이용해서 아이디 찾기
	@Override
	public String findUserId(String user_name, String user_email) throws SQLException
	{
		String result = null;

		Connection conn = dataSource.getConnection();

		String sql = "SELECT USER_ID FROM USERS  WHERE USER_NAME=? AND USER_EMAIL=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, user_name);
		pstmt.setString(2, user_email);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next())
			result = rs.getString("USER_ID");


		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}

	// 비밀번호 찾기
	@Override
	public String findPwd1(String user_id) throws SQLException
	{
			Connection conn = dataSource.getConnection();
			
			String result = null;
			
			String sql = "SELECT TO_CHAR(COUNT(USER_ID))AS COUNT"
					+ " FROM USERS WHERE USER_ID = ? ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				result = rs.getString("COUNT");
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
	
	@Override
	public String findPwd2(String user_email) throws SQLException
	{
			Connection conn = dataSource.getConnection();
			
			String result = null;
			
			String sql = "SELECT TO_CHAR(COUNT(USER_EMAIL)) AS COUNT"
					+ " FROM USERS WHERE USER_EMAIL = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_email);
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				result = rs.getString("COUNT");
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		
	// 비밀번호 수정을 위한 등록번호 찾기
	@Override
	public String searchId(String user_id) throws SQLException
	{
			Connection conn = dataSource.getConnection();
			
			String result = null;
			
			String sql = "SELECT SIGN_NUM FROM USERS WHERE USER_ID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				result = rs.getString("SIGN_NUM");
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
		
	//비밀번호 수정을 위한 메서드 선언
	  
	  @Override
	 public int modify(String sign_num, String user_pw) throws SQLException
	  { 
		  
		  Connection conn = dataSource.getConnection();
	  
		  int result = 0;
	  
		  String sql = "UPDATE USERS SET USER_PW = CRYPTPACK.ENCRYPT(?, ?)" 
				  		+ " WHERE SIGN_NUM = ?";
	  
		  PreparedStatement pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1,user_pw);
		  pstmt.setString(2,user_pw);
		  pstmt.setString(3,sign_num);
		  
		  result = pstmt.executeUpdate();
		  
		  
		  pstmt.close(); conn.close();
		  
		  return result; 
	}

	
	// 환영 페이지에 이름 출력
	@Override
	public String searchName(String sign_num) throws SQLException
	{
		String result = null;

		Connection conn = dataSource.getConnection();

		String sql = "SELECT USER_NAME FROM USERS WHERE SIGN_NUM =?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sign_num);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next())
			result = rs.getString("USER_NAME");

		rs.close();
		pstmt.close();
		conn.close();

		return result;
	}
	// 회원 탈퇴 기능
	@Override
	public int delete(String sign_num) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		//String sql = "EXEC PRC_USER_QUIT(?)";
		String sql = "{call PRC_USER_QUIT(?)}";				// 프로시저 호출
		CallableStatement cstmt = conn.prepareCall(sql);	
		cstmt.setString(1, sign_num);
		
		result = cstmt.executeUpdate();
		cstmt.close();
		conn.close();
		
		return result;
	}

	
	// 닉네임 중복 확인 기능 - 0이면 사용가능, 1이면 사용불가(이미 존재하는 닉네임)
	@Override
	public int nickNameCheck(String nickName) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(USER_NAME) AS COUNT"
				+ " FROM USERS"
				+ " WHERE USER_NAME = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nickName);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	// 활동 게이지 표시(좋아요)
	@Override
	public int liked(String sign_num) throws SQLException
	{
			Connection conn = dataSource.getConnection();
			
			int result = 0;
			
			String sql = "SELECT COUNT(U.SIGN_NUM) AS LIKED_COUNT"
						+ " FROM LIKED L, BOOK B, USERS U"
						+ " WHERE L.BOOK_NUM=B.BOOK_NUM"
						+ " AND B.SIGN_NUM=U.SIGN_NUM"
						+ " AND U.SIGN_NUM=?"
						+ " GROUP BY U.SIGN_NUM";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sign_num);
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				result = rs.getInt("LIKED_COUNT");
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return result;
		}
	
	// 활동 게이지 표시(댓글)
		@Override
		public int comment_Count(String sign_num) throws SQLException
		{
				Connection conn = dataSource.getConnection();
				
				int result = 0;
				
				String sql = "SELECT COUNT(U.SIGN_NUM) AS COMMENT_COUNT"
						+ " FROM BOOKED_COMMENT BC, BOOK B, USERS U"
						+ " WHERE BC.BOOK_NUM=B.BOOK_NUM"
						+ " AND B.SIGN_NUM=U.SIGN_NUM"
						+ " AND U.SIGN_NUM=?"
						+ " GROUP BY U.SIGN_NUM";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sign_num);
				
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next())
				{
					result = rs.getInt("COMMENT_COUNT");
				}
				rs.close();
				pstmt.close();
				conn.close();
				
				return result;
			}
	
		// 활동 게이지 표시(책)
		@Override
		public int book_Count(String sign_num) throws SQLException
		{
				Connection conn = dataSource.getConnection();
				
				int result = 0;
				
				String sql = "SELECT COUNT(*) AS BOOK_COUNT"
						   + " FROM BOOK WHERE SIGN_NUM=?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sign_num);
				
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next())
				{
					result = rs.getInt("BOOK_COUNT");
				}
				rs.close();
				pstmt.close();
				conn.close();
				
				return result;
			}
		
		// 활동 게이지 표시(경고)
		@Override
		public int warning_Count(String sign_num) throws SQLException
		{
				Connection conn = dataSource.getConnection();
				
				int result = 0;
				
				String sql = "SELECT COUNT(*) AS WARNING"
						+ " FROM VIEW_WARNINGLIST"
						+ " WHERE CANCEL_DATE IS NULL"
						+ " AND WARNING_USER=?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sign_num);
				
				ResultSet rs = pstmt.executeQuery();
				
				while (rs.next())
				{
					result = rs.getInt("WARNING");
				}
				rs.close();
				pstmt.close();
				conn.close();
				
				return result;
			}
	
		// 회원 정지 여부 확인 - 반환 값 Y, N 
		@Override
		public String stopSearch(String sign_num) throws SQLException
		{
			String result = "";
			
			Connection conn = dataSource.getConnection();
			String sql = "SELECT U.SIGN_NUM AS SIGN_NUM"
					+ ", NVL(V.STOP_TYPE, 'N') AS STOP_TYPE"
					+ " FROM VIEW_USERWARNINGCOUNT V RIGHT JOIN USERS U"
					+ " ON V.WARNING_USER = U.SIGN_NUM"
					+ " WHERE U.SIGN_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(sign_num));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				result = rs.getString("STOP_TYPE");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			return result;
		}

		
		// 정지회원 정지 처리된 날짜 출력(가장 최근에 경고받은 날짜)
		@Override
		public String stopDate(String sign_num) throws SQLException
		{
			String result = "";
			
			Connection conn = dataSource.getConnection();
			String sql = "SELECT ROWNUM, WARNING_USER, TYPE, STATUS_NUM"
					+ ", TO_CHAR(STATUS_DATE, 'YYYY-MM-DD') AS STATUS_DATE"
					+ ", REASON FROM VIEW_USERWARNINGLIST"
					+ " WHERE WARNING_USER = ? AND CANCEL_DATE IS NULL"
					+ " AND ROWNUM = 1 ORDER BY STATUS_DATE DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sign_num);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
			{
				result = rs.getString("STATUS_DATE");
			}
			
			rs.close();
			pstmt.close();
			return result;
		}

		
		// 로그인 성공 시 마지막 접속 시간 업데이트
		@Override
		public int updateFDate(String sign_num) throws SQLException
		{
			int result = 0;
			
			Connection conn = dataSource.getConnection();
			String sql = "UPDATE USERS SET USER_FDATE = SYSDATE WHERE SIGN_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sign_num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			return result;
		}
	
	
}
