package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.LikedDTO;
import com.fp.dto.QnaDTO;
import com.fp.dto.UserDTO;

public interface IMyPageDAO 
{	
	public UserDTO search(String sign_num) throws SQLException;
	
	public ArrayList<String> searchFregion(String sign_num) throws SQLException;
	public ArrayList<String> searchFcategory(String sign_num) throws SQLException;

	public ArrayList<UserDTO> userFregion(String sign_num) throws SQLException;
	
	
	public int likedBookCount(String sign_num) throws SQLException;
	public ArrayList<LikedDTO> likedBookList(String sign_num, int start, int end) throws SQLException;
	
	public int commentCount(String sign_num) throws SQLException;
	public ArrayList<CommentDTO> commentList(String sign_num, int start, int end) throws SQLException;
	
	public ArrayList<UserDTO> regionList() throws SQLException;
	public ArrayList<UserDTO> tcategoryList() throws SQLException;
	
	public int BookCount(String sign_num) throws SQLException;
	public ArrayList<BookDTO> bookList(String sign_num, int start, int end) throws SQLException;
	
	public int CardCount(String sign_num) throws SQLException;
	public ArrayList<CardDTO> cardList(String sign_num,int start, int end) throws SQLException;
	
	// 내가 질문 한 내역 리스트 출력
	public ArrayList<QnaDTO> myqnaList(String sign_num) throws SQLException;
	
	// 나의 정보 수정
	public int update(UserDTO dto) throws SQLException;
	
	// 나의 관심지역 등록
	public int fregionInsert(String region_num, String sign_num) throws SQLException;
	
	// 나의 관심카테고리 등록
	public int fcategoryInsert(String category_num, String sign_num) throws SQLException;
	
	// 나의 관심지역 삭제
	public int fregionDelete(String sign_num) throws SQLException;

	// 나의 관심카테고리 삭제
	public int fcategoryDelete(String sign_num) throws SQLException;
	
	// 나의 프로필 사진 수정
	public int profileUpdate(String sign_num, String imgPath) throws SQLException;
}






