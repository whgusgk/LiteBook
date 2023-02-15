package com.fp.dto;

public class BookDTO
{
	private int book_num, bcategory_num, book_hit;
	private String book_title, book_comment, book_date, book_redate, user_name, bline, bcategory_name;
	
	private String sign_num;
	
	// 신고처리 중 필요한 변수 선언
	private int rreason_num, type_num, admin_num;
	private String breport_title, breport_content;
	
	// 책 리스트 출력시 필요한 변수 선언(좋아요, 댓글, 대표사진)
	private int like_count, comment_count;
	private String book_cover;
	
	
	private int card_num;
	
	
	
	
	public int getCard_num()
	{
		return card_num;
	}
	public void setCard_num(int card_num)
	{
		this.card_num = card_num;
	}
	public String getSign_num()
	{
		return sign_num;
	}
	public void setSign_num(String sign_num)
	{
		this.sign_num = sign_num;
	}
	public String getBcategory_name()
	{
		return bcategory_name;
	}
	public void setBcategory_name(String bcategory_name)
	{
		this.bcategory_name = bcategory_name;
	}
	
	
	public int getLike_count()
	{
		return like_count;
	}
	public void setLike_count(int like_count)
	{
		this.like_count = like_count;
	}
	public int getComment_count()
	{
		return comment_count;
	}
	public void setComment_count(int comment_count)
	{
		this.comment_count = comment_count;
	}
	public String getBook_cover()
	{
		return book_cover;
	}
	public void setBook_cover(String book_cover)
	{
		this.book_cover = book_cover;
	}
	// getter / setter 구성
	public int getBook_num()
	{
		return book_num;
	}
	public void setBook_num(int book_num)
	{
		this.book_num = book_num;
	}
	public int getBcategory_num()
	{
		return bcategory_num;
	}
	public void setBcategory_num(int bcategory_num)
	{
		this.bcategory_num = bcategory_num;
	}
	public int getBook_hit()
	{
		return book_hit;
	}
	public void setBook_hit(int book_hit)
	{
		this.book_hit = book_hit;
	}
	public String getBook_title()
	{
		return book_title;
	}
	public void setBook_title(String book_title)
	{
		this.book_title = book_title;
	}
	public String getBook_comment()
	{
		return book_comment;
	}
	public void setBook_comment(String book_comment)
	{
		this.book_comment = book_comment;
	}
	public String getBook_date()
	{
		return book_date;
	}
	public void setBook_date(String book_date)
	{
		this.book_date = book_date;
	}
	public String getBook_redate()
	{
		return book_redate;
	}
	public void setBook_redate(String book_redate)
	{
		this.book_redate = book_redate;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getBline()
	{
		return bline;
	}
	public void setBline(String bline)
	{
		this.bline = bline;
	}
	public int getRreason_num()
	{
		return rreason_num;
	}
	public void setRreason_num(int rreason_num)
	{
		this.rreason_num = rreason_num;
	}
	public int getType_num()
	{
		return type_num;
	}
	public void setType_num(int type_num)
	{
		this.type_num = type_num;
	}
	public int getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(int admin_num)
	{
		this.admin_num = admin_num;
	}
	public String getBreport_title()
	{
		return breport_title;
	}
	public void setBreport_title(String breport_title)
	{
		this.breport_title = breport_title;
	}
	public String getBreport_content()
	{
		return breport_content;
	}
	public void setBreport_content(String breport_content)
	{
		this.breport_content = breport_content;
	}
	
	
}
