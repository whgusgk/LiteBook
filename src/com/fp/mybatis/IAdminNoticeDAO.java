/* =======================
	IAdminNoticeDAO.java
	- 인터페이스
======================= */

package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.NoticeDTO;

public interface IAdminNoticeDAO
{
	// 전체 공지사항 개수 확인
	public int count(String keyword);
	
	// 공지사항 리스트 확인
	public ArrayList<NoticeDTO> list(@Param("start") String start, @Param("end") String end, @Param("keyword") String keyword);
	
	// 공지사항 신규등록
	public int insert(NoticeDTO notice);

	// 공지사항 수정
	public int update(NoticeDTO notice);

	// 공지사항 삭제
	public int delete(String noticeNum);
	
	// 공지사항 열람
	public NoticeDTO search(int notice_num);
	
}
