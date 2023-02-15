<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String qcategoryNum = request.getParameter("qcategoryNum");
	pageContext.setAttribute("replaceWord", "\n");
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserFAQList.jsp</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserFAQList.css">

<style type="text/css">
		/* 필요한 CSS 제작 사용 영역*/
</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("div > ul > li").mouseenter(function(){
			  $(this).children(".dropA").stop().slideDown(400);
			});
			$("div > ul > li").mouseleave(function(){
			  $(this).children(".dropA").stop().slideUp(100);
			});
			
			
		var qcategoryNum = <%=qcategoryNum%>;
		
		if (qcategoryNum==null)
			qcategoryNum = 0;
		
		$("#qcategory").val(qcategoryNum);
			
		// 질문하기 버튼 클릭 시
		$(".addBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "userquestionform.action");
		});
		
		// 질문 카테고리 변경 시
		$("#qcategory").change(function()
		{
			if ($("#qcategory").val()==0)
				$(location).attr("href", "userfaqlist.action");
			else
				$(location).attr("href", "userfaqlist.action?qcategoryNum=" + $("#qcategory").val());
			
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
				<h3>자주 묻는 질문</h3>	
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
		<!-- 세션이 없는 경우 '질문하기' 버튼 보이지 않음 -->
		<div class="questionButton">	
		<c:choose>
			<c:when test="${userSession == null }"></c:when>
			<c:otherwise>
				<button type="button" class="btn addBtn">질문하기</button>
			</c:otherwise>
		</c:choose>
		</div>
		
		<br>
		<br>
		<br>
		

	<div class="dropdownDiv">
	
		<c:forEach var="faq" items="${list }">
		
			<ul class="dropQuestion">
				<li class="dropQ">
					<a  href="#">Q. ${faq.faq_question }</a>
					<ul class="dropA">
						<li>A. ${fn:replace(faq.faq_answer, replaceWord, '<br>') }</li>
					</ul>
				</li>
			</ul>
		</c:forEach>
		
	<!-- 
		<ul class="dropQuestion">
			<li class="dropQ">
				<a  href="#">Q.아이디가 기억나지 않아요.</a>
				<ul class="dropA">
					<li>A. 아이디 찾기를 이용해보세요.</li>
				</ul>
			</li>
		</ul>
	
		<ul class="dropQuestion">
			<li class="dropQ">
				<a href="#">Q.여행책은 어떻게 만드나요?</a>
				<ul class="dropA">
					<li>A. 여행노트를 먼저 작성해보세요.</li>
				</ul>
			</li>
		</ul>
	
		<ul class="dropQuestion">
			<li class="dropQ">
				<a href="#">Q.계정이 정지되었어요. </a>
				<ul class="dropA">
					<li>A. 계정이 정지되는 사유는...</li>
				</ul>
			</li>
		</ul>
	 -->
	</div> <!-- dropdownDiv -->


			</div><!-- main_list -->
		</div><!-- main_listWrapper -->
</div><!-- Site-content -->

<!-- footer -->
<!-- pageNav -->
<nav aria-label="" class="pageNav">
 <!--  <ul class="pagination" >
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">◀</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item active" aria-current="page">
      <a class="page-link" href="#">2</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item">
      <a class="page-link" href="#">▶</a>
    </li>
  </ul>-->
  ${pageList }
</nav> <!-- pageNav -->

<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>