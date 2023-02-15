package com.fp.mybatis;

import java.util.ArrayList;

import com.fp.dto.AdminMainDTO;

public interface IAdminMainDAO
{
	public int memberCount();
	public int bookCount();
	public ArrayList<AdminMainDTO> newReportList();
	public ArrayList<AdminMainDTO> newQuestionList();
	
}
