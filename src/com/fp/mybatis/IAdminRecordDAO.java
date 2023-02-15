package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;

public interface IAdminRecordDAO
{
	// 여행카드 갯수 확인
	public int cardCount(String keyword);
	
	// 여행카드 리스트 확인
	public ArrayList<CardDTO> cardList(@Param("start") String start, @Param("end") String end, @Param("keyword") String keyword);
	
	// 여행카드 조회
	public CardDTO cardSearch(int card_num);
	
	// 여행카드 경고 처리 (신고 / 경고 테이블 동시에 인서트)
	public int insertCardWarning(CardDTO card);
	
	// 여행책 갯수 확인
	public int bookCount(String keyword);
	
	// 여행책 리스트 확인
	public ArrayList<BookDTO> bookList(@Param("start") String start, @Param("end") String end, @Param("keyword") String keyword);
	
	// 여행책 조회
	public BookDTO bookSearch(int book_num);
	
	// 여행책 경고 처리 (신고 / 경고 테이블 동시에 인서트)
	public int insertBookWarning(BookDTO book);
	
	
}
