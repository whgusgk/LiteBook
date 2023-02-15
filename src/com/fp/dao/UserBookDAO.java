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
import com.fp.dto.NoteDTO;

public class UserBookDAO implements IUserBookDAO
{
	//의존성 주입할 데이터소스 선언
	private DataSource dataSource;
	
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	
	//모든 책리스트 조회 메소드
	@Override
	public ArrayList<BookDTO> allBookList(int start, int end)
	{
		ArrayList<BookDTO> result = new ArrayList<BookDTO>();
		
		try
		{
			Connection conn = dataSource.getConnection();
			
			String sql = "SELECT RNUM, BOOK_NUM, BOOK_TITLE, USER_NAME"
					+ ", BOOK_HIT, BOOK_COVER, LIKECOUNT, COMMENTCOUNT"
					+ " FROM (SELECT ROWNUM AS RNUM, DATA.*"
					+ " FROM (SELECT B.BOOK_NUM AS BOOK_NUM, B.BOOK_TITLE AS BOOK_TITLE"
					+ ", B.USER_NAME AS USER_NAME, B.BOOK_HIT AS BOOK_HIT "
					+ ", NVL(B.BOOK_COVER,'images\\yeosoo2.jpg') AS BOOK_COVER"
					+ ", LC.LIKECOUNT AS LIKECOUNT"
					+ ", CC.COMMENTCOUNT AS COMMENTCOUNT"
					+ " FROM VIEW_BOOKLIST B JOIN VIEW_LIKECOUNT LC"
					+ " ON B.BOOK_NUM = LC.BOOK_NUM JOIN VIEW_COMMENTCOUNT CC"
					+ " ON B.BOOK_NUM = CC.BOOK_NUM ORDER BY B.BOOK_NUM DESC) DATA)"
					+ " WHERE RNUM>=? AND RNUM<= ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				BookDTO bookDTO = new BookDTO();
				bookDTO.setBook_num(rs.getInt("BOOK_NUM"));
				bookDTO.setBook_title(rs.getString("BOOK_TITLE"));
				bookDTO.setUser_name(rs.getString("USER_NAME"));
				bookDTO.setBook_hit(rs.getInt("BOOK_HIT"));
				bookDTO.setBook_cover(rs.getString("BOOK_COVER"));
				bookDTO.setLike_count(rs.getInt("LIKECOUNT"));
				bookDTO.setComment_count(rs.getInt("COMMENTCOUNT"));
				
				result.add(bookDTO);
			}
			
			rs.close();
			pstmt.close();
			conn.close();

			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}

	//모든 책 개수 카운트 메소드
	@Override
	public int count()
	{
		int result = 0;
		
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT COUNT(*) AS COUNT FROM BOOK";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				result = rs.getInt("COUNT");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}

	//특정 유저 책리스트 조회 메소드
	@Override
	public ArrayList<BookDTO> bookList(String sign_num, int start, int end)
	{
		ArrayList<BookDTO> result = new ArrayList<BookDTO>();
		
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT RNUM, BOOK_NUM, BOOK_TITLE, BOOK_HIT"
					+ ", SIGN_NUM, BCATEGORY_NAME, TO_CHAR(BOOK_REDATE,'YYYY-MM-DD') AS BOOK_REDATE"
					+ " FROM (SELECT ROWNUM AS RNUM, DATA.*"
					+ " FROM (SELECT B.BOOK_NUM AS BOOK_NUM, B.BOOK_TITLE AS BOOK_TITLE"
					+ ", B.BOOK_HIT AS BOOK_HIT"
					+ ", U.SIGN_NUM AS SIGN_NUM , B.BCATEGORY_NAME AS BCATEGORY_NAME"
					+ " , B.BOOK_REDATE AS BOOK_REDATE"
					+ " FROM VIEW_BOOKLIST B JOIN USERS U ON B.USER_NAME = U.USER_NAME"
					+ " ORDER BY B.BOOK_NUM DESC) DATA)"
					+ " WHERE SIGN_NUM = ?"
					+ " AND RNUM>=? AND RNUM<= ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(sign_num));
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
					//USER_NAME, BOOK_COVER, LIKECOUNT, COMMENTCOUNT, 
				BookDTO bookDTO = new BookDTO();
				bookDTO.setBook_num(rs.getInt("BOOK_NUM"));
				bookDTO.setBook_title(rs.getString("BOOK_TITLE"));
				bookDTO.setBook_hit(rs.getInt("BOOK_HIT"));
				bookDTO.setBcategory_name(rs.getString("BCATEGORY_NAME"));
				bookDTO.setBook_redate(rs.getString("BOOK_REDATE"));
				
				
				result.add(bookDTO);
				
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return result;
	}

	@Override
	public int count(String sign_num) 
	{
		
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
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
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}


	@Override
	public BookDTO search(String book_num)
	{
		BookDTO book = new BookDTO();
		
		try
		{
			Connection conn = dataSource.getConnection();
			String sql ="SELECT B.BOOK_NUM AS BOOK_NUM, B.USER_NAME AS USER_NAME"
					+ ", B.BCATEGORY_NAME AS BCATEGORY_NAME, U.SIGN_NUM AS SIGN_NUM"
					+ ", B.BOOK_TITLE AS BOOK_TITLE, B.BOOK_COMMENT AS BOOK_COMMENT "
					+ ", B.BOOK_HIT AS BOOK_HIT, TO_CHAR(B.BOOK_DATE,'YYYY-MM-DD') AS BOOK_DATE"
					+ ", L.LIKECOUNT AS LIKECOUNT, C.COMMENTCOUNT AS COMMENTCOUNT"
					+ " FROM VIEW_BOOKLIST B JOIN USERS U"
					+ " ON B.USER_NAME = U.USER_NAME"
					+ " JOIN VIEW_LIKECOUNT L ON B.BOOK_NUM = L.BOOK_NUM"
					+ " JOIN VIEW_COMMENTCOUNT C ON B.BOOK_NUM = C.BOOK_NUM"
					+ " WHERE B.BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{	
				book.setBook_num(rs.getInt("BOOK_NUM"));
				book.setUser_name(rs.getString("USER_NAME"));
				book.setBcategory_name(rs.getString("BCATEGORY_NAME"));
				book.setSign_num(String.valueOf(rs.getInt("SIGN_NUM")));
				book.setBook_title(rs.getString("BOOK_TITLE"));
				book.setBook_comment(rs.getString("BOOK_COMMENT"));
				book.setBook_hit(rs.getInt("BOOK_HIT"));
				book.setBook_date(rs.getString("BOOK_DATE"));
				book.setLike_count(rs.getInt("LIKECOUNT"));
				book.setComment_count(rs.getInt("COMMENTCOUNT"));
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return book;
	}


	@Override
	public ArrayList<CardDTO> cardList(String book_num)
	{	
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT C.CARD_LOCATION AS CARD_LOCATION,"
					+ " TO_CHAR(C.CARD_VISITDATE,'YYYY-MM-DD') AS CARD_VISITDATE"
					+ ", NVL(C.CARD_IMG1,'images\\yeosoo2.jpg') AS CARD_IMG1"
					+ " FROM VIEW_BOOKEDCARDLIST BC JOIN CARD C"
					+ " ON BC.CARD_NUM = C.CARD_NUM"
					+ " WHERE BC.BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(book_num));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				CardDTO cardDTO = new CardDTO();
				cardDTO.setCard_location(rs.getString("CARD_LOCATION"));
				cardDTO.setCard_visitdate(rs.getString("CARD_VISITDATE"));
				cardDTO.setCard_img1(rs.getString("CARD_IMG1"));
				
				result.add(cardDTO);
			}
			rs.close();
			pstmt.close();
			conn.close();
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}


	@Override
	public ArrayList<NoteDTO> noteList(String sign_num) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT NOTE_NUM, NOTE_TITLE FROM NOTE WHERE SIGN_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(sign_num));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				NoteDTO note = new NoteDTO();
				
				note.setNote_num(String.valueOf(rs.getInt("NOTE_NUM")));
				note.setNote_title(rs.getString("NOTE_TITLE"));
				
				result.add(note);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}


	@Override
	public ArrayList<CardDTO> notedCardList(String note_num) throws SQLException
	{
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT C.CARD_NUM AS CARD_NUM, C.CARD_LOCATION AS CARD_LOCATION"
					+ ", NC.NOTE_NUM AS NOTE_NUM"
					+ " FROM CARD C JOIN NOTED_CARD NC"
					+ " ON C.CARD_NUM =  NC.CARD_NUM WHERE NC.NOTE_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(note_num));
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				CardDTO card = new CardDTO();
				
				card.setCard_num(rs.getInt("CARD_NUM"));
				card.setCard_location(rs.getString("CARD_LOCATION"));
				
				result.add(card);
			}
			
			
			rs.close();
			pstmt.close();
			conn.close();
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return result;
	}


	@Override
	public int bookInsert(BookDTO book) throws SQLException
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "INSERT INTO BOOK(BOOK_NUM, BCATEGORY_NUM, BOOK_TITLE, BOOK_COMMENT, SIGN_NUM , BOOK_HIT, BOOK_COVER)"
					+ " VALUES(BOOK_SEQ.NEXTVAL , ?, ?, ?, ?, 0, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book.getBcategory_num());
			pstmt.setString(2, book.getBook_title());
			pstmt.setString(3, book.getBook_comment());
			pstmt.setString(4, book.getSign_num());
			pstmt.setString(5, book.getBook_cover());
			
			result = pstmt.executeUpdate();
			
			
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}


	@Override
	public int bookedCardInsert(String book_num, String card_num) throws SQLException
	{	
		int result = 0;

		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "INSERT INTO BOOKED_CARD(BCARD_NUM, BOOK_NUM, CARD_NUM)"
					+ " VALUES (BOOKED_CARD_SEQ.NEXTVAL, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			pstmt.setInt(2, Integer.parseInt(card_num));
			
			result = pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}


	@Override
	public int maxBook(String sign_num)
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			
			
			String sql = "SELECT DATA.BOOK_NUM AS BOOK_NUM"
					+ " FROM (SELECT ROWNUM RNUM, BOOK_NUM"
					+ " FROM BOOK"
					+ " WHERE SIGN_NUM = ?"
					+ " ORDER BY BOOK_NUM DESC) DATA"
					+ " WHERE RNUM = 1";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(sign_num));
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
				result = rs.getInt("BOOK_NUM");
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{

			System.out.println(e.toString());
		}
		
		
		return result;
	}

	
	//여행책을 삭제 시킬 메소드
	@Override
	public int bookDelete(String book_num)
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM BOOK WHERE BOOK_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}

	//여행책을 삭제시키기 전에 여행책에 포함된 여행카드들을 삭제 시킬 메소드(바인딩 해제)
	@Override
	public int bookedCardDelete(String book_num)
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM BOOKED_CARD WHERE BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public BookDTO searchForUpdate(String book_num)
	{
		BookDTO result = new BookDTO();
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT BCATEGORY_NUM, BOOK_TITLE, BOOK_COMMENT, BOOK_COVER"
					+ " FROM BOOK WHERE BOOK_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				result.setBcategory_num(rs.getInt("BCATEGORY_NUM"));
				result.setBook_title(rs.getString("BOOK_TITLE"));
				result.setBook_comment(rs.getString("BOOK_COMMENT"));
				result.setBook_cover(rs.getString("BOOK_COVER"));
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public ArrayList<CardDTO> bookedCardList(String book_num)
	{
		ArrayList<CardDTO> result = new ArrayList<CardDTO>();
		
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT BC.BCARD_NUM AS BCARD_NUM, C.CARD_NUM AS CARD_NUM"
					+ ", C.CARD_LOCATION AS CARD_LOCATION"
					+ " FROM BOOKED_CARD BC JOIN CARD C"
					+ " ON BC.CARD_NUM = C.CARD_NUM"
					+ " WHERE BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				CardDTO card = new CardDTO();
				
				card.setBcard_num(rs.getInt("BCARD_NUM"));
				card.setCard_num(rs.getInt("CARD_NUM"));
				card.setCard_location(rs.getString("CARD_LOCATION"));
				
				result.add(card);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return result;
	}
	@Override
	public int ajaxBookedCardDelete(String bcard_num)
	{
		int result = 0;
		
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "DELETE FROM BOOKED_CARD WHERE BCARD_NUM = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bcard_num));
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int update(BookDTO book) throws SQLException
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "UPDATE BOOK SET BCATEGORY_NUM=?"
					+ ", BOOK_TITLE=?, BOOK_COMMENT=?"
					+ ", BOOK_COVER=? WHERE BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book.getBcategory_num());
			pstmt.setString(2, book.getBook_title());
			pstmt.setString(3, book.getBook_comment());
			pstmt.setString(4, book.getBook_cover());
			pstmt.setInt(5, book.getBook_num());
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	@Override
	public ArrayList<CommentDTO> commentList(String book_num)
	{
		ArrayList<CommentDTO> result = new ArrayList<CommentDTO>();
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT USER_NAME, COMMENT_CONTENT"
					+ ", TO_CHAR(COMMENT_DATE,'YYYY-MM-DD')AS COMMENT_DATE"
					+ " FROM VIEW_COMMENTLIST"
					+ " WHERE BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				CommentDTO comment = new CommentDTO();
				comment.setUser_name(rs.getString("USER_NAME"));
				comment.setComment_content(rs.getString("COMMENT_CONTENT"));
				comment.setComment_date(rs.getString("COMMENT_DATE"));
				
				result.add(comment);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int hitUpdate(String book_num)
	{
		int result = 0;
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "UPDATE BOOK SET BOOK_HIT = BOOK_HIT+1 WHERE BOOK_NUM=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_num));
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int likedInsert(String book_num, String sign_num) throws SQLException
	{
		int result = 0;

		Connection conn = dataSource.getConnection();

		String sql = "INSERT INTO LIKED(LIKED_NUM, BOOK_NUM, SIGN_NUM)"
				+ " VALUES(LIKED_SEQ.NEXTVAL, ?, ?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(book_num));
		pstmt.setInt(2, Integer.parseInt(sign_num));

		result = pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		return result;
	}


	@Override
	public int likedDelete(String book_num, String sign_num) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();

		String sql = "DELETE FROM LIKED WHERE BOOK_NUM =? AND SIGN_NUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(book_num));
		pstmt.setInt(2, Integer.parseInt(sign_num));
		
		result = pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		return result;
	}


	@Override
	public int likedCheck(String book_num, String sign_num) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();

		String sql = "SELECT COUNT(*) AS COUNT FROM LIKED WHERE BOOK_NUM=? AND SIGN_NUM=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(book_num));
		pstmt.setInt(2, Integer.parseInt(sign_num));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("COUNT");

		pstmt.close();
		conn.close();

		return result;
	}
	
	@Override
	public String searchUser(String user_name) throws SQLException
	{
		String result = "";
		try
		{
			Connection conn = dataSource.getConnection();
			String sql = "SELECT SIGN_NUM FROM USERS WHERE USER_NAME=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_name);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{				
				result = rs.getString("SIGN_NUM");
			
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public ArrayList<BookDTO> bestseller() throws SQLException
	{
		ArrayList<BookDTO> result = new ArrayList<BookDTO>();

		Connection conn = dataSource.getConnection();
		String sql = "SELECT B.BOOK_NUM AS BOOK_NUM, B.BOOK_TITLE AS BOOK_TITLE , U.USER_NAME"
				+ " AS USER_NAME, TO_CHAR(B.BOOK_DATE, 'YYYY-MM-DD') AS BOOK_DATE, NVL(BOOK_COVER, '0') AS BOOK_COVER"
				+ " FROM VIEW_BESTSELLER VB, BOOK B, USERS U WHERE VB.BOOK_NUM = B.BOOK_NUM"
				+ " AND B.SIGN_NUM = U.SIGN_NUM AND VB.RNUM =1";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			BookDTO book = new BookDTO();

			book.setBook_num(rs.getInt("BOOK_NUM"));
			book.setBook_title(rs.getString("BOOK_TITLE"));
			book.setUser_name(rs.getString("USER_NAME"));
			book.setBook_date(rs.getString("BOOK_DATE"));
			book.setBook_cover(rs.getString("BOOK_COVER"));

			result.add(book);
		}

		rs.close();
		pstmt.close();
		conn.close();
		return result;

	}
	
	@Override
	public ArrayList<BookDTO> bestseller2() throws SQLException
	{
		ArrayList<BookDTO> result = new ArrayList<BookDTO>();

		Connection conn = dataSource.getConnection();
		String sql = "SELECT B.BOOK_NUM AS BOOK_NUM, B.BOOK_TITLE AS BOOK_TITLE , U.USER_NAME"
				+ " AS USER_NAME, TO_CHAR(B.BOOK_DATE, 'YYYY-MM-DD') AS BOOK_DATE, NVL(BOOK_COVER, '0') AS BOOK_COVER"
				+ " FROM VIEW_BESTSELLER VB, BOOK B, USERS U WHERE VB.BOOK_NUM = B.BOOK_NUM"
				+ " AND B.SIGN_NUM = U.SIGN_NUM AND VB.RNUM >=2 AND VB.RNUM<=5";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			BookDTO book = new BookDTO();

			book.setBook_num(rs.getInt("BOOK_NUM"));
			book.setBook_title(rs.getString("BOOK_TITLE"));
			book.setUser_name(rs.getString("USER_NAME"));
			book.setBook_date(rs.getString("BOOK_DATE"));
			book.setBook_cover(rs.getString("BOOK_COVER"));

			result.add(book);
		}

		rs.close();
		pstmt.close();
		conn.close();
		return result;

	}
	
	

	
	
}
