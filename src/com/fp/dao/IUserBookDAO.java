package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.NoteDTO;

public interface IUserBookDAO
{
	//전체 책리스트 조회할 메소드 선언
	public ArrayList<BookDTO> allBookList(int start, int end) throws SQLException;
	
	//전체 책 개수를 카운트할 메소드 선언
	public int count() throws SQLException;
	
	
	//사용자의 책리스트를 조회할 메소드 선언
	public ArrayList<BookDTO> bookList(String sign_num, int start, int end) throws SQLException;
	//사용자의 책 개수를 카운트할 메소드 선언
	public int count(String sign_num) throws SQLException;
	
	//사용자의 책 열람하기 위한 메소드 선언(search)
	public BookDTO search(String book_num) throws SQLException;
	//사용자의 책 열람시 존재하는 카드들을 조회할 메소드 선언
	public ArrayList<CardDTO> cardList(String book_num) throws SQLException;
	
	
	//책 작성시 작성자의 여행노트 목록을 가져올 메소드 선언
	public ArrayList<NoteDTO> noteList(String sign_num) throws SQLException;
	//책 작성시 작성자의 여행노트에 포함된 여행카드 목록을 가져올 메소드 선언
	public ArrayList<CardDTO> notedCardList(String note_num) throws SQLException;
	
	
	public int bookInsert(BookDTO book) throws SQLException;
	public int bookedCardInsert(String book_num, String card_num) throws SQLException;
	public int maxBook(String sign_num) throws SQLException;
	
	
	public int bookDelete(String book_num) throws SQLException;
	public int bookedCardDelete(String book_num) throws SQLException;
	public BookDTO searchForUpdate(String book_num)throws SQLException;
	public ArrayList<CardDTO> bookedCardList(String book_num) throws SQLException;
	
	//Ajax로 여행책에 포함된 여행카드 삭제시키는 메소드 선언
	public int ajaxBookedCardDelete(String bcard_num) throws SQLException;
	
	//여행책 수정할 메소드 선언
	public int update(BookDTO book) throws SQLException;
	
	//여행책 댓글 리스트 선언
	public ArrayList<CommentDTO> commentList(String book_num) throws SQLException;
	
	//조회수 올리는 메소드 선언
	public int hitUpdate(String book_num)throws SQLException;
	
	public int likedInsert(String book_num, String sign_num) throws SQLException;
	public int likedDelete(String book_num, String sign_num) throws SQLException;
	public int likedCheck(String book_num, String sign_num) throws SQLException;
	
	public String searchUser(String user_name) throws SQLException;
	
	public ArrayList<BookDTO> bestseller() throws SQLException;
	public ArrayList<BookDTO> bestseller2() throws SQLException;
	
}
