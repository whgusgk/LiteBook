<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminLogin.jsp</title>

<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<style>

  	#err
	{
		margin-left: 10px;
		font-size: 15px;
	}
	
</style>
    
    <!-- Custom styles for this template -->
    <link href="css/AdminLogin.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
    

<script type="text/javascript">

	$(function()
	{
		$("#submitBtn").click(function()
		{
			$("#err").css("display", "none");		
			
			// 로그인 버튼 눌렀을 때
			if( $("#floatingInput").val() == "" || $("#floatingPassword").val()== "" )
			{
				$("#err").html("아이디와 비밀번호를 입력해주세요.").css("display", "inline");			
				return;
			}
			
			// 입력한 아이디와 비밀번호 일치여부 확인
			$.post("ssncheck.action"
			, {admin_id : $("#floatingInput").val(), admin_pw : $("#floatingPassword").val()}
			,function(data)
			{
				//alert($.trim(data));
				//--> 로그인 성공(admin_id 출력), 없는 아이디(1), 비밀번호 오류(2)
				
				if($.trim(data) == 1 || $.trim(data) == "")
				{
					//alert("로그인 실패");
					$("#err").html("정보가 일치하지 않습니다.").css("display", "inline");	
					$("#floatingInput").val("");
					$("#floatingPassword").val("");
					$("#floatingInput").focus();
					return;
				}
				else
				{
					//alert($.trim(data));
					$("#loginForm").submit();
				}
			});
			
			
		});
	});

</script> 
    
  </head>
  <body class="text-center">
    
<main class="form-signin w-100 m-auto">
  <form action="adminlogin.action" method="post" id="loginForm">
    <img class="mb-4" src="images/tempLogo.png" alt="" width="300" height="100">
    <h1 class="h3 mb-3 fw-normal">로그인</h1>

    <div class="form-floating">
      <input class="form-control" id="floatingInput" placeholder="Id" name="admin_id">
      <label for="floatingInput">아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="admin_pw">
      <label for="floatingPassword">비밀번호</label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" type="button" id="submitBtn">로그인</button>
    <br><br>
    <span id="err" style="color: red; display: none;"></span>
    <p class="mt-5 mb-3 text-muted">&copy; 2022–2023</p>
  </form>
</main>


    
  </body>
</html>
