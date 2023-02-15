<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String qcategoryNum = request.getParameter("qcategoryNum");
	
	pageContext.setAttribute("replaceWord", "\n");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminFAQList.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> 
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
  
<style type="text/css">
	.dropQ ul{
		list-style:none;
		padding-left:0px;
	}
	.dropQuestion{
		list-style:none;
		padding-left:0px;
	}
	.dropQ .dropA { 
		display: none;
		position: relative;
		background: #f1f1f1; 
		border-radius:10px;
		height:150px;
	}
	.dropQ{
		background-image: linear-gradient(to top, #d5d4d0 0%, #d5d4d0 1%, #eeeeec 31%, #efeeec 75%, #e9e9e7 100%);
		border-top-radius:5px;
		padding-top:10px;
		width:100%;
	}
	.dropdown > li > a { display: inline-block; padding: 14px 0px; color: black; width: 150px ; font-size: 15px;  }
	.dropdown > li > a:hover { background: #ccc; }
  
</style>
  
    <!-- Custom styles for this template -->
    <link href="css/AdminFAQList.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>

	$(function()
	{
		<%-- alert(<%=qcategoryNum%>); --%>
		
		var qcategoryNum = <%=qcategoryNum%>;
		
		if (qcategoryNum==null)
			qcategoryNum = 0;
		
		$("#qcategory").val(qcategoryNum);
			
		
		$(".addBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "adminfaqinsertform.action");
		});
		
		$("#qcategory").change(function()
		{
			// alert($("#qcategory").val());
			
			if ($("#qcategory").val()==0)
				$(location).attr("href", "adminfaqlist.action");
			else
				$(location).attr("href", "adminfaqlist.action?qcategoryNum=" + $("#qcategory").val());
			
		});
		
		$("div > ul > li").mouseenter(function()
		{
			$(this).children(".dropA").stop().slideDown(400);
		});
		
		$("div > ul > li").mouseleave(function()
		{
		 	$(this).children(".dropA").stop().slideUp(100);
		});
		
	});

</script>

  </head>
  <body>
    
<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="adminmain.action">라이트북 관리자</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="navbar-nav">
    <div class="nav-item text-nowrap"id="nav">
      <a class="nav-link px-3" href="adminmyinfo.action">개인 정보</a>
      <a class="nav-link px-3" href="adminlogout.action">로그 아웃</a>
    </div>
  </div>
</header><!-- header end-->

<div class="container-fluid" id="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
      <div class="position-sticky pt-3 sidebar-sticky">
          <ul class="nav flex-column big_menu" >
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="adminmain.action">
              <span data-feather="home" class="align-text-bottom"></span>
              대시보드
            </a>
           	<li class="nav-item">
	            <a class="nav-link" href="">
	              <span data-feather="message-square" class="align-text-bottom"></span>
	              고객지원
	            </a>
	            <!-- 여기에 드롭다운 추가 -->
		            <ul class="small_menu">
		                            <li><a href="adminnoticelist.action">공지사항 관리</a></li>
		                            <li><a href="adminfaqlist.action">자주 묻는 질문 관리</a></li>
		                            <li><a href="adminquestionlist.action">질문 관리</a></li>
		            </ul>
        	  </li>
          </ul>
          <ul class="nav flex-column big_menu">
          <li class="nav-item">
            <a class="nav-link" href="adminmemberlist.action">
              <span data-feather="users" class="align-text-bottom"></span>
              회원관리
            </a>
          </li>
          </ul>
          <ul class="nav flex-column big_menu">
          <li class="nav-item">
            <a class="nav-link" href="adminrecordcardlist.action">
              <span data-feather="list" class="align-text-bottom"></span>
              기록관리
            </a>
          </li>
          </ul>
          <ul class="nav flex-column big_menu" >
          <li class="nav-item">
            <a class="nav-link" href="adminreportlist.action">
              <span data-feather="alert-triangle" class="align-text-bottom"></span>
             신고처리
            </a>
           
          </li>
        </ul>
      </div>
    </nav><!-- nav end -->

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2>자주 묻는 질문</h2>
      </div> <!-- d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom -->
        
       

      <!-- 채워야 할 영역 -->
      <div class='selectBox'>
		<select id="qcategory" name="qcategory">
			<option value="0" selected="selected">전체</option>
			<option value="1">계정</option>
			<option value="2">여행기록</option>
			<option value="3">신고관련</option>
			<option value="4">이용제한</option>
			<option value="5">기타</option>
		</select>
	</div> <!-- selectBox -->
	
	<div class="questionButton">	
		<button type="button" class="btn addBtn">등록</button>
	</div> <!-- questionButton -->
	 
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
						<li style="float:right;">
			        		<button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
					        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
						</li>
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
		</ul> -->
	
	</div> 	 <!-- dropdownDiv -->
	
	<!--  원코드
	  <div class="panel-group" id="accordion">
	  	<c:forEach var="faq" items="${list }">
		    <div class="panel panel-default">
		      <div class="panel-heading">
		        <h4 class="panel-title">
		          Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">${faq.faq_question }</a>
		           Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">아이디가 기억나지 않아요.</a>
		        </h4>
		      </div>
		      <div id="collapse1" class="panel-collapse collapse in">
		        <div class="panel-body">A. <span>${fn:replace(faq.faq_answer, replaceWord, '<br>')}</span>
		         <div class="panel-body">A. <span>아이디 찾기를 이용해보세요.</span> 
			        <div style="float: right;">
				        <button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
				        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
			        </div>
		        </div>
		      </div>
		    </div> 
	    </c:forEach>
		 -->

	    <!--
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	          Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">여행책은 어떻게 만드나요.</a>
	        </h4>
	      </div>
	      <div id="collapse2" class="panel-collapse collapse">
	        <div class="panel-body">A. <span>여행노트를 먼저 작성해보세요.</span>
	         <div style="float: right;">
		        <button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
		        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
	        </div>
	        </div>
	      </div>
	    </div>
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	          Q. <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">계정이 정지되었어요.</a>
	        </h4>
	      </div>
	      <div id="collapse3" class="panel-collapse collapse">
	        <div class="panel-body">A. <span>계정이 정지되는 사유는..</span>
	         <div style="float: right;">
		        <button type="button" class="btn" style="margin-right: 5px; background-color: #1DB1F8; color: white;">수정</button>
		        <button type="button" class="btn" style="background-color: rgb(197, 196, 196); color: white;">삭제</button>
	        </div>
	        </div>
	      </div>
	      -->
	
	<nav aria-label="" class="pageNav">
     <!-- 
     <ul class="pagination" >
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
     </ul>
     -->
     ${pageList }
   </nav>
    
      	<!-- 채워야 할 영역 -->
   </main>
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>
