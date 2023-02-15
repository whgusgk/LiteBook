<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String selectNum = request.getParameter("cstatusnum");
	String search = request.getParameter("keyword");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminReportList.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

       
    </style>
    <!-- Custom styles for this template -->
    <link href="css/AdminReportList.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/AdminStyle.css" rel="stylesheet">
<script src= "https //code.jquery.com/jquery-3.5.1.min.js /script"></script>
<script type="text/javascript">
	
	
	
	$(function()
	{
		var selectNum = <%=selectNum %>;
		
		if(selectNum==null)
			selectNum=2;
		
		$("#type").val(selectNum);
		
		
		$("#type").change(function()
		{
			//selectNum = new URLSearchParams(location.search);
			
			//alert(selectNum);
			selectNum = $(this).val();
			$(this).val(selectNum).attr("selected", "selected");
			
			$(location).attr("href", "adminreportlist.action?cstatusnum=" + $(this).val());
		});
		
		
	});
 
</script>
<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>
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
        <h1 class="h2">신고 관리</h1>
      </div>
        
       <div class="main_header">
			<div class="main_leftHeader">
				<form action="" method="post" id="searchForm">
					<select class="form-control" id="type">
						<option value="2" selected>전체</option>
						<option value="0">미처리</option>
						<option value="1">처리완료</option> 
					</select>
				</form>
				
			</div><!-- main_leftHeader -->

			<!-- <div class="main_rightHeader">
				<button type="button" class="btn btn-primary notBlind" id="notBlind">블라인드 해제</button>
			</div>main_rightHeader -->
		</div>
		
		<div class="main_list">
			
			<table class="table table-hover">
				<thead>
					<tr>
						<!-- <th>번호</th>  -->
						<th>신고사유</th>
						<th>제목</th>
						<th hidden="">카테고리</th>
						<th>신고자</th>
						<th>신고일</th>
						<th>처리일</th>
						<th>처리상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="r" items="${list }" varStatus="status">
					<tr>
 					<c:choose>
						<c:when test="${r.status_state eq '미처리'}">
							<td>${r.reason }</td>
							<td><a href="reportwarningreasoninsertform.action?type=${r.type }&report_num=${r.report_num}">${r.report_title }</a></td>
							<td>${r.writer }</td>
							<td>${r.report_date }</td>
							<td>${r.status_date }</td>
							<td>${r.status_state }</td>
						</c:when>
						
						<c:otherwise>
							<td>${r.reason }</td>
							<td>${r.report_title }</td>
							<td hidden="">${r.type }</td>
							<td>${r.writer }</td>
							<td>${r.report_date }</td>
							<td>${r.status_date }</td>
							<td>${r.status_state }</td>
						</c:otherwise>
					</c:choose>
						
						<td>${r.blind }</td>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
		
		</div><!-- main_list -->
		
		
		
		<!-- 전체기준 검색(처리,미처리 전부 출력) -->
		<form action="adminreportsearchlist.action" method="get" id="searchForm" class="form-inline">
      <div class="main_rightFooter" style="width: 300px;">
              <!--  <select class="form-control selectArea" aria-label=abled id="subType">
                  <option value="0" selected>신고자</option>
               </select> -->
               <input type="text" value="신고자"
               style="width: 80px; height: 40px; margin-top: 4px;" readonly="readonly" class="form-control">
               
               <div class="input-group inputArea">
                  <input type="text" name="keyword" class="form-control" id="userName">
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
     <!-- <ul class="pagination" >
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
     </ul> -->
     ${pageList }
   </nav>


    </main>
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>