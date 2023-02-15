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
<title>UserMyWarning.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserMyWarning.css">
<style type="text/css">
  .main_title{
  	margin:auto;
  	width:60%;
  	padding-top:20px;
  }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#QnaBtn").click(function()
		{
			$(location).attr("href", "userquestionform.action");
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
			<h2>경고 받은 내역 </h2>
			<button type="button" class="btn btn-primary QnaBtn" id="QnaBtn">질문하기</button>
		</div><!-- main_title -->
					
	
		<br><br>	
			<div class="main_listWrapper">
			<div class="main_list">
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>대상</th>
						<th>경고사유</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${count eq 0 }">
						<tr>
							<td colspan="4" style="text-align: center;">경고 받은 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="warning" items="${warningList }">
							<tr>
								<td></td>
								<td>${warning.title }</td>
								<td>${warning.reason }</td>
								<td>${warning.date }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
					
					<!-- 
					<tr>
						<td></td>
						<td>xxxx</td>
						<td>욕설</td>
						<td>2022.10.25</td>
					</tr>
					<tr>
						<td></td>
						<td>DMZ 방문기</td>
						<td>불법정보 포함</td>
						<td>2019.09.15</td>
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