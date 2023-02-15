package com.fp.dto;

public class CardDTO
{
	private int card_num, note_num;
	private String card_location, blind, user_name, card_date;
	
	private String sign_num, open_num;
	private String card_lat, card_lng, card_address;
	private String card_comment, card_visitdate, card_time;
	private String card_img1, card_img2, card_img3;
	private String place_url, card_budget, pay_amount;
	
	// 신고처리 중 필요한 변수 선언
	private int rreason_num, type_num, admin_num;
	private String creport_title, creport_content;
	//여행책에 포함된 여행카드 잡아올 변수 선언
	private int bcard_num;

	// getter / setter 구성
	
	public int getBcard_num()
	{
		return bcard_num;
	}
	public void setBcard_num(int bcard_num)
	{
		this.bcard_num = bcard_num;
	}
	public int getCard_num()
	{
		return card_num;
	}
	public String getPay_amount()
	{
		return pay_amount;
	}
	public void setPay_amount(String pay_amount)
	{
		this.pay_amount = pay_amount;
	}
	public void setCard_num(int card_num)
	{
		this.card_num = card_num;
	}
	public String getCard_budget()
	{
		return card_budget;
	}
	public void setCard_budget(String card_budget)
	{
		this.card_budget = card_budget;
	}
	public String getCard_location()
	{
		return card_location;
	}
	public void setCard_location(String card_location)
	{
		this.card_location = card_location;
	}
	public String getBlind()
	{
		return blind;
	}
	public void setBlind(String blind)
	{
		this.blind = blind;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getCard_date()
	{
		return card_date;
	}
	public void setCard_date(String card_date)
	{
		this.card_date = card_date;
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
	public String getCreport_title()
	{
		return creport_title;
	}
	public void setCreport_title(String creport_title)
	{
		this.creport_title = creport_title;
	}
	public String getCreport_content()
	{
		return creport_content;
	}
	public void setCreport_content(String creport_content)
	{
		this.creport_content = creport_content;
	}
	public String getSign_num()
	{
		return sign_num;
	}
	public void setSign_num(String sign_num)
	{
		this.sign_num = sign_num;
	}
	public String getOpen_num()
	{
		return open_num;
	}
	public void setOpen_num(String open_num)
	{
		this.open_num = open_num;
	}
	public String getCard_lat()
	{
		return card_lat;
	}
	public void setCard_lat(String card_lat)
	{
		this.card_lat = card_lat;
	}
	public String getCard_lng()
	{
		return card_lng;
	}
	public void setCard_lng(String card_lng)
	{
		this.card_lng = card_lng;
	}
	public String getCard_address()
	{
		return card_address;
	}
	public void setCard_address(String card_address)
	{
		this.card_address = card_address;
	}
	public String getCard_comment()
	{
		return card_comment;
	}
	public void setCard_comment(String card_comment)
	{
		this.card_comment = card_comment;
	}
	public String getCard_visitdate()
	{
		return card_visitdate;
	}
	public void setCard_visitdate(String card_visitdate)
	{
		this.card_visitdate = card_visitdate;
	}
	public String getCard_time()
	{
		return card_time;
	}
	public void setCard_time(String card_time)
	{
		this.card_time = card_time;
	}
	public String getCard_img1()
	{
		return card_img1;
	}
	public void setCard_img1(String card_img1)
	{
		this.card_img1 = card_img1;
	}
	public String getCard_img2()
	{
		return card_img2;
	}
	public void setCard_img2(String card_img2)
	{
		this.card_img2 = card_img2;
	}
	public String getCard_img3()
	{
		return card_img3;
	}
	public void setCard_img3(String card_img3)
	{
		this.card_img3 = card_img3;
	}
	public String getPlace_url()
	{
		return place_url;
	}
	public void setPlace_url(String place_url)
	{
		this.place_url = place_url;
	}
	public int getNote_num()
	{
		return note_num;
	}
	public void setNote_num(int note_num)
	{
		this.note_num = note_num;
	}
	
	
	
}
