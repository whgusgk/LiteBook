package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.FaqDTO;
import com.fp.dto.QnaDTO;
import com.fp.dto.ReportDTO;
import com.fp.dto.WarningDTO;
public interface IServiceDAO 
{	
	public int qnaCount(String sign_num) throws SQLException;
	public ArrayList<QnaDTO> qnaList(String sign_num, int start, int end) throws SQLException;
	
	public int reportCount(String sign_num) throws SQLException;
	public ArrayList<ReportDTO> reportList(String sign_num, int start, int end) throws SQLException;
	
	public int warningCount(String sign_num) throws SQLException;
	public int fackWarnintCount(String sign_num) throws SQLException;
	public ArrayList<WarningDTO> warningList(String sign_num, int start, int end) throws SQLException;
	
	// 자주 묻는 질문 리스트 출력
	public ArrayList<FaqDTO> list(int start, int end) throws SQLException;
		
	// 전체 자주 묻는 질문 개수 확인
	public int count() throws SQLException;
		
	// 카테고리에 따른 자주 묻는 질문 개수 확인
	public int searchCount(int qcategory_num) throws SQLException;
		
	// 카테고리에 따른 자주 묻는 질문 리스트 확인
	public ArrayList<FaqDTO> searchList(int start, int end, int qcategory_num) throws SQLException;
		
	// 질문하기 인서트 액션
	public int insert(QnaDTO dto, String sign_num) throws SQLException;
		
	
}
