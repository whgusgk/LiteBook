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
    <title>AdminRecordCardList.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<style type="text/css">
		
		div .main_rightFooter{
			width: 250px;
		}
	
	</style>
	
    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/AdminStyle.css" rel="stylesheet">
    <link href="css/AdminRecordCardList.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>

	$(function()
	{
		$("#bookBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "adminrecordbooklist.action");
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
        <h1 class="h2">기록 관리</h1>
      </div>
        
       <div class="main_header">
			<button type="button" class="btn btn-primary" id="cardBtn">여행카드</button>
			<button type="button" class="btn btn-default" id="bookBtn">여행책</button>
		</div>
	
     		
	<div class="main_list">
			
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>장소</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>블라인드 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="card" items="${list }">
						<tr>
							<td>${card.card_num }</td>
							<td>
								<a href="adminrecordcard.action?card_num=${card.card_num }">
									${card.card_location }
								</a>
							</td>
							<td>${card.user_name }</td>
							<td>${card.card_date }</td>
							<td>${card.blind }</td>
						</tr>
					</c:forEach>
					<!-- 
					<tr>
						<td>1</td>
						<td>소림커피</td>
						<td>홍길동</td>
						<td>2022.12.11</td>
						<td>X</td>
					</tr>
					<tr>
						<td>2</td>
						<td>쌍용강북교육센터</td>
						<td>김첨지</td>
						<td>2022.12.10</td>
						<td>X</td>
					</tr>
					 -->
				</tbody>
			</table>
		
		</div>
		
	<form action="adminrecordcardlist.action" method="get" id="searchForm" class="form-inline">
      <div class="main_rightFooter">
               <!--
               <select class="form-control selectArea" aria-label=abled id="type">
                  <option value="0" selected>전체</option>
                  <option value="1">아이디</option>
                  <option value="2">닉네임</option>
               </select>
               -->
               <div class="input-group inputArea">
                  <input type="text" name="keyword" class="form-control">
               <button type="submit" class="btn btn-primary submitBtn" id="submitBtn">
                  <i class="fa-solid fa-magnifying-glass"></i> 
                  <!--
                  <span class="sr-only">Search</span>
                    -->
               </button>
               </div>
         </div><!-- main_rightFooter -->
      </form>
         
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


    </main>
  
  </div>
</div>



    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>