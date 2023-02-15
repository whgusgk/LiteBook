<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	//String cId = request.getParameter("checkId");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserIdConfirmForm.jsp</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/UserIdConfirmFindForm.css">

 <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
 
   
</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h3 class="mb-3" style="text-align:center;">아이디 찾기</h3><br>
        <form class="validation-form" id="frm" action="">
       
              <!-- 인증번호 받기 버튼 클릭 시 밑에 화면 출력 -->
               <div class="writeNum"> 
            <div class="col-md-10 mb-3 ">
             <%--  <c:forEach var="check" items="${checkId }" >
				</c:forEach> --%>
				고객님의 등록된 아이디는<br>
				[ ${checkId } ]<br> 
				입니다.
					
               </div> 
               
            <div class="col-md-7 mb-3" style="width: 100%; text-align: center">
                    <div class="col text-center" >
                   <button class="btn btn-secondary btn-lg btn-block" type="button" style="width:60%;"  onClick="location.href='userloginform.action'" id="login">로그인</button>
                   </div> 
                    <div class="col text-center">
 		   <button class="btn btn-primary btn-lg btn-block" type="button"style="background-color: #55acee; width: 60%;"  onClick="location.href='userpwfindform.action'" id="findpw">비밀번호 찾기</button>
                   </div>
                   </div>
             
               </div>
        </form>
      </div>
    </div>
    </div>  
</body>
</html>