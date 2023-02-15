package com.fp.dto;

public class NoticeDTO
{
	private int notice_num, admin_num;
	private String notice_title, notice_date, notice_content;

	// getter / setter 구성
	public int getNotice_num()
	{
		return notice_num;
	}
	public void setNotice_num(int notice_num)
	{
		this.notice_num = notice_num;
	}
	public int getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(int admin_num)
	{
		this.admin_num = admin_num;
	}
	public String getNotice_title()
	{
		return notice_title;
	}
	public void setNotice_title(String notice_title)
	{
		this.notice_title = notice_title;
	}
	public String getNotice_date()
	{
		return notice_date;
	}
	public void setNotice_date(String notice_date)
	{
		this.notice_date = notice_date;
	}
	public String getNotice_content()
	{
		return notice_content;
	}
	public void setNotice_content(String notice_content)
	{
		this.notice_content = notice_content;
	}
	
	
	
}
