package com.fp.dto;

public class LikedDTO
{
	private String liked_num, liker_num, liker_name, liked_date; 
	private String book_num, book_title, writer_name, book_date;
	private String sign_num, count;
	
	public String getCount()
	{
		return count;
	}
	public void setCount(String count)
	{
		this.count = count;
	}
	public String getSign_num()
	{
		return sign_num;
	}
	public void setSign_num(String sign_num)
	{
		this.sign_num = sign_num;
	}
	// getter / setter 구성
	public String getLiked_num()
	{
		return liked_num;
	}
	public void setLiked_num(String liked_num)
	{
		this.liked_num = liked_num;
	}
	public String getLiker_num()
	{
		return liker_num;
	}
	public void setLiker_num(String liker_num)
	{
		this.liker_num = liker_num;
	}
	public String getLiker_name()
	{
		return liker_name;
	}
	public void setLiker_name(String liker_name)
	{
		this.liker_name = liker_name;
	}
	public String getLiked_date()
	{
		return liked_date;
	}
	public void setLiked_date(String liked_date)
	{
		this.liked_date = liked_date;
	}
	public String getBook_num()
	{
		return book_num;
	}
	public void setBook_num(String book_num)
	{
		this.book_num = book_num;
	}
	public String getBook_title()
	{
		return book_title;
	}
	public void setBook_title(String book_title)
	{
		this.book_title = book_title;
	}
	public String getWriter_name()
	{
		return writer_name;
	}
	public void setWriter_name(String writer_name)
	{
		this.writer_name = writer_name;
	}
	public String getBook_date()
	{
		return book_date;
	}
	public void setBook_date(String book_date)
	{
		this.book_date = book_date;
	}
	
	
}
