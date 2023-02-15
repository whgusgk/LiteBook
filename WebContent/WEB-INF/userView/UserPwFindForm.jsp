<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserPwFindForm.jsp</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/UserPwFindForm.css">
    
 <script type="text/javascript">
 
	window.onload = function() {
		document.getElementById('checkNum').onclick = function() {
			
			if ( document.frm.user_id.value.trim() == '' ) {
				alert( '아이디를 입력해주세요' );
				return false;
			}
			if ( document.frm.user_email.value.trim() == '' ) {
				alert( '이메일을 입력해주세요' );
				return false;
			}
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
        <h3 class="mb-3" style="text-align:center;">비밀번호 찾기</h3>
        <form class="validation-form" action="findpwconfirm.action" method="post" name ="frm">
        
            <div class="col-md-7 mb-3" style="text-align: center;">
                    <label for="user_id">아이디</label>
                    <input type="text" class="form-control" id="user_id" name="user_id">
            </div>
           <div class="col-md-7 mb-3" style="text-align: center;">
             <label for="user_email" style="text-align: center;">이메일</label>
              		<input type="text" class="form-control" id="user_email" name="user_email"><br>
                    <div class="col text-center email">
                   <button class="btn btn-secondary btn-lg btn-block" type="submit" id="checkNum">비밀번호 찾기</button>
                   </div> 
              </div><br>
             
              
              <!-- 인증번호 받기 버튼 클릭시 밑에 화면 출력 -->		
   <%--            
             <div class="writeNum"> 
            <div class="col-md-10 mb-3 ">
             ${checkPassword}
             새로운 비밀번호로 재설정 해주세요.
            </div>
            <div class="col-md-7 mb-3">
              <label for="password">새로운 비밀번호 입력</label>
              <input type="text" class="form-control" id="password" placeholder="" value="" required>
            </div>
             <div class="col-md-7 mb-3">
              <label for="passwordcheck">비밀번호 재확인</label>
              <input type="text" class="form-control" id="passwordcheck" placeholder="" value="" required>
            </div>
   
          <div class="mb-4">
          <button class="btn btn-primary btn-lg btn-block" type="submit" style="width:70%;">비밀번호 바꾸기</button>
          </div>
          </div>
     --%>      
        </form>
        </div>
      </div>
    </div>
</body>
</html>