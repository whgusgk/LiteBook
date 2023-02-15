<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminMyInfoUpdateForm.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
    
    <!-- Custom styles for this template -->
    <link href="css/AdminMyInfoUpdateForm.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/AdminStyle.css" rel="stylesheet">

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>
	$(function()
	{
		if(${list.gender_num} == "1")
		{
			$(":radio[name='gender_num'][value='1']").attr("checked", "checked");
		}
		else if(${list.gender_num} == "2")
		{
			$(":radio[name='gender_num'][value='2']").attr("checked", "checked");
		}
		else
		{
			$(":radio[name='gender_num'][value='3']").attr("checked", "checked");
		}
		
		$(".updateBtn").click(function()
		{
			// 공백 없는 경우에만 수정 가능(생년월일은 필수 입력 아님)
			if($("#email").val()=="")
			{
				alert("이메일을 입력해주세요");
				$("#email").val()=="";
				$("#email").focus();
				return
			}
			else if($("#name").val()=="")
			{
				alert("이름을 입력해주세요");
				$("#name").val()=="";
				$("#name").focus();
				return;
			}
			else if($("#tel").val()=="")
			{
				alert("전화번호를 입력해주세요");
				$("#tel").val()=="";
				$("#tel").focus();
				return;
			}
			
			// 이메일 정규식
			var emailTest =/^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/;
			
			// 이메일 유효성 검사 
			if(!emailTest.test($("#email").val()))
			{
				alert("잘못된 형식의 이메일입니다!");
				$("#email").val()=="";
				$("#email").focus();
				return;
			}
			
			// 전화번호 정규식
			var telTest = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
			
			// 전화번호 유효성 검사
			if(!telTest.test($("#tel").val()))
			{
				alert("잘못된 형식의 전화번호입니다!");
				$("#tel").val()=="";
				$("#tel").focus();
				return;
			}
			
			// 생년월일 정규식
			//-- yyyy-mm-dd
			var birtTest = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
			
			// 생년월일 유효성 검사
			if(!birtTest.test($("#birth").val()) && $("#birth").val()!="")	// 생년월일 필수 입력사항 X
			{
				alert("잘못된 형식의 생년월일입니다!");
				$("#birth").val()=="";
				$("#birth").focus();
				return;
			}
			
			// 수정 액션
			$("#updateForm").submit();
			
		});
		
		$(".cancelBtn").click(function()
		{
			//alert("취소 버튼");
			$(location).attr("href", "adminmyinfo.action");
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
        <h1 class="h2">개인정보 수정</h1>
      </div>
        

<div style="width: 1280px; margin: auto;">
	<div align="center">
	    <img src="images/150854603.png" alt="img" class="img-circle">
	</div>
	<form action="adminmyinfoupdate.action" method="post" role="form" id="updateForm">
	<div align="center">
		<table  class="table table-bordered">
		 <tbody>
		   <tr>
		      <th>아이디</th>
		      <td>${list.admin_id }</td>
		   </tr>
		   <tr>
		      <th>생년월일</th>
		      <td><input type="text" class="info-update" id="birth" 
				name="admin_birth" value="${list.admin_birth }" placeholder="ex) yyyy-mm-dd"></td>      
		   </tr>
		   <tr>
		      <th>이메일</th>
		      <td><input type="email" class="info-update" id="email" 
				name="admin_email" value="${list.admin_email }" placeholder="1234@test.com"></td>     
		   </tr>
		   <tr>
		      <th>이름</th>
		      <td><input type="text" class="info-update" id="name" 
				name="admin_name" value="${list.admin_name }"></td>
		   </tr>
		   <tr>
		      <th>성별</th>
		      <td>
				<input type="radio" name="gender_num" value="1" id="man">
				<label for="man">남성</label>
				
				<input type="radio" name="gender_num" value="2" id="woman">
				<label for="woman">여성</label>
				
				<input type="radio" name="gender_num" value="3" id="none">
				<label for="none">선택안함</label>
		      </td>     
		   </tr>
		   <tr>
		      <th>전화번호</th>
		      <td><input type="text" class="info-update" id="tel" 
				name="admin_tel" value="${list.admin_tel }" placeholder="ex) 010-1234-1234"></td>     
		   </tr>
		  
		 </tbody> 
		</table>
		
		<div>
		<button type="button" class="btn btn-primary control btns updateBtn">수정</button>
		<button type="button" class="btn btn-default control btns cancelBtn">취소</button>
		</div>
	
	</div> 
	</form>
</div>
    </main>
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>