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
<title>UserQuestionForm.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserQuestionForm.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script>

	$(function()
	{
		$(".submitBtn").click(function()
		{
			// alert("확인");
		
			if ($("#qcategory").val()==0)
			{
				alert("카테고리를 선택해주세요.");
				$("#qcategory").focus();
				
				return;
			}
			
			if ($("#title").val()=="")
			{
				alert("제목을 입력해주세요.");
				$("#title").focus();

				return;
			} 
			
			if ($("#content").val()=="")
			{
				alert("내용을 입력해주세요.");
				$("#content").focus();

				return;
			}
			
			$("#questionForm").submit();
		
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
   
  
      <div class="main_listWrapper">
        <div class="main_list">
       <form action="userquestioninsert.action" id="questionForm" method="post">
         <h2>질문 하기</h2>
         <hr>
		<div class='selectBox'>
			<select id="qcategory" name="qcategory">
					<option value="0" selected="selected">--질문 카테고리--</option>
					<option value="1">계정</option>
					<option value="2">여행기록</option>
					<option value="3">신고관련</option>
					<option value="4">이용제한</option>
					<option value="5">기타</option>
			</select>
		</div>
	
	<br>
	
	<div class="titleForm">
		<span style="font-size: 25px;">제목</span>
		<input type="text" class="form-control" placeholder="제목을 입력해주세요."
		id="title" name="title" style="width: 100%; height:40px; font-size: 15px;">
	</div>
	
	<br>
	
	<div>
		<p style="font-size: 25px;">내용</p>
	</div>
	
	<div class="contentForm">
		<!-- <span style="font-size: 25px; border: 1px solid red;">내용</span> -->
		<div class="mb-3">
		  <textarea class="form-control formTextarea" rows="25" id="content" name="content"
		  placeholder="내용을 입력해주세요." style="font-size: 15px;"></textarea>
		</div><!-- 내용입력 폼 -->
	</div>
	</form>	
	<br>
	<div class="buttonLine" style="text-align: right;">
		<button type="button" class="btn submitBtn" style="margin-right: 10px; background-color: #1DB1F8;">저장</button>
		<button type="button" class="btn" style="background-color: #BDBDBD" onclick="location.href='userfaqlist.action'">취소</button>
	</div>


	

         </div><!-- main_list -->
      </div><!-- main_listWrapper -->
</div><!-- wrapper -->
<br><br><br>
<!-- footer -->
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body> 
</html>