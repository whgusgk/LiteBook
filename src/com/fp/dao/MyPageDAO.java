package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.LikedDTO;
import com.fp.dto.QnaDTO;
import com.fp.dto.UserDTO;

public class MyPageDAO implements IMyPageDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	@Override
	public UserDTO search(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		UserDTO result = new UserDTO();
		
		String sql = "SELECT SIGN_NUM, USER_ID, GENDER_NUM"
						+ ", USER_NAME, USER_EMAIL, USER_TEL, USER_GENDER, USER_PROFILE"
				   		+ ", NVL(USER_INTRO, '아직 자기소개가 없습니다. 멋진 자기소개를 입력해보세요.') AS USER_INTRO"
				  + " FROM VIEW_USERS_GENDER"
				  + " WHERE SIGN_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setSign_num(String.valueOf(rs.getInt("SIGN_NUM")));
			result.setUser_id(rs.getString("USER_ID"));
			result.setGender_num(String.valueOf(rs.getInt("GENDER_NUM")));
			result.setUser_name(rs.getString("USER_NAME"));
			result.setUser_email(rs.getString("USER_EMAIL"));
			result.setUser_tel(rs.getString("USER_TEL"));
			result.setUser_gender(rs.getString("USER_GENDER"));
			result.setUser_profile(rs.getString("USER_PROFILE"));
			result.setUser_intro(rs.getString("USER_INTRO"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	} // end search
	
	@Override
	public ArrayList<String> searchFregion(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<String> result = new ArrayList<String>();
		
		String sql = "SELECT FREGION_NAME"
				  + " FROM VIEW_FREIGON_SEARCH"
				  + " WHERE SIGN_NUM = ?"
				  + " ORDER BY FREGION_NAME";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result.add(rs.getString("FREGION_NAME"));
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}// end searchFregion
	
	
	// 개인정보 수정 업데이트 폼의 회원 관심지역 출력
	@Override
	public ArrayList<UserDTO> userFregion(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<UserDTO> result = new ArrayList<UserDTO>();
		
		String sql = "SELECT F.FREGION_NUM AS FREGION_NUM"
				+ ", F.SIGN_NUM AS SIGN_NUM"
				+ ", R.REGION_NAME AS REGION_NAME"
				+ " FROM FAVOR_REGION F, REGION R"
				+ " WHERE F.REGION_NUM = R.REGION_NUM"
				+ " AND F.SIGN_NUM = ?"
				+ " ORDER BY F.FREGION_NUM";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			UserDTO dto = new UserDTO();
			
			dto.setFregion_num(rs.getString("FREGION_NUM"));
			dto.setFregion_name(rs.getString("REGION_NAME"));
			result.add(dto);
		}	
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	@Override
	public ArrayList<String> searchFcategory(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<String> result = new ArrayList<String>();
		
		String sql = "SELECT FCATEGORY_NAME"
				  + " FROM VIEW_FCATEGORY_SEARCH"
				  + " WHERE SIGN_NUM = ?"
				  + " ORDER BY FCATEGORY_NAME";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result.add(rs.getString("FCATEGORY_NAME"));

		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}// end searchFcategory
	
	@Override
	public int likedBookCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_LIKELIST"
				  + " WHERE LIKER_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		conn.close();
		return result;
	}
	
	@Override
	public ArrayList<LikedDTO> likedBookList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<LikedDTO> result = new ArrayList<LikedDTO>();
		
		String sql = "SELECT RNUM, BOOK_NUM, BOOK_TITLE, WRITER_NAME, BOOK_DATE"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT BOOK_NUM, BOOK_TITLE, WRITER_NAME, BOOK_DATE"
				  			  + " FROM VIEW_LIKELIST"
				  			  + " WHERE LIKER_NUM = ?"
				  			  + " ORDER BY LIKED_DATE DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			LikedDTO dto = new LikedDTO();
			
			dto.setBook_num(String.valueOf(rs.getInt("BOOK_NUM")));
			dto.setBook_title(rs.getString("BOOK_TITLE"));
			dto.setWriter_name(rs.getString("WRITER_NAME"));
			dto.setBook_date(rs.getString("BOOK_DATE"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}// end likedBookList
	
	@Override
	public int commentCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_COMMENTLIST"
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
	
	}// end commentCount
	
	@Override
	public ArrayList<CommentDTO> commentList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<CommentDTO> result = new ArrayList<CommentDTO>();
		
		String sql = "SELECT RNUM, COMMENT_NUM, COMMENT_CONTENT, TO_CHAR(COMMENT_DATE, 'YYYY-MM-DD HH:MM') AS COMMENT_DATE, BOOK_NUM"
				  + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
				  		+ " FROM (SELECT COMMENT_NUM, COMMENT_DATE, COMMENT_CONTENT, BOOK_NUM"
				  			  + " FROM VIEW_USER_COMMENTLIST"
				  			  + " WHERE SIGN_NUM = ?"
				  			  + " ORDER BY COMMENT_NUM DESC) DATA)"
				  + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			CommentDTO dto = new CommentDTO();
			
			dto.setComment_num(String.valueOf(rs.getInt("COMMENT_NUM")));
			dto.setComment_content(rs.getString("COMMENT_CONTENT"));
			dto.setComment_date(rs.getString("COMMENT_DATE"));
			dto.setBook_num(String.valueOf(rs.getInt("BOOK_NUM")));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	
	}// end commetList
	
	@Override
	public int BookCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_BOOKEDLIST"
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
	}
	
	// 다른사람 프로필에서 볼 수 있는 책 리스트
	@Override
	public ArrayList<BookDTO> bookList(String sign_num, int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<BookDTO> result = new ArrayList<BookDTO>();
		
		String sql = "SELECT RNUM, BOOK_NUM, BOOK_TITLE, USER_NAME, BOOK_DATE"
 				   + " FROM (SELECT ROWNUM AS RNUM, DATA.*"
 				   + " FROM (SELECT BOOK_NUM, BOOK_TITLE, USER_NAME, BOOK_DATE"
 				   + " FROM VIEW_BOOKEDLIST"
 				   + " WHERE SIGN_NUM = ?"
 				   + " ORDER BY BOOK_DATE DESC) DATA)"
 				   + " WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			BookDTO dto = new BookDTO();
			
			dto.setBook_num(rs.getInt("BOOK_NUM"));
			dto.setBook_title(rs.getString("BOOK_TITLE"));
			dto.setUser_name(rs.getString("USER_NAME"));
			dto.setBook_date(rs.getString("BOOK_DATE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
		
	} // end bookList
	
	@Override
	public int CardCount(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM VIEW_OTHERCARDLIST"
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
	}
	
	// 다른사람 프로필에서 볼 수 있는 카드 리스트
	@Override
	public ArrayList<CardDTO> cardList(String sign_num,int start, int end) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		
		String sql = "SELECT RNUM, CARD_NUM, CARD_LOCATION, CARD_BUDGET, CARD_TIME, CARD_COMMENT, CARD_DATE"
				+ " FROM(SELECT ROWNUM AS RNUM, DATA.*"
				+ " FROM(SELECT CARD_NUM, CARD_LOCATION, CARD_BUDGET, CARD_TIME, CARD_COMMENT, CARD_DATE"
				+ " FROM VIEW_OTHERCARDLIST"
				+ " WHERE SIGN_NUM=? AND OPEN_NUM= 1"
				+ " ORDER BY CARD_DATE DESC) DATA)"
				+ " WHERE RNUM >= ? AND RNUM <= ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		

		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			CardDTO dto = new CardDTO();
			
			dto.setCard_num(rs.getInt("CARD_NUM"));
			dto.setCard_location(rs.getString("CARD_LOCATION"));
			dto.setCard_budget(rs.getString("CARD_BUDGET"));
			dto.setCard_time(rs.getString("CARD_TIME"));
			dto.setCard_comment(rs.getString("CARD_COMMENT"));
			dto.setCard_date(rs.getString("CARD_DATE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
		
	} // end cardList
	
	
	@Override
	public ArrayList<UserDTO> regionList() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<UserDTO> result = new ArrayList<UserDTO>();
		
		String sql = "SELECT REGION_NUM, REGION_NAME"
				  + " FROM REGION";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			UserDTO dto = new UserDTO();
			
			dto.setRegion_num(String.valueOf(rs.getInt("REGION_NUM")));
			dto.setRegion_name(rs.getString("REGION_NAME"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
		
	} // end regionList
	
	@Override
	public ArrayList<UserDTO> tcategoryList() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<UserDTO> result = new ArrayList<UserDTO>();
		
		String sql = "SELECT TCATEGORY_NUM, TCATEGORY_NAME"
				  + " FROM TRAVEL_CATEGORY";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			UserDTO dto = new UserDTO();
			
			dto.setTcategory_num(String.valueOf(rs.getInt("TCATEGORY_NUM")));
			dto.setTcategory_name(rs.getString("TCATEGORY_NAME"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}// end tcategoryList

	
	// 내가 질문 한 내역 리스트 출력
	@Override
	public ArrayList<QnaDTO> myqnaList(String sign_num) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<QnaDTO> result = new ArrayList<QnaDTO>();
		
		String sql = "SELECT QUESTION_NUM, QCATEGORY_CLASS"
				+ ", QUESTION_TITLE,TO_CHAR(QUESTION_DATE, 'YYYY-MM-DD') AS QUESTION_DATE"
				+ ", CASE WHEN ANSWER_NUM = 0 THEN '미처리' ELSE '처리완료' END AS QUESTION_DONE"
				+ " FROM VIEW_QNA WHERE SIGN_NUM = ?"
				+ " ORDER BY QUESTION_NUM DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			QnaDTO dto = new QnaDTO();
			
			dto.setQuestion_num(rs.getInt("QUESTION_NUM"));
			dto.setQcategory_class(rs.getString("QCATEGORY_CLASS"));
			dto.setQuestion_title(rs.getString("QUESTION_TITLE"));
			dto.setQuestion_date(rs.getString("QUESTION_DATE"));
			dto.setQuestion_done(rs.getString("QUESTION_DONE"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 개인정보 수정 기능
	@Override
	public int update(UserDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "UPDATE USERS SET USER_NAME = ?, USER_INTRO = ?"
				+ ", USER_EMAIL = ?, USER_TEL = ?, GENDER_NUM = ?"
				+ " WHERE SIGN_NUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getUser_name());
		pstmt.setString(2, dto.getUser_intro());
		pstmt.setString(3, dto.getUser_email());
		pstmt.setString(4, dto.getUser_tel());
		pstmt.setInt(5, Integer.parseInt(dto.getUser_gender()));
		pstmt.setInt(6, Integer.parseInt(dto.getSign_num()));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();

		return result;
	}

	// 나의 관심지역 등록
	@Override
	public int fregionInsert(String region_num, String sign_num) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "INSERT INTO FAVOR_REGION(FREGION_NUM, SIGN_NUM, REGION_NUM)"
				+ " VALUES(FAVOR_REGION_SEQ.NEXTVAL, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sign_num);
		pstmt.setString(2, region_num);
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 나의 관심카테고리 등록
	@Override
	public int fcategoryInsert(String category_num, String sign_num) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "INSERT INTO FAVOR_CATEGORY(FCATEGORY_NUM, SIGN_NUM, TCATEGORY_NUM)"
				+ " VALUES(FAVOR_CATEGORY_SEQ.NEXTVAL, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sign_num);
		pstmt.setString(2, category_num);
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
	// 나의 관심지역 삭제
	@Override
	public int fregionDelete(String sign_num) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "DELETE FROM FAVOR_REGION"
				+ " WHERE SIGN_NUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sign_num);
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}


	// 나의 관심카테고리 삭제
	@Override
	public int fcategoryDelete(String sign_num) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "DELETE FROM FAVOR_CATEGORY"
				+ " WHERE SIGN_NUM = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sign_num);
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
	// 나의 프로필 사진 수정
	@Override
	public int profileUpdate(String sign_num, String imgPath) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		String sql = "UPDATE USERS"
				+ " SET USER_PROFILE = ?"
				+ " WHERE SIGN_NUM = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, imgPath);
		pstmt.setString(2, sign_num);
		
		result =pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}

	
}
