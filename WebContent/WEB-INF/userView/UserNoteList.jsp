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
<title>UserNoteList.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserNoteList.css">
<style type="text/css">


</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">
	
	$(function()
	{
		$("#bookBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "userbooklist.action");
		});
		
		$("#addBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "usernoteinsertform.action");
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
				<button type="button" class="btn btn-primary noteBtn" id="noteBtn">여행노트</button>
				<button type="button" class="btn btn-default bookBtn" id="bookBtn">여행책</button>
			</div><!-- main_leftHeader -->
						
			<div class="main_rightHeader">
				<button type="button" class="btn btn-primary addBtn" id="addBtn">글쓰기</button>
			</div><!-- main_rightHeader -->
		</div><!-- main_header -->
	
		<br><br>	
		<div class="main_listWrapper">
			<div class="main_list">
				<table class="table table-hover">
					<thead>
						<tr>
							<th></th>
							<th>제목</th>
							<th>여행날짜</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="note" items="${noteList }">
							<tr>
								<td>${note.note_num }</td>
								<td>
									<a href="${noteUrl }&note_num=${note.note_num}">
										${note.note_title }
									</a>
								</td>
								<td>${note.note_startdate } ~ ${note.note_lastdate }</td>
								<td>${note.note_date }</td>
							</tr>
						</c:forEach>
						<!-- 
						<tr>
							<td>1</td>
							<td>3박 4일 제주도 여행</td>
							<td>2022.02.01 ~ 2022.02.04</td>
							<td>2022.12.22</td>
						</tr>
						<tr>
							<td>2</td>
							<td>2023년 울릉도 방문</td>
							<td>2022.01.20 ~ 2022.01.23</td>
							<td>2022.12.23</td>
						</tr>
						 -->
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