package com.fp.dao;

import java.sql.SQLException;

import com.fp.dto.BookDTO;
import com.fp.dto.CardDTO;
import com.fp.dto.CommentDTO;
import com.fp.dto.ReportDTO;

public interface IUserReportDAO
{
	// 회원이 다른 회원의 게시글 신고 - 신고폼 출력(type, 번호, 작성자, 내용)
	public ReportDTO list(String type, String num) throws SQLException;
	
	// 여행책 신고
	public int bInsert(BookDTO dto, ReportDTO rdto) throws SQLException;
	
	// 여행카드 신고
	public int cInsert(CardDTO dto, ReportDTO rdto) throws SQLException;
	
	// 댓글 신고
	public int coInsert(CommentDTO dto, ReportDTO Rdto) throws SQLException;
}
