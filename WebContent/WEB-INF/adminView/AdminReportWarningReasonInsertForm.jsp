<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	pageContext.setAttribute("replaceWord", "\n");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminReportWarningReasonInsertForm.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="css/AdminReportWarningReasonInsertForm.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

    <style>
    	.info_reason
		{
			margin-left:13px;
			margin-bottom:10px;
		}
    </style>

    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">
<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>

	$(function()
	{
		$(".cancelBtn").click(function()
		{
			//alert("취소버튼 클릭!");
			$(location).attr("href", "adminreportlist.action");
		});
		
		
		
		$(".updateBtn").click(function()
		{
			var inputRadio = $("input[name='type_num']:checked").val();
			//alert(inputRadio);
		
			if(inputRadio==null)
			{
				alert("신고처리 사유를 선택하세요.");
				return;
			}
			else
			{
				//alert(inputRadio);
				$("#formSubmit").submit();
			}
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

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2>경고 사유</h2>
      </div>
        
       
        <!-- 채워야 할 영역 -->
		<div class="reasonInfo">
			<div class="info_id">
				<span>아이디 </span> <input type="text" name="id" id="id" value="${report.user_id }" readonly="readonly"/>
			</div>
			<div class="info_nickName">
				<span>닉네임 </span> <input type="text" name="nickName" id="nickName" value="${report.user_name }" readonly="readonly"/>
			</div>
			<div class="info_reason" style="margin-left: 0px; margin-top: 2px; margin-bottom: 2px;">
				<span style="width: 60px; margin-left: 0px; margin-right: 9px;">신고사유</span> 
				<input type="text" name="reason" id="reason" value="${report.reason }" readonly="readonly"/>
			</div><!-- 불법촬영물 포함, 음란물, 불법정보 포함, 기타 -->
			<div class="info_title">
				<span>제목 </span> <input type="text" name="title" id="title" value="${report.report_title }" readonly="readonly" />
			</div>
			<div class="info_content">
				<span>내용</span> <textarea name="content" id="content" cols="30" rows="10" readonly="readonly">${fn:replace(report.report_content, replaceWord, '<br>') }</textarea>
			</div>
			<form action="reportwarningreasoninsert.action" method="post" id="formSubmit">
			<div class="admin_reason" style="margin-left: 300px;">
						<input type="radio" name="type_num" value="1" id="warning"> <!-- checked="checked" -->
						<label for="warning">인정(경고)</label>
						<input type="radio" name="type_num" id="consider" value="2" >
						<label for="consider">참작</label>
						<input type="radio" name="type_num" id="warningUser" value="3" >
						<label for="warningUser">허위(신고자 경고)</label>
			</div>
			<input hidden="" name=type value="${report.type}">
			<input hidden="" name=report_num value="${report.report_num}">
			<div class="btns">
					<button type="button" class="btn btn-primary control btns updateBtn">등록</button>
					<button type="reset" class="btn btn-default control btns cancelBtn">취소</button>
			</div>
			</form>    
		</div>

      	<!-- 채워야 할 영역 -->
    </main>
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>
