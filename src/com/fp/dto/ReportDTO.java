/*===================
	ReportDTO.java
====================*/

package com.fp.dto;

public class ReportDTO
{
	/*
	REPORT_NUM, REPORT_TITLE, WRITER, REPORT_DATE
	TYPE_NUM, TYPE, ADMIN_NUM, REASON_NUM
	, BSTATUS_DATE, BREPORT_NUM, 
	, CSTATUS_DATE, CREPORT_NUM
	, COSTATUS_DATE, COREPORT_NUM
	BSTATUS_NUM, BCANCEL_NUM, BCANCEL_MEMO
	CSTATUS_NUM, CCANCEL_NUM, CCANCEL_MEMO
	COSTATUS_NUM, COCANCEL_NUM, COCANCEL_MEMO 
	*/
	
	// 주요 속성 구성
	private String report_num, report_title, writer, report_date;
	private String type_num, type, admin_num, reason_num;
	private String bstatus_date, breport_num;
	private String cstatus_date, creport_num;
	private String costatus_date, coreport_num;
	private String bstatus_num, bcancel_num, bcancel_memo;
	private String cstatus_num, ccancel_num, ccancel_memo;
	private String costatus_num, cocancel_num, cocancel_memo;
	private String blind, status_state, reason, status_date;
	private String keyword;
	private String user_id, user_name, report_content;
	private String rnum;
	private String report_done;
	
	// getter / setter 구성
	public String getReport_num()
	{
		return report_num;
	}
	public void setReport_num(String report_num)
	{
		this.report_num = report_num;
	}
	public String getReport_title()
	{
		return report_title;
	}
	public void setReport_title(String report_title)
	{
		this.report_title = report_title;
	}
	public String getWriter()
	{
		return writer;
	}
	public void setWriter(String writer)
	{
		this.writer = writer;
	}
	public String getReport_date()
	{
		return report_date;
	}
	public void setReport_date(String report_date)
	{
		this.report_date = report_date;
	}
	public String getType_num()
	{
		return type_num;
	}
	public void setType_num(String type_num)
	{
		this.type_num = type_num;
	}
	public String getType()
	{
		return type;
	}
	public void setType(String type)
	{
		this.type = type;
	}
	public String getAdmin_num()
	{
		return admin_num;
	}
	public void setAdmin_num(String admin_num)
	{
		this.admin_num = admin_num;
	}
	public String getReason_num()
	{
		return reason_num;
	}
	public void setReason_num(String reason_num)
	{
		this.reason_num = reason_num;
	}
	public String getBstatus_date()
	{
		return bstatus_date;
	}
	public void setBstatus_date(String bstatus_date)
	{
		this.bstatus_date = bstatus_date;
	}
	public String getBreport_num()
	{
		return breport_num;
	}
	public void setBreport_num(String breport_num)
	{
		this.breport_num = breport_num;
	}
	public String getCstatus_date()
	{
		return cstatus_date;
	}
	public void setCstatus_date(String cstatus_date)
	{
		this.cstatus_date = cstatus_date;
	}
	public String getCreport_num()
	{
		return creport_num;
	}
	public void setCreport_num(String creport_num)
	{
		this.creport_num = creport_num;
	}
	public String getCostatus_date()
	{
		return costatus_date;
	}
	public void setCostatus_date(String costatus_date)
	{
		this.costatus_date = costatus_date;
	}
	public String getCoreport_num()
	{
		return coreport_num;
	}
	public void setCoreport_num(String coreport_num)
	{
		this.coreport_num = coreport_num;
	}
	public String getBstatus_num()
	{
		return bstatus_num;
	}
	public void setBstatus_num(String bstatus_num)
	{
		this.bstatus_num = bstatus_num;
	}
	public String getBcancel_num()
	{
		return bcancel_num;
	}
	public void setBcancel_num(String bcancel_num)
	{
		this.bcancel_num = bcancel_num;
	}
	public String getBcancel_memo()
	{
		return bcancel_memo;
	}
	public void setBcancel_memo(String bcancel_memo)
	{
		this.bcancel_memo = bcancel_memo;
	}
	public String getCstatus_num()
	{
		return cstatus_num;
	}
	public void setCstatus_num(String cstatus_num)
	{
		this.cstatus_num = cstatus_num;
	}
	public String getCcancel_num()
	{
		return ccancel_num;
	}
	public void setCcancel_num(String ccancel_num)
	{
		this.ccancel_num = ccancel_num;
	}
	public String getCcancel_memo()
	{
		return ccancel_memo;
	}
	public void setCcancel_memo(String ccancel_memo)
	{
		this.ccancel_memo = ccancel_memo;
	}
	public String getCostatus_num()
	{
		return costatus_num;
	}
	public void setCostatus_num(String costatus_num)
	{
		this.costatus_num = costatus_num;
	}
	public String getCocancel_num()
	{
		return cocancel_num;
	}
	public void setCocancel_num(String cocancel_num)
	{
		this.cocancel_num = cocancel_num;
	}
	public String getCocancel_memo()
	{
		return cocancel_memo;
	}
	public void setCocancel_memo(String cocancel_memo)
	{
		this.cocancel_memo = cocancel_memo;
	}
	public String getBlind()
	{
		return blind;
	}
	public void setBlind(String blind)
	{
		this.blind = blind;
	}
	public String getStatus_state()
	{
		return status_state;
	}
	public void setStatus_state(String status_state)
	{
		this.status_state = status_state;
	}
	public String getReason()
	{
		return reason;
	}
	public void setReason(String reason)
	{
		this.reason = reason;
	}
	public String getStatus_date()
	{
		return status_date;
	}
	public void setStatus_date(String status_date)
	{
		this.status_date = status_date;
	}
	public String getKeyword()
	{
		return keyword;
	}
	public void setKeyword(String keyword)
	{
		this.keyword = keyword;
	}

	public String getUser_id()
	{
		return user_id;
	}
	public void setUser_id(String user_id)
	{
		this.user_id = user_id;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getReport_content()
	{
		return report_content;
	}
	public void setReport_content(String report_content)
	{
		this.report_content = report_content;
	}
	public String getRnum()
	{
		return rnum;
	}
	public void setRnum(String rnum)
	{
		this.rnum = rnum;
	}
	public String getReport_done()
	{
		return report_done;
	}
	public void setReport_done(String report_done)
	{
		this.report_done = report_done;
	}
}
