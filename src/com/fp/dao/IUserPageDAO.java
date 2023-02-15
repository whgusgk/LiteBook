package com.fp.dao;

import java.sql.SQLException;

import com.fp.dto.UserDTO;

public interface IUserPageDAO
{
	// 입력한 아이디가 존재하는지 확인 - 로그인 
	// 존재하는 경우 개수 반환(1,0)
	public String idCheck(String user_id) throws SQLException;
		
	// 아이디 일치할 경우 비밀번호 확인 - 로그인
	// 일치하면 아이디 반환
	public String pwCheck(String user_id, String user_pw) throws SQLException;
	
	// 아이디로 유저 등록번호 조회(세션 값 부여 시 사용)
	public String sessionSignNum(String user_id) throws SQLException;
	
	// 이름 중복체크
	public String nameCheck(String user_name) throws SQLException;
		
	// 유저 회원가입
	public int add(UserDTO dto) throws SQLException;
		
	// 지역 카테고리 등록
	public int regionAdd(UserDTO dto) throws SQLException;
		
	// 관심 카테고리 등록
	public int categoryAdd(UserDTO dto) throws SQLException;
		
	// 아이디 찾기
	public String findUserId(String user_name, String user_email) throws SQLException;
		
	// 비밀번호 찾기 
	public String findPwd1(String user_id) throws SQLException;
	public String findPwd2(String user_email) throws SQLException;
		
	// 비밀번호 수정을 위한 등록번호 찾기
	public String searchId(String user_id) throws SQLException;
	
	// 비밀번호 재설정
    public int modify(String sign_num, String user_pw) throws SQLException;
		
	// 환영페이지에 이름 출력
	public String searchName(String sign_num) throws SQLException;
	
		// 회원 탈퇴 기능
	public int delete(String sign_num) throws SQLException;
	
	// 닉네임 중복 확인 기능
	public int nickNameCheck(String nickName) throws SQLException;
	
	// 활동게이지
	public int liked(String sign_num) throws SQLException;
	public int comment_Count(String sign_num) throws SQLException;
	public int book_Count(String sign_num) throws SQLException;
	public int warning_Count(String sign_num) throws SQLException;
	
	// 회원 정지 여부 확인
	public String stopSearch(String sign_num) throws SQLException;
		
	// 정지된 회원 가장 최근에 경고받은 게시글 처리일자 출력
	public String stopDate(String sign_num) throws SQLException;
		
	// 로그인 성공 시 마지막 접속 시간 업데이트
	public int updateFDate(String sign_num) throws SQLException;
}
