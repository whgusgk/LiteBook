package com.fp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.fp.dto.ScrapDTO;

public class ScrapDAO implements IScrapDAO
{
   // 주요 속성 구성 → 인터페이스 형태
   private DataSource dataSource;

   // setter 구성
   public void setDataSource(DataSource dataSource)
   {
      this.dataSource = dataSource;
   }

   @Override
   public ArrayList<ScrapDTO> selectCardList(int start, int end, String book_num) throws SQLException
   {
      ArrayList<ScrapDTO> result = new ArrayList<ScrapDTO>();
      Connection conn = dataSource.getConnection();

      String sql = "SELECT LIST_NUM, CARD_LOCATION, CARD_BUDGET, CARD_ADDRESS, USER_NAME"
            + ", CARD_NUM, BOOK_NUM FROM(SELECT ROWNUM AS LIST_NUM, CARD_LOCATION"
            + ", CARD_BUDGET, CARD_ADDRESS, USER_NAME, CARD_NUM, BOOK_NUM"
            + " FROM VIEW_BOOKEDCARDLIST WHERE BOOK_NUM=?)"
            + "WHERE LIST_NUM >= ? AND LIST_NUM <= ?";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(book_num));
      pstmt.setInt(2, start);
      pstmt.setInt(3, end);
      ResultSet rs = pstmt.executeQuery();
      
      while (rs.next())
      {
         /*
          * ScrapDTO scrap = new ScrapDTO();
          * 
          * scrap.setList_num(String.valueOf(rs.getInt("LIST_NUM")));
          * 
          * scrap.setCard_location(rs.getString("CARD_LOCATION"));
          * scrap.setCard_time(rs.getString("CARD_TIME"));
          * scrap.setCard_address(rs.getString("CARD_ADDRESS"));
          * scrap.setUser_name(rs.getString("USER_NAME"));
          * scrap.setCard_num(String.valueOf(rs.getInt("CARD_NUM")));
          * scrap.setBook_num(String.valueOf(rs.getInt("BOOK_NUM"))); result.add(scrap);
          */
         
         ScrapDTO scrap = new ScrapDTO();

         scrap.setList_num(rs.getString("LIST_NUM"));
         
         scrap.setCard_location(rs.getString("CARD_LOCATION"));
         scrap.setCard_budget(rs.getString("CARD_BUDGET"));
         scrap.setCard_address(rs.getString("CARD_ADDRESS"));
         scrap.setUser_name(rs.getString("USER_NAME"));
         scrap.setCard_num(rs.getString("CARD_NUM"));
         scrap.setBook_num(rs.getString("BOOK_NUM"));
         result.add(scrap);
      }

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }
   
   @Override
   public int selectCardListCount(String book_num) throws SQLException
   {
      int result =0;
      Connection conn = dataSource.getConnection();

      String sql = "SELECT COUNT(*) AS COUNT FROM VIEW_BOOKEDCARDLIST WHERE BOOK_NUM=?";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(book_num));
      ResultSet rs = pstmt.executeQuery();
      
      while (rs.next())
         result = rs.getInt("COUNT");

      pstmt.close();
      conn.close();

      return result;
   }

   @Override
   public int scrapInsert(String card_num, String sign_num) throws SQLException
   {
      int result = 0;

      Connection conn = dataSource.getConnection();

      String sql = "INSERT INTO SCRAP(SCRAP_NUM, CARD_NUM, SIGN_NUM)"
            + " VALUES(SCRAP_SEQ.NEXTVAL, ?, ?)";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(card_num));
      pstmt.setInt(2, Integer.parseInt(sign_num));

      result = pstmt.executeUpdate();

      pstmt.close();
      conn.close();

      return result;
   }

   @Override
   public ArrayList<ScrapDTO> scrapList(int start, int end, String sign_num) throws SQLException
   {
      ArrayList<ScrapDTO> result = new ArrayList<ScrapDTO>();
      Connection conn = dataSource.getConnection();

      String sql = "SELECT LIST_NUM, SCRAP_NUM, CARD_LOCATION, CARD_BUDGET, CARD_ADDRESS"
            + ", USER_NAME, CARD_NUM FROM(SELECT ROWNUM AS LIST_NUM, SCRAP_NUM, CARD_LOCATION"
            + ", CARD_BUDGET, CARD_ADDRESS, USER_NAME, CARD_NUM FROM VIEW_USERSCRAPLIST"
            + " WHERE SIGN_NUM=? AND OPEN_NUM=1)WHERE LIST_NUM >= ? AND LIST_NUM <= ?";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(sign_num));
      pstmt.setInt(2, start);
      pstmt.setInt(3, end);
      ResultSet rs = pstmt.executeQuery();
      
      while (rs.next())
      {
         ScrapDTO scrap = new ScrapDTO();

         scrap.setList_num(rs.getString("LIST_NUM"));
         scrap.setScrap_num(rs.getString("SCRAP_NUM"));
         scrap.setCard_location(rs.getString("CARD_LOCATION"));
         scrap.setCard_budget(rs.getString("CARD_BUDGET"));
         scrap.setCard_address(rs.getString("CARD_ADDRESS"));
         scrap.setUser_name(rs.getString("USER_NAME"));
         scrap.setCard_num(rs.getString("CARD_NUM"));
         
         result.add(scrap);
      }

      rs.close();
      pstmt.close();
      conn.close();
      return result;
   }
   
   @Override
   public int scrapListCount(String sign_num) throws SQLException
   {
      int result = 0;
      Connection conn = dataSource.getConnection();

      String sql = "SELECT COUNT(*) AS COUNT FROM VIEW_USERSCRAPLIST  WHERE SIGN_NUM=? AND OPEN_NUM=1";

      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(sign_num));
      ResultSet rs = pstmt.executeQuery();
      while (rs.next())
         result = rs.getInt("COUNT");
      pstmt.close();
      conn.close();

      return result;
   }

   @Override
   public int scrapDelete(String scrap_num) throws SQLException
   {
      int result = 0;
      Connection conn = dataSource.getConnection();

      String sql = "DELETE  FROM SCRAP WHERE SCRAP_NUM = ?";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(scrap_num));

      result = pstmt.executeUpdate();

      pstmt.close();
      conn.close();

      return result;
   }
   
   
   
   
}