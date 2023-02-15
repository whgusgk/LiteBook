<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserSuspension.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserSuspension.css">

<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

</head>	
<body class="Site">
<!-- Site-content :body와 묶여서 flex로 footer를 하단 고정시키기 위한 첫번째 방법 -->
<!-- wrap에 min-height을 줘서 footer를 하단 고정시키기 위한 두번째 방법-->
	<div class="Site-content" id="wrap">
		<div class="import">
				<c:import url="UserMenu.jsp"></c:import>
		</div><!-- import -->
	
					
		<br><br>	
		<div class="main_listWrapper">
			<div class="main_list">
				<div class="suspension"  align="center">
					<h2>활동 정지 안내</h2>
					닉네임님, 안녕하세요.
					<br>
					라이트북 관리자 입니다.
					<br><br>
					
					닉네임님은 라이트북 관리자의 결정에 따라 사이트 활동이 정지되었습니다.
					<br><br>
					
					활동정지 처리일 : <span id="stop_date">${stopDate }</span> 
					<!-- <input type="text" readonly="readonly"> -->
					<br><br>
					활동 정지 사유 : 경고 3회 누적
					<!-- <input type="text" readonly="readonly" value="경고 3회 누적"> -->
					
					<br><br>
					보다 구체적인 활동정지 사유가 궁금하시거나 상기 내용과 무관한 상황이라면
					<br>
					아래 질문하기 버튼을 통해 관리자에게 문의해주시기 바랍니다.
					<br><br>
					<button type="button" class="btn btn-primary" onclick="location.href='userquestionform.action' ">질문하기</button>
					<button type="button" class="btn btn-primary" onclick="location.href='userlogout.action'">로그아웃</button>
					<button type="button" class="btn btn-default" onclick="location.href='userwithdrawal.action' ">회원탈퇴</button>
					
				</div>
	
			</div><!-- main_list -->
		</div><!-- main_listWrapper -->
</div><!-- wrapper -->

<!-- footer -->
<!-- pageNav -->
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>