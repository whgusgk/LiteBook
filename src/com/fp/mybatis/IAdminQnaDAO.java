/* =======================
	IAdminNoticeDAO.java
	- 인터페이스
======================= */

package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.QnaDTO;

public interface IAdminQnaDAO
{
	// 질문 개수 확인
	public int count(String question_done);
	
	// 질문 리스트 확인
	public ArrayList<QnaDTO> list(@Param("start") String start, @Param("end") String end, @Param("question_done") String question_done);
	
	// 답변 등록
	public int insert(QnaDTO qna);

	// 질문 열람
	public QnaDTO searchQuestion(int question_num);
	
	// 답변 열람
	public QnaDTO searchAnswer(int answer_num);
	
}
