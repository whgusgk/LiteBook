package com.fp.dto;

public class CommentDTO
{
	private String comment_num, sign_num, book_num;
	private String comment_content, comment_date;

	private String user_name;
	
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	
	// getter / setter 구성
	public String getComment_num()
	{
		return comment_num;
	}
	public void setComment_num(String comment_num)
	{
		this.comment_num = comment_num;
	}
	public String getSign_num()
	{
		return sign_num;
	}
	public void setSign_num(String sign_num)
	{
		this.sign_num = sign_num;
	}
	public String getBook_num()
	{
		return book_num;
	}
	public void setBook_num(String book_num)
	{
		this.book_num = book_num;
	}
	public String getComment_content()
	{
		return comment_content;
	}
	public void setComment_content(String comment_content)
	{
		this.comment_content = comment_content;
	}
	public String getComment_date()
	{
		return comment_date;
	}
	public void setComment_date(String comment_date)
	{
		this.comment_date = comment_date;
	}
	
	
}
