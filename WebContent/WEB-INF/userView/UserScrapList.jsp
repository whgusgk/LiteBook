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
<title>UserScrapList.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserScrapList.css">
<style type="text/css">
	.main_list h3, h5{
		margin:auto;
	}	 

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script>
$(function()
{
	$("#deleteBtn").click(function()	
	{
		if(($(".scrapCard:checked").length)==0)
		{
			alert("카드를 선택해주세요.")
		}
		else
			$("#deleteForm").submit();
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
		</div><!-- main_title -->
					
	
		<br><br>	
		<div class="main_listWrapper">
			<div class="main_list">
			<h3>여행 기록 </h3><h5>당신의 특별한 여행을 특별하게 기록하세요!</h5>
			<br>
			<form action="userscrapdelete.action" method="post" id="deleteForm">
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>장소</th>
						<th>예산</th>
						<th>주소</th>
						<th>작성자</th>
					</tr>
				</thead>
				<tbody>
					<!-- 
					<tr>
						<td>
							<input type="checkbox" class="scrapCard" value="1">
						</td>
						<td>1</td>
						<td>소림커피</td>
						<td>13:30</td>
						<td>서울특별시 마포구 서교동 447-9 1층</td>
						<td>홍길동</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" class="scrapCard" value="1">
						</td>
						<td>2</td>
						<td>쌍용강북교육센터</td>
						<td>09:00</td>
						<td>서울특별시 마포구 서교동 447-5 풍성빌딩 2층</td>
						<td>김첨지</td>
					</tr> 
					-->
					<c:forEach  var="sl" items="${scrapList}">
							<tr>
								<td>
									<input type="checkbox" name="scrap_num" class="scrapCard" value="${sl.scrap_num}">
								</td>
								<td>${sl.list_num }</td>
								<td><a href="usercard.action?card_num=${sl.card_num}">${sl.card_location}</a></td>
								<td>${sl.card_budget }</td>
								<td>${sl.card_address }</td>
								<td>${sl.user_name }</td>							
							</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
		  </div><!-- main_list -->
		</div><!-- main_listWrapper -->
</div><!-- wrapper -->
		
		<div class="button_Footer">
			<button type="button" class="btn btn-default deleteBtn" id="deleteBtn">삭제하기</button>
			<button type="button" class="btn btn-primary noteBtn" id="noteBtn" onclick="location.href='usernotelist.action'">여행노트 리스트</button>
			
		</div>
		

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
  ${pageList}
</nav>
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>