package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.ScrapDTO;


public interface IScrapDAO
{
	public ArrayList<ScrapDTO> selectCardList(int start, int end, String book_num) throws SQLException;
	public int selectCardListCount(String book_num) throws SQLException;
	public int scrapInsert(String card_num, String sign_num) throws SQLException; 
	public ArrayList<ScrapDTO> scrapList(int start, int end, String sign_num) throws SQLException;
	public int scrapListCount(String sign_num) throws SQLException;
	public int scrapDelete(String scrap_num) throws SQLException;
		
}
