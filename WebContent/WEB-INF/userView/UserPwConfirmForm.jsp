<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//String cPwd = request.getParameter("checkPassword");
	
	
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserPwConfirmForm.jsp</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/UserPwConfirmForm.css">

<script type="text/javascript">

function updatePassword(){
	if(document.frm.user_pw.value==""){
		alert("비밀번호를 입력해주세요.");
		document.frm.user_pw.focus();
	} else if(document.frm.user_pw.value != document.frm.confirmpwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.frm.confirmpwd.focus();
	} else {
		document.frm.submit();
	}
}



</script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
</head>
<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h3 class="mb-3" style="text-align:center;">비밀번호 재설정</h3>
        <form class="validation-form" name="frm" action="pwupdate.action">
   
              <!-- 비밀번호 재설정 화면 출력 -->		
           <%--    
             <div class="writeNum"> 
            <div class="col-md-10 mb-3 ">
            고객님의 등록된 비밀번호는 <br>
             ${checkPassword }<br>
            입니다.
            </div>
            --%> 
 <!--                
            <div class="col-md-7 mb-3" style="width: 100%; text-align: center">
                    <div class="col text-center" >
                   <button class="btn btn-secondary btn-lg btn-block" type="button" style="width:60%;"  onClick="location.href='UserLoginForm.jsp'" id="login">로그인</button>
                   </div> 
                    <div class="col text-center">
 		   <button class="btn btn-primary btn-lg btn-block" type="button"style="background-color: #55acee; width: 60%;"  onClick="location.href='useridfindform.action'" id="findid">아이디 찾기</button>
                   </div>
                   </div>
                   -->
            <div class="col-md-7 mb-3">
              <label for="user_pw">새로운 비밀번호 입력</label>
              <input type="password" class="form-control" id="user_pw" name="user_pw">
              <input hidden="" name="sign_num" value="${sign_num}"> 
            </div>
             <div class="col-md-7 mb-3">
              <label for="confirmpwd">비밀번호 재확인</label>
              <input type="password" class="form-control" id="confirmpwd" name="confirmpwd">
            </div>
   
          <div class="mb-8">
          <button class="btn btn-primary btn-lg btn-block" type="submit" style="width:60%;" onclick="updatePassword()">비밀번호 바꾸기</button>
          </div>
        
        </form>
        </div>
      </div>
    </div>
</body>
</html>