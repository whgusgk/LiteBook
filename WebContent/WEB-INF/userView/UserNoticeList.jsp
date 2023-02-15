<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserNoticeList.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserNoticeList.css">
<style type="text/css">
 
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

</head>   
<body class="Site">
   <div class="Site-content" id="wrap">
      <div class="import">
            <c:import url="UserMenu.jsp"></c:import>
      </div><!-- import -->
   
      <div class="main_title">
         <h2>공지 사항</h2>
      </div><!-- main_title -->
               
      <br><br>   
      <div class="main_listWrapper">
      <form action="usernoticelist.action" method="get" id="searchForm" class="form-inline">
            <div class="main_rightHeader">
               <div class="input-group inputArea">
                  <input type="text" name="keyword" class="form-control searchInput" id="searchInput">
                  <button type="submit" class="btn btn-primary submitBtn" id="submitBtn">
                     <i class="fa-solid fa-magnifying-glass"></i> 
                  </button>
               </div>
         </div><!-- main_rightFooter -->
      </form>	
      	<br><br><br>
         <div class="main_list">
            <table class="table table-hover">
            <thead>
               <tr>
                  <th></th>
                  <th>제목</th>
                  <th>작성일</th>
               </tr>
            </thead>
            <tbody>
               <!-- <tr>
                  <td>1</td>
                  <td>필독사항입니다.</td>
                  <td>2022.12.11</td>
               </tr>
               <tr>
                  <td>2</td>
                  <td>계정정지 관련 공지사항입니다.</td>
                  <td>2022.12.12</td>
               </tr> -->
               <c:forEach var="list" items="${list }">
	               	<tr>
	                  <td>${list.notice_num }</td>
	                  <td>
		                  <a href="${noticeUrl }&notice_num=${list.notice_num}">
		                  	${list.notice_title }
		                  </a>
		                  </td>
	                  <td>${list.notice_date }</td>
	               </tr>
               </c:forEach>
                  <!-- 테스트 -->
               </tbody>
            </table>
         </div><!-- main_list -->
      </div><!-- main_listWrapper -->
</div><!-- wrapper -->

<!-- footer -->
<!-- pageNav -->
<nav aria-label="" class="pageNav">
  <!-- <ul class="pagination" >
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">◀</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item active" aria-current="page">
      <a class="page-link" href="#">2</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item">
      <a class="page-link" href="#">▶</a>
    </li>
  </ul> -->
  ${pageList }
</nav>
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->

</body>
</html>