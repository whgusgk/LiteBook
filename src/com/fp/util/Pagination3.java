package com.fp.util;

public class Pagination3
{
   // 전체 페이지 구하기
   public int PageCount(int count)
   {
      int result = 0;
      
      // 한 페이지에 15개 게시물
      result = count / 15;
      
      // 딱 나누어 떨어지지 않는다면...
      if (count%15 != 0)
         result++;
      
      return result;
   }
   
   // 페이징 처리 구문
   public String getIndexList(int currentPage, int totalPage, String listUrl)
   {
      StringBuffer strList = new StringBuffer();
      
      // 페이징 처리 시 숫자 5개씩
      int numPerBlock = 5;
      
      int currentPageSetup;
      int page;
      int n;
      
      // 한 페이지도 못 채운다면 페이징 처리가 필요 없다
      if (currentPage == 0)
         return "";
      
      // 5개 한 묶음 중 몇 번째를 보여줄 것인가!
      currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
      
      // 5, 10, 15 ... 페이지라면 다음 페이지 블럭으로 넘어가지 않도록 처리
      if (currentPage % numPerBlock == 0)
         currentPageSetup = currentPageSetup - numPerBlock;
      
      strList.append("<ul class=\"pagination\" >");
      
      // 화살표 링크 구성
      n = currentPage - numPerBlock;
      if ( (totalPage > numPerBlock) && (currentPageSetup > 0) )
      {
         strList.append("<li class=\"page-item\">");
         strList.append("<a class='page-link' href='"+ listUrl + "pageNum=" + n +"' tabindex='-1'>◀</a>");
         strList.append("</li>");
      }
      else
      {
         strList.append("<li class=\"page-item disabled\">");
         strList.append("<a class='page-link' href='#' tabindex='-1' aria-disabled='true'>◀</a>");
         strList.append("</li>");
      }
      
      // 페이지 바로가기
      page = currentPageSetup + 1;
      
      while ( (page <= totalPage) && (page <= currentPageSetup + numPerBlock) )
      {
         if (page==currentPage)
         {
            strList.append("<li class='page-item active' aria-current='page'>");
            strList.append("<a class='page-link' href='#'>" + page + "</a>");
            strList.append("</li>");
         }
         else
            strList.append("<li class='page-item'><a class='page-link' href='"+ listUrl +"&pageNum=" + page + "'>" + page + "</li>");
         
         page++;

      }      
      
      // 마지막 화살표 링크 구성
      n = currentPage + numPerBlock;
      if ( (totalPage - currentPageSetup) > numPerBlock )
      {
         strList.append("<li class=\"page-item\">");
         strList.append("<a class='page-link' href='"+ listUrl + "pageNum=" + n +"' tabindex='-1'>▶</a>");
         strList.append("</li>");
      }
      else
      {
         strList.append("<li class=\"page-item disabled\">");
         strList.append("<a class='page-link' href='#' tabindex='-1' aria-disabled='true'>▶</a>");
         strList.append("</li>");
      }
      
      strList.append("</ul>");
      
      return strList.toString();
   }
}