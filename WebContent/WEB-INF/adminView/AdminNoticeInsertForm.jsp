<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminNoticeInsertForm.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/AdminNoticeInsertForm.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>
	
	$(function()
	{
		$(".submitBtn").click(function()
		{
			// alert("확인");
			
			if ($("#title").val()=="")
			{
				alert("제목을 입력해주세요.");
				$("#title").focus();

				return;
			} 
			
			if ($("#content").val()=="")
			{
				alert("내용을 입력해주세요.");
				$("#content").focus();

				return;
			}
			
			$("#noticeForm").submit();
			
		});
		
		
		$(".cancelBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "adminnoticelist.action");
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
        <h2>공지사항 작성</h2>	
      </div>
        
       

        <!-- 채워야 할 영역 -->
      
	  <div class="area">
		
	<form action="adminnoticeinsert.action" method="post" id="noticeForm">
		<div class="titleForm">
			 <div class="question">
			 <p>
			 <span style="font-size: 16px;">제목</span>  
			 </p>
			 </div>
			 <div class="question_input">
				<input type="text" class="form-control" id="title" placeholder="제목을 입력해주세요."
				style="width: 1200px; height:40px; font-size: 15px;" name="notice_title">
			 </div>
		</div>
	
	<br>
	
	<div class="contentForm">
		<div class="answer">
		<p>
			<span style="font-size: 16px;">내용</span>
		</p>
		</div>
		<div class="answer_textArea">
		  <textarea class="form-control formTextarea"  id="content" rows="25" 
		  placeholder="내용을 입력해주세요." style="font-size: 15px;" name="notice_content"></textarea>
		</div><!-- 내용입력 폼 -->
	</div>
	
		
	<br>
	
	<!-- 하단 버튼(submit) -->
	<div class="buttonLine" style="text-align: right;">
		<button type="button" class="btn submitBtn" style="margin-right: 10px; background-color: #1DB1F8;">확인</button>
		<button type="button" class="btn cancelBtn" style="background-color: #BDBDBD">취소</button>
	</div>
	</form>
	
	<br /><br />
	</div>
	
    
      	<!-- 채워야 할 영역 -->
    </main>
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>
