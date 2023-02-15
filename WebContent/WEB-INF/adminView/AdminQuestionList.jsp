<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String question_done = request.getParameter("question_done");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminQuestionList.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/AdminQuestionList.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/AdminStyle.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>

	$(function()
	{
		var questionDone = "<%=question_done %>";
		
		if (questionDone==null)
			questionDone="";
		
		if (questionDone=="")
			$("#type option:eq(0)").attr("selected", "selected");
		else
			$("#type").val(questionDone);
		
		$("#type").change(function()
		{
			// alert("확인");
			$(location).attr("href", "adminquestionlist.action?question_done=" + $("#type").val());
			
		});
		
	});

</script>

  </head>
  <body>
    
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="adminmain.action">라이트북 관리자</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="navbar-nav">
    <div class="nav-item text-nowrap"id="nav">
      <a class="nav-link px-3" href="adminmyinfo.action">개인 정보</a>
      <a class="nav-link px-3" href="adminlogout.action">로그 아웃</a>
    </div>
  </div>
</header><!-- header end-->

<div class="container-fluid" id="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
      <div class="position-sticky pt-3 sidebar-sticky">
          <ul class="nav flex-column big_menu" >
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="adminmain.action">
              <span data-feather="home" class="align-text-bottom"></span>
              대시보드
            </a>
           	<li class="nav-item">
	            <a class="nav-link" href="">
	              <span data-feather="message-square" class="align-text-bottom"></span>
	              고객지원
	            </a>
	            <!-- 여기에 드롭다운 추가 -->
		            <ul class="small_menu">
		                            <li><a href="adminnoticelist.action">공지사항 관리</a></li>
		                            <li><a href="adminfaqlist.action">자주 묻는 질문 관리</a></li>
		                            <li><a href="adminquestionlist.action">질문 관리</a></li>
		            </ul>
        	  </li>
          </ul>
          <ul class="nav flex-column big_menu">
          <li class="nav-item">
            <a class="nav-link" href="adminmemberlist.action">
              <span data-feather="users" class="align-text-bottom"></span>
              회원관리
            </a>
          </li>
          </ul>
          <ul class="nav flex-column big_menu">
          <li class="nav-item">
            <a class="nav-link" href="adminrecordcardlist.action">
              <span data-feather="list" class="align-text-bottom"></span>
              기록관리
            </a>
          </li>
          </ul>
          <ul class="nav flex-column big_menu" >
          <li class="nav-item">
            <a class="nav-link" href="adminreportlist.action">
              <span data-feather="alert-triangle" class="align-text-bottom"></span>
             신고처리
            </a>
           
          </li>
        </ul>
      </div>
    </nav><!-- nav end -->

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">질문 관리</h1>
      </div>
        
      <div class="main_leftHeader">
			<select class="form-control" id="type">
				<option value="" selected>전체</option>
				<option value="처리완료">처리완료</option>
				<option value="미처리">미처리</option>
			</select>
		</div>
		
		<div class="main_list">
		
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성일</th>
						<th>처리여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="qna" items="${list }">
						<tr>
							<td>${qna.question_num }</td>
							<td>${qna.qcategory_class }</td>
							<td>
								<a href="${questionUrl }&question_num=${qna.question_num}">
									${qna.question_title }
								</a>
							</td>
							<td>${qna.question_date }</td>
							<td>${qna.question_done }</td>
						</tr>
					</c:forEach>
					<!-- 
					<tr>
						<td>1</td>
						<td>여행기록</td>
						<td>여행기록이 블라인드 됐어요...</td>
						<td>2022.10.25</td>
						<td>미처리</td>
					</tr>
					<tr>
						<td>2</td>
						<td>계정</td>
						<td>로그인 문제</td>
						<td>2019.09.15</td>
						<td>처리완료</td>
					</tr>
					 -->
				</tbody>
			</table>
		
		
		</div>

         
  <!--
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	          Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">여행책은 어떻게 만드나요.</a>
	        </h4>
	      </div>
	      <div id="collapse2" class="panel-collapse collapse">
	        <div class="panel-body">A. <span>여행노트를 먼저 작성해보세요.</span>
	         <div style="float: right;">
		        <button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
		        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
	        </div>
	        </div>
	      </div>
	    </div>
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	          Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">계정이 정지되었어요.</a>
	        </h4>
	      </div>
	      <div id="collapse3" class="panel-collapse collapse">
	        <div class="panel-body">A. <span>계정이 정지되는 사유는..</span>
	         <div style="float: right;">
		        <button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
		        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
	        </div>
	        </div>
	      </div>
	      -->
	<nav aria-label="" class="pageNav">
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
     ${pageList }
   </nav>


   </main>
  
  </div>
</div>

    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>