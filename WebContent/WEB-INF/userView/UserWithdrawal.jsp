<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	String sign_num = (String)session.getAttribute("userSession");
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserWithdrawal.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserWithdrawal.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">

	$(function()
	{
		// 탈퇴하기 버튼 클릭 시
		$(".withdrawalBtn").click(function()
		{
			//alert("탈퇴하기 버튼!");
			//onclick="location.href='userwithdrawaldelete.action'
			
			// 비밀번호 확인 
			//-- 공란 불가
			if($("#pw").val()=="")
			{
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return;
			}
			
			// 세션 값 가져오는 것 확인
			<%-- alert(<%=sign_num %>);  --%>
			//alert($("#pw").val());
			
			$.ajax({
				type:"POST"
				, url:"pwcheck.action"
				, data:{sign_num: <%=sign_num %>, user_pw:$("#pw").val()}
			, success: function(data)
			{
				//alert($.trim(data));
				if($.trim(data) == "false")
				{
					alert("비밀번호가 일치하지 않습니다.");
					$("#pw").val("");
					$("#pw").focus();
					return;
				}
				if($.trim(data) == "true")
				{
					//alert("정말로 탈퇴하시겠습니까?");
					if(confirm("정말로 탈퇴하시겠습니까?"))
						$(location).attr("href", "userwithdrawaldelete.action?sign_num=" + <%=sign_num %>);
				} 
			}
			 
			});
			
			
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
					
		<br><br>	
		<div class="main_listWrapper">
			<div class="main_list">
				<div class="suspension"  align="center">
					<h1>회원 탈퇴</h1>
					<h2>탈퇴 시 유의사항<br></h2>
					<br>
	
					1. 작성하신 기록들은 탈퇴전에 직접 여행기록 메뉴에서 삭제해주시기 바랍니다. <br>
					2. 탈퇴하시면 지금까지 작성하신 여행책에 단 댓글은 자동으로 삭제됩니다.<br><br>
					
					비밀번호 <input id="pw" name="pw" type="password" placeholder="비밀번호를 입력해주세요."><br><br>
					
	
					<button type="button" class="btn btn-primary withdrawalBtn" >탈퇴하기</button>
					<button type="button" class="btn btn-default" onclick="location.href='usermyinfo.action' ">취소</button>
					
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