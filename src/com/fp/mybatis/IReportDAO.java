/*====================
 	IReportDAO.java
 	- 인터페이스
 ====================*/

package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.ReportDTO;

public interface IReportDAO
{
	// list 신고 내역 리스트(여행책,여행카드,댓글) - 전체
	public ArrayList<ReportDTO> list(@Param("start") String start, @Param("end") String end);
	
	// list 신고 내역 리스트(전체, 미처리, 처리)
	public ArrayList<ReportDTO> reportlist(@Param("cstatusnum") String cstatusnum, @Param("start") String start, @Param("end") String end);
	
	// searchList 신고자 명(키워드)으로 신고 리스트 조회
	public ArrayList<ReportDTO> searchList(String keyword);
	
	// bStatusInsert 회원의 책 신고를 처리완료로 만들어주는 작업
	public int bStatusInsert(ReportDTO dto);
	
	// cStatusInsert 회원의 카드 신고를 처리완료로 만들어주는 작업
	public int cStatusInsert(ReportDTO dto);
	
	// coStatusInsert 회원의 댓글 신고를 처리완료로 만들어주는 작업
	public int coStatusInsert(ReportDTO dto);

	// type, 신고번호로 신고된 내역 리스트 조회
	public ReportDTO searchReportNum(@Param("type") String type, @Param("report_num") String report_num);

	// list 신고 내역 리스트(여행책,여행카드,댓글) - 총 게시물 개수
	public int count();
	
	// list 신고 내역 리스트(여행책,여행카드,댓글) - 미처리 게시물 개수
	public int noneChekcount();
	
	// list 신고 내역 리스트(여행책,여행카드,댓글) - 처리완료 게시물 개수
	public int Checkcount();

}







