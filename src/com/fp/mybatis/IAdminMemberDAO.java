package com.fp.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.fp.dto.AdminMemberDTO;

public interface IAdminMemberDAO
{
	public ArrayList<AdminMemberDTO> memberList(@Param("start") String start, @Param("end") String end);
	
	public int memberCount();
	
	public AdminMemberDTO memberInfo(String sign_num);
	
	public ArrayList<AdminMemberDTO> bookList(@Param("sign_num") String sign_num, @Param("start") String start, @Param("end") String end);
	
	public int memberBookCount(String sign_num);
	
	public ArrayList<AdminMemberDTO> cardList(@Param("sign_num") String sign_num, @Param("start") String start, @Param("end") String end);
	
	public int memberCardCount(String sign_num);
	
	public ArrayList<AdminMemberDTO> commentList(@Param("sign_num") String sign_num, @Param("start") String start, @Param("end") String end);
	
	public int memberCommentCount(String sign_num);
	
	public ArrayList<AdminMemberDTO> warningList(String sign_num);
	
	public int memberWarningCount(String sign_num);
	
	public int bWarningCancelInsert(AdminMemberDTO admmin);
	
	public int cWarningCancelInsert(AdminMemberDTO admmin);
	
	public int coWarningCancelInsert(AdminMemberDTO admmin);
	
	public ArrayList<AdminMemberDTO> idSearchMemberList(@Param("value") String value, @Param("start") String start, @Param("end") String end);
	
	public ArrayList<AdminMemberDTO> nameSearchMemberList(@Param("value") String value, @Param("start") String start, @Param("end") String end);

	public int idMemberCount(String value);
	
	public int nameMemberCount(String value);
}
