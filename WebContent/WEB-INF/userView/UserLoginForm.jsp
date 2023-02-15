<%@ page contentType="text/html; charset=UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLoginForm.jsp</title>
<link rel="stylesheet" type ="text/css" href="css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/UserLoginForm.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		// [Sing in] 버튼 클릭 시
		$(".SignBtn").click(function()
		{
			//alert("버튼클릭");
			
			// 아이디와 비밀번호 공란 시 경고창
			if ( $("#form1Example13").val()=="" || $("#form1Example23").val()=="" )
			{
				alert("아이디와 비밀번호를 입력해주세요.");
				return;
			}
			
			// 입력한 아이디와 비밀번호 일치여부 확인
			$.ajax({
				type:"POST"
				, url:"ssncheck.action"
				, data:{user_id : $("#form1Example13").val()
						, user_pw : $("#form1Example23").val()}
				, success: function(data)
				{
					if($.trim(data) == 0 || $.trim(data) == 1)	
					{
						alert("정보가 일치하지 않습니다.");
						$("#form1Example13").val("");
						$("#form1Example23").val("");
						$("#form1Example13").focus();
						return;
					}
					if($.trim(data) == 2)
					{
						$("#loginForm").submit();
					}
				}
			});
			
		});
		
		
	});

</script>

</head>
<body>
<section class="vh-100">
<div class="main_img">
          <img id="img-fluid" src="images/mainBanner.png"alt="mainImages" style="height:465px;">
</div>
      <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1 login">
        <form action="userlogin.action" id="loginForm" method="post"><!-- 로그인 성공 시 -->
          <!-- Id input -->
    <div class="card-body p-5 shadow-5 text-center">
            <h2 class="fw-bold mb-5">Login</h2>
       </div>
          <div class="form-outline mb-4">
            <label class="form-label" for="form1Example13">ID</label>
            <input type="text" id="form1Example13" class="form-control form-control-lg" name="user_id"/>
          </div>

          <!-- Password input -->
          <div class="form-outline mb-4">
            <label class="form-label" for="form1Example23">Password</label>
            <input type="password" id="form1Example23" class="form-control form-control-lg" name="user_pw" />
          </div>

          <!-- Submit button -->
          <br>
          <button type="button" class="btn btn-primary btn-lg btn-block SignBtn">Sign in</button>

         <br>
          <div class="divider d-flex align-items-center my-4">
            <p class="text-center fw-bold mx-3 mb-0 text-muted">OR</p>
          </div>
         <br>
         <a class="btn btn-primary btn-lg btn-block" style="background-color: #606366" href="resiinsert.action"
            role="button">
            <i class="signUp me-2"></i>회원가입</a>
            
          <a class="btn btn-primary btn-lg btn-block" style="background-color: #3b5998" href="useridfindform.action"
            role="button">
            <i class="findId me-2"></i>아이디 찾기
          </a>
          <a class="btn btn-primary btn-lg btn-block" style="background-color: #55acee" href="userpwfindform.action"
            role="button">
            <i class="findPw me-2"></i>비밀번호 찾기</a>

        </form><!-- #loginForm end -->
      </div>
</section>

</body>
</html>