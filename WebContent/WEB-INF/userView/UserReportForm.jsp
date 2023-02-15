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
<title>UserReportForm.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserReportForm.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

<script type="text/javascript">
	$(function()
	{
		// 신고하기 버튼 클릭 시
		$(".reportBtn").click(function()
		{
			//alert("신고하기 버튼");
			
			// 제목 공란일 경우
			if ( $("#title").val() == "" )
			{
				alert("제목을 입력해주세요!");
				$("#title").focus();
				return;
			}
			
			$("#submitBtn").submit();
			
		});
		
	});

</script>

</head>	
<body class="Site">
<!-- Site-content :body와 묶여서 flex로 footer를 하단 고정시키기 위한 첫번째 방법 -->
<!-- wrap에 min-height을 줘서 footer를 하단 고정시키기 위한 두번째 방법-->
	<div class="Site-content" id="wrap">
		<div class="import">
				<c:import url="UserMenu.jsp"></c:import>
		</div><!-- import -->
	
		<div class="main_title">
		</div><!-- main_title -->
				
					
		<br><br>	
		<div class="main_listWrapper">
		
			<div class="main_list">
			<form method="get" id="submitBtn" action="userreport.action">
				<div class="report"  align="center">
			<h2>신고하기 </h2>
				<input hidden="" name="type" value="${type}">
				<input hidden="" name="num" value="${num }">
				<div class="report_title">
					<span>작성자</span><input type="text" readonly="readonly" value="${user.user_name }" style="padding-left: 7px;">
					<br>
					<span>제목</span><input type="text" name="title" id="title" value="" style="padding-left: 7px;"><br>
					<!-- <span>내용</span><input type="text" name=""> -->
				</div>
					<br>
					신고사유
					<br>
						<div class="info_reason">
										<input type="radio" name="infoReason" value="1" id="spam" checked="checked">
										<label for="spam">스팸홍보/도배글</label>
										<input type="radio" name="infoReason" id="illegal" value="2" >
										<label for="illegal">불법촬영물 포함</label>
										<input type="radio" name="infoReason" id="porno" value="3" >
										<label for="porno">음란물</label>
										<input type="radio" name="infoReason" id="illegalInfo" value="4" >
										<label for="illegalInfo">불법정보 포함</label>
										<input type="radio" name="infoReason" id="others" value="5" >
										<label for="others">기타</label>
					</div>
					<textarea rows="3" cols="50" name="content" placeholder="내용을 입력하세요."></textarea>
					<br><br>
	
					<!-- <button type="button" class="btn btn-primary reportBtn">신고하기</button> -->
					<input type="button" class="btn btn-primary reportBtn" value="신고하기">
					<button type="button" class="btn btn-default" onclick="location.href='' ">취소</button>
					
				</div>
			</form>
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