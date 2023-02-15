package com.fp.dto;

public class PayDTO
{
	private String pay_num, card_num, ptype_num;
	private String pay_name, pay_amount, ptype_name;
	
	// getter / setter 구성
	

	public String getPtype_name()
	{
		return ptype_name;
	}
	public void setPtype_name(String ptype_name)
	{
		this.ptype_name = ptype_name;
	}
	public String getPay_num()
	{
		return pay_num;
	}
	public void setPay_num(String pay_num)
	{
		this.pay_num = pay_num;
	}
	public String getCard_num()
	{
		return card_num;
	}
	public void setCard_num(String card_num)
	{
		this.card_num = card_num;
	}
	public String getPtype_num()
	{
		return ptype_num;
	}
	public void setPtype_num(String ptype_num)
	{
		this.ptype_num = ptype_num;
	}
	public String getPay_name()
	{
		return pay_name;
	}
	public void setPay_name(String pay_name)
	{
		this.pay_name = pay_name;
	}
	public String getPay_amount()
	{
		return pay_amount;
	}
	public void setPay_amount(String pay_amount)
	{
		this.pay_amount = pay_amount;
	}
	
	
}
