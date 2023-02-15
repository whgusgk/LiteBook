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
<title>UserSearch.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserSearch.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

<script type="text/javascript">
	
	$(function()
	{
		
		//$('.type option:selected').val(typeStr);
		
		// 좌측 상단 셀렉트 박스 변경 시
		$(".type").change(function()
		{
			//alert($(".type").val());
			$(location).attr("href", "usersearch.action?type=" + $(".type").val());
			
		});
		
	});

</script>

</head>   
<body class="Site">
<!-- Site-content :body와 묶여서 flex로 footer를 하단 고정시키기 위한 첫번째 방법 -->
<!-- wrap에 min-height을 줘서 footer를 하단 고정시키기 위한 두번째 방법-->
   <div class="Site-content" id="wrap">
      <div class="import">
            <c:import url="UserMenu.jsp"></c:import>
      </div><!-- import -->
   
      <div class="main_title">
         <h2>전체검색</h2>
      </div><!-- main_title -->
               
	
               
   
      <br><br>   
      <div class="main_listWrapper">
         <div class="main_list">

		<div class='selectBox'>
					<select name="type" class="type" id="type">
						<c:choose>
							<c:when test="${type eq 'book' }">
								<option value="" >전체</option>
								<option value="book" selected="selected">여행책</option>
								<option value="card">여행카드</option>
								<option value="notice">공지사항</option>
							</c:when>
							<c:when test="${type eq 'card' }">
								<option value="" >전체</option>
								<option value="book" >여행책</option>
								<option value="card" selected="selected">여행카드</option>
								<option value="notice">공지사항</option>
							</c:when>
							<c:when test="${type eq 'notice' }">
								<option value="" >전체</option>
								<option value="book" >여행책</option>
								<option value="card">여행카드</option>
								<option value="notice" selected="selected">공지사항</option>
							</c:when>
							<c:otherwise>
								<option value="" selected="selected">전체</option>
								<option value="book" >여행책</option>
								<option value="card">여행카드</option>
								<option value="notice" >공지사항</option>
							</c:otherwise>
						</c:choose>
						
						
						<!-- <option value="book">여행책</option>
						<option value="card">여행카드</option>
						<option value="notice">공지사항</option> -->
					</select>
					<!-- <select style="float:right;">
						<option>최신순</option>
						<option>오래된순</option>
					</select> -->
			</div>
			
			<br />
		
			<h3>여행책</h3>	
			<table class="table">
				<thead>
					<tr class="active">
						<th>번호</th>
						<th>여행책 제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				
				<tbody>
					<!-- <tr>
						<td>2</td>
						<td>부산여행기</td>
						<td>김태우</td>
						<td>2022.12.24</td>
					</tr>
					<tr>
						<td>1</td>
						<td>여행기록</td>
						<td>김태민</td>
						<td>2022.12.11</td>
					</tr> -->
					<c:forEach var="list" items="${list }">
					<c:choose>
						<c:when test="${list.type eq 'book' }">
							<tr>
								<c:set var="sum" value="${sum+1}"/>
								<%-- <td>${list.num }</td> --%>
								<td>${sum}</td>
								<td><a href="userbook.action?book_num=${list.num }">${list.title }</a></td>
								<td>${list.user_name }</td>
								<td>${list.s_date }</td>
							</tr>
						</c:when>
					</c:choose>
					</c:forEach>
				</tbody> 
			</table>
		
		<br />
		
			<h3>여행카드</h3>	
			<table class="table">
				<thead>
					<tr class="active">
						<th>번호</th>
						<th>여행카드 제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				
				<tbody>
				  	<!-- <tr>
						<td>2</td>
						<td>부산여행1일차</td>
						<td>김태우</td>
						<td>2022.12.24</td>
					</tr>
					<tr>
						<td>1</td>
						<td>여행기록-1</td>
						<td>김태민</td>
						<td>2022.12.11</td>
					</tr> -->
					<c:forEach var="list" items="${list }">
					<c:choose>
						<c:when test="${list.type eq 'card' }">
							<tr>
								<c:set var="sum2" value="${sum2+1}"/>
								<%-- <td>${list.num }</td> --%>
								<td>${sum2}</td>
								<td>${list.title }</td>
								<td>${list.user_name }</td>
								<td>${list.s_date }</td>
								<%-- <a href="usercard.action?card_num=${list.num }"> --%>
							</tr>
						</c:when>
					</c:choose>
					</c:forEach>
				</tbody>
			</table>
		
		<br />
		
			<h3>공지사항</h3>	
			<table class="table">
				<thead>
					<tr class="active">
						<th>번호</th>
						<th>내용</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				
				<tbody>
				 <!-- 	<tr>
						<td>2</td>
						<td>사이트 이용방법</td>
						<td>2022.12.24</td>
					</tr>
					<tr>
						<td>1</td>
						<td>첫번째 게시글</td>
						<td>2022.12.11</td>
					</tr> -->
					<c:forEach var="list" items="${list }" >
					<c:choose>
						<c:when test="${list.type eq 'notice' }">
							<tr>
								<c:set var="sum3" value="${sum3+1}"/>
								<%-- <td>${list.num }</td> --%>
								<td>${sum3}</td>
								<td><a href="usernotice.action?notice_num=${list.num }">${list.title }</a></td>
								<td>${list.user_name }</td>
								<td>${list.s_date }</td>
							</tr>
						</c:when>
					</c:choose>
					</c:forEach>
				</tbody>
			</table>
		
		<br />	

         </div><!-- main_list -->
      </div><!-- main_listWrapper -->
</div><!-- wrapper -->

<!-- footer -->
<!-- pageNav -->
<!-- <nav aria-label="" class="pageNav">
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
</nav> -->
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>