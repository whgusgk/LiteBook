package com.fp.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.fp.dto.RecordDTO;

public interface IUserRecordDAO
{
	// 전체 검색 리스트(여행책, 여행카드, 공지사항)
	public ArrayList<RecordDTO> list(String title, String type) throws SQLException;
}
