<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserBookList.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserBookList.css">
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

<script type="text/javascript">
	$(function(){
		
		//alert("확인");
		$("#addBtn").click(function(){
				$(location).attr("href","userbookinsertform.action?sign_num=" + $(this).val());
		});
	});
</script>
</head>	
<body class="Site">
	<div class="Site-content" id="wrap">
		<div class="import">
				<c:import url="UserMenu.jsp"></c:import>
		</div><!-- import -->
	
		<div class="main_title">
			<h3>여행 기록 </h3><h5>당신의 특별한 여행을 특별하게 기록하세요!</h5>
		</div><!-- main_title -->
					
		<div class="main_header">
			<div class="main_leftHeader">
				<button type="button" class="btn btn-default noteBtn" id="noteBtn">여행노트</button>
				<button type="button" class="btn btn-primary bookBtn" id="bookBtn">여행책</button>
			</div><!-- main_leftHeader -->
			
			<!-- 
			<form action="" method="post" id="searchForm" class="form-inline">
			   <div class="main_rightFooter">
               <select class="form-control selectArea" aria-label=abled id="type">
                  <option value="0" selected>전체</option>
                  <option value="1">제목</option>
               </select>
               </div>
                 </form>
			 -->			
			<div class="main_rightHeader">
				<button type="button" class="btn btn-primary addBtn" id="addBtn" value="${userSession }">글쓰기</button>
			</div><!-- main_rightHeader -->
		</div><!-- main_header -->
		<br>
	 	<select class="form-control selectArea" aria-label=abled id="type">
                  <option value="0" selected>전체</option>
                  <option value="1">맛집</option>
				  <option value="2">쇼핑</option>
				  <option value="3">체험</option>
				  <option value="4">힐링</option>
				  <option value="5">기타</option>
               </select>
		<br>
		<div class="main_listWrapper">
		<div class="main_list">
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				
				<c:forEach var="book" items="${bookList }">
					<tr>
						<td>${book.book_num }</td>
						<td>${book.bcategory_name }</td>
						<td>
							<a href="${bookUrl }&book_num=${book.book_num }">
								${book.book_title }
							</a>
						</td>
						<td>${book.book_redate }</td>
						<td>${book.book_hit }</td>
					</tr>
				</c:forEach>
<!-- 					<tr>
						<td>1</td>
						<td>맛집탐방</td>
						<td>울릉도 맛집 10선</td>
						<td>2022.12.14</td>
						<td>10</td>
					</tr>
					<tr>
						<td>2</td>
						<td>힐링</td>
						<td>국내 꽃구경 명소 TOP3</td>
						<td>2022.12.23</td>
						<td>5</td>
					</tr> -->
				</tbody>
			</table>
		</div><!-- main_list -->
	</div><!-- main_listWrapper -->
</div><!-- wrapper -->

<!-- footer -->
<!-- pageNav -->
<nav aria-label="" class="pageNav">
	${pageList }


<!--
   <ul class="pagination" >
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
  </ul>
   -->
</nav>
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>