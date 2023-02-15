/*====================
 	IAdminDAO.java
 	- 인터페이스
 ====================*/

package com.fp.mybatis;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.AdminDTO;

public interface IAdminDAO
{
	// search 관리자 번호로 관리자 개인정보 조회 
	public AdminDTO searchAccount(String admin_num);
	
	// 입력한 아이디가 존재하는지 확인 - 로그인 
	public String searchId(String admin_id);
	
	// 아이디 일치할 경우 비밀번호 확인 - 로그인
	public String searchPw(@Param("admin_id") String admin_id, @Param("admin_pw") String admin_pw);

	// update 관리자 개인정보 수정
	public int update(AdminDTO dto);
	
	// 아이디로 관리자 번호 조회(세션 값 부여 시 사용)
	public String sessionAdminNum(String admin_id);
}
