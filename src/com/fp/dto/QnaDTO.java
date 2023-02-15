package com.fp.dto;

public class QnaDTO
{
	private int question_num, qcategory_num, admin_num, answer_num;
	private String admin_name, user_name; 
	private String qcategory_class, question_title, question_content, question_date, question_done; 
	private String answer_content, answer_date;
	
	// getter / setter 구성
	public int getQuestion_num()
	{
		return question_num;
	}
	public void setQuestion_num(int question_num)
	{
		this.question_num = question_num;
	}
	public int getQcategory_num()
	{
		return qcategory_num;
	}
	public void setQcategory_num(int qcategory_num)
	{
		this.qcategory_num = qcategory_num;
	}
	public int getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(int admin_num)
	{
		this.admin_num = admin_num;
	}
	public int getAnswer_num()
	{
		return answer_num;
	}
	public void setAnswer_num(int answer_num)
	{
		this.answer_num = answer_num;
	}
	public String getAdmin_name()
	{
		return admin_name;
	}
	public void setAdmin_name(String admin_name)
	{
		this.admin_name = admin_name;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getQcategory_class()
	{
		return qcategory_class;
	}
	public void setQcategory_class(String qcategory_class)
	{
		this.qcategory_class = qcategory_class;
	}
	public String getQuestion_title()
	{
		return question_title;
	}
	public void setQuestion_title(String question_title)
	{
		this.question_title = question_title;
	}
	public String getQuestion_content()
	{
		return question_content;
	}
	public void setQuestion_content(String question_content)
	{
		this.question_content = question_content;
	}
	public String getQuestion_date()
	{
		return question_date;
	}
	public void setQuestion_date(String question_date)
	{
		this.question_date = question_date;
	}
	public String getQuestion_done()
	{
		return question_done;
	}
	public void setQuestion_done(String question_done)
	{
		this.question_done = question_done;
	}
	public String getAnswer_content()
	{
		return answer_content;
	}
	public void setAnswer_content(String answer_content)
	{
		this.answer_content = answer_content;
	}
	public String getAnswer_date()
	{
		return answer_date;
	}
	public void setAnswer_date(String answer_date)
	{
		this.answer_date = answer_date;
	}

	
}
