/* =======================
	IAdminNoticeDAO.java
	- 인터페이스
======================= */

package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.FaqDTO;

public interface IAdminFaqDAO
{
	// 전체 자주 묻는 질문 개수 확인
	public int count();
	
	// 카테고리에 따른 자주 묻는 질문 개수 확인
	public int searchCount(int qcategory_num);
	
	// 자주 묻는 질문 리스트 확인
	public ArrayList<FaqDTO> list(@Param("start") int start, @Param("end") int end);

	// 카테고리에 따른 자주 묻는 질문 리스트 확인
	public ArrayList<FaqDTO> searchList(@Param("start") int start, @Param("end") int end, @Param("qcategory_num") int qcategory_num);
	
	// 자주 묻는 질문 열람
	public FaqDTO search(int faq_num);
	
	// 자주 묻는 질문 신규등록
	public int insert(FaqDTO faq);

	// 자주 묻는 질문 수정
	public int update(FaqDTO faq);

	// 자주 묻는 질문 삭제
	public int delete(String faq_num);
	
}
