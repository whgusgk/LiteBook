package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.NoticeDTO;

public interface IUserNoticeDAO
{
	// 공지사항 리스트 출력
	public ArrayList<NoticeDTO> list(int start, int end, String keyword) throws SQLException;
	
	// 공지사항 게시글 총 개수
	public int count(String keyword) throws SQLException;
	
	// 공지사항 게시글 상세 열람 페이지 출력
	public NoticeDTO search(int notice_num) throws SQLException;
}
