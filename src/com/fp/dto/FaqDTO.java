package com.fp.dto;

public class FaqDTO
{
	private int faq_num, admin_num, qcategory_num;
	private String faq_question, faq_answer;
	
	// getter / setter 구성
	public int getFaq_num()
	{
		return faq_num;
	}
	public void setFaq_num(int faq_num)
	{
		this.faq_num = faq_num;
	}
	public int getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(int admin_num)
	{
		this.admin_num = admin_num;
	}
	public int getQcategory_num()
	{
		return qcategory_num;
	}
	public void setQcategory_num(int qcategory_num)
	{
		this.qcategory_num = qcategory_num;
	}
	public String getFaq_question()
	{
		return faq_question;
	}
	public void setFaq_question(String faq_question)
	{
		this.faq_question = faq_question;
	}
	public String getFaq_answer()
	{
		return faq_answer;
	}
	public void setFaq_answer(String faq_answer)
	{
		this.faq_answer = faq_answer;
	}
	
	
}
