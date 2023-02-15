<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserIdFindForm.jsp</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/UserIdFindForm.css">

 <script type="text/javascript">
 
	window.onload = function() {
		document.getElementById('checkNum').onclick = function() {
			
			if ( document.frm.user_name.value.trim() == '' ) {
				alert( '이름을 입력해주세요' );
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
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>  
   
</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-8 mx-auto">
        <h3 class="mb-3" style="text-align:center;">아이디 찾기</h3><br>
        <form class="validation-form" name ="frm" action="useridconfirmform.action" method="post" >
          	
          	<div class="col-md-7 mb-3" style="text-align:center;">
                    <label for="user_name">이름</label>
                    <input type="text" class="form-control" id="user_name" name="user_name" >
            </div>
            <div class="col-md-7 mb-3" style="text-align:center;">
                    <label for="user_email">이메일</label>
                    <input type="text" class="form-control" id="user_email" name="user_email"><br>
                    <div class="col text-center">
                   <button class="btn btn-secondary btn-lg btn-block" type="submit" style="width:90%;" id ="checkNum">아이디 찾기</button>
                   </div> 
            </div>
          
              <!-- 인증번호 받기 버튼 클릭 시 밑에 화면 출력 -->
        <%--   
            <div class="col-md-7 mb-3 writeNum" style="text-align:center;">
              <c:forEach var="check" items="${checkId }" >
					고객님의 등록된 아이디는 아래와 같습니다.<br> 
					${checkId }
				</c:forEach> 
               </div> 
        --%>
        </form>
      </div>
    </div>
    </div>  
</body>
</html>