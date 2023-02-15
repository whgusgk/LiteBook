/*===================
	AdminDTO.java
====================*/

package com.fp.dto;

public class AdminDTO
{
	// 주요 속성 구성
	private String admin_num, admin_id, admin_pw;  								// 관리자 번호, 아이디, 비번
	private String admin_name, admin_tel, admin_birth, admin_email, gender_num;	// 관리자 이름, 전화번호, 생일, 이메일, 성별
	private String gender;
	
	// getter / setter 구성
	public String getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(String admin_num)
	{
		this.admin_num = admin_num;
	}
	public String getAdmin_id()
	{
		return admin_id;
	}
	public void setAdmin_id(String admin_id)
	{
		this.admin_id = admin_id;
	}
	public String getAdmin_pw()
	{
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw)
	{
		this.admin_pw = admin_pw;
	}
	public String getAdmin_name()
	{
		return admin_name;
	}
	public void setAdmin_name(String admin_name)
	{
		this.admin_name = admin_name;
	}
	public String getAdmin_tel()
	{
		return admin_tel;
	}
	public void setAdmin_tel(String admin_tel)
	{
		this.admin_tel = admin_tel;
	}
	public String getAdmin_birth()
	{
		return admin_birth;
	}
	public void setAdmin_birth(String admin_birth)
	{
		this.admin_birth = admin_birth;
	}
	public String getAdmin_email()
	{
		return admin_email;
	}
	public void setAdmin_email(String admin_email)
	{
		this.admin_email = admin_email;
	}
	public String getGender_num()
	{
		return gender_num;
	}
	public void setGender_num(String gender_num)
	{
		this.gender_num = gender_num;
	}
	public String getGender()
	{
		return gender;
	}
	public void setGender(String gender)
	{
		this.gender = gender;
	}
	
}
