<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserWelcome.jsp</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="css/UserWelcome.css">
	<script type="text/javascript" src="http:code.jquery.com/jquery.min.js"></script>
</head>
<body>

<div class="input-form col-md-12 mx-auto">
  <h2 class="mb-3" style="text-align:center;">가입완료</h2>
   <hr width = "90%" color = "gray">
  <form class="validation-form" novalidate>
    <div class="row">
      <div class="col-md-12 mb-3">
        <h3 style="text-align:center;">라이트 북 회원이 되신 것을 환영합니다.</h3>
      	</div>
      <div class="col-md-12 mb-3 " style="text-align:center;">
     <p><h4 >${user_name }님, </h4>회원가입을 해주셔서 감사드립니다.<br>
      회원가입 절차가 모두 완료되었습니다.<br>
      나만의 소중한 여행을 기록해 보세요.</p>
      
  	<div class="col text-center">
       <button class="btn btn-lg btn-block mainpage" type="submit" style="width:90%;" onclick="">메인화면</button>
       <button class="btn btn-lg btn-block writepage" type="submit" style="width:90%;">여행기록</button>
       <button class="btn btn-lg btn-block likebook" type="submit" style="width:90%;">인기여행책 보기</button>
    </div> 
      </div>
      
       <hr style="padding-left: 0%" width = "95%" color = "gray">
     <div class="col-md-12 mb-3 ">
     <p> 추가 정보를 입력하고 내 프로필을 더 풍성하게 꾸며 보세요!</p>
       	<div class="col text-center">
       <button class="btn btn-lg btn-block mypage" type="submit" style="width:90%;">마이페이지로</button>
       </div>
    </div>
</div>
  
  </form>
</div>
</body>
</html>