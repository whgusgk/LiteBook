<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminCommentList.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

  

    
    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/AdminMemberCommentList.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
         <h2 class="h2">회원 상세정보</h2>
      </div>
    
    
              
<!--    <div style="width: 1280px; margin: auto;">    
   <div style="display:inline-block; vertical-align:top;">
 --><!--    <div style="display:inline-block; vertical-align:top;"> -->
   <div class="containerDiv">    
      <div class="imgDiv">
       <img src="images/150854603.png" alt="img" class="img-circle">
      </div>
   
   
   <div class="tableDiv">
      <table class="table table-bordered">
    <tbody>
      <tr>
         <th>아이디</th>
         <!-- <td>batman</td> -->
         <td>${memberInfo.user_id}</td>
         <th>닉네임</th>
         <!-- <td>홍길동</td> -->
         <td>${memberInfo.user_name}</td>
      </tr>
      <tr>
         <th>생년월일</th>
         <!-- <td>1998.12.18</td> -->
         <td>${memberInfo.user_birth}</td>
         <th>성별</th>
         <!-- <td>남성</td> -->
         <td>${memberInfo.user_gender}</td>
      </tr>
      <tr>
         <th>이메일</th>
         <!-- <td>superman@test.com</td> -->
         <td>${memberInfo.user_email}</td>
         <th>전화번호</th>
         <!-- <td>010-1111-1234</td> -->
         <td>${memberInfo.user_tel}</td>
      </tr>
      <tr>
       <th>자기소개</th>
      <!--  <td colspan="3">&nbsp;홍길동입니다.
       </td> -->
       <td colspan="3">&nbsp;${memberInfo.user_intro}</td>
      </tr>
    </tbody> 
   </table>
   <br>
   <div class="btnSet">
       <button type="button" class="btn btn-default control btns" onclick="location.href='adminmemberbooklist.action?sign_num=${memberInfo.sign_num}' ">여행책</button>
       <button type="button" class="btn btn-default control btns" onclick="location.href='adminmembercardlist.action?sign_num=${memberInfo.sign_num}' ">여행카드</button>
       <button type="button" class="btn btn-default control btns updateBtn" onclick="location.href='adminmembercommentlist.action?sign_num=${memberInfo.sign_num}' ">댓글내역</button>
       <button type="button" class="btn btn-default control btns" onclick="location.href='adminmemberwarninglist.action?sign_num=${memberInfo.sign_num}' ">경고이력</button>
      </div>
   <br><br>
   
   <div class="main_list">
           <p>총 ${memberCommentCount}건</p>
         <table class="table table-hover">
           <thead>
            
              <tr>
              <th colspan="5" ></th>
              <th>내용</th>
              <th>작성일</th>
              </tr>
        </thead>
           <tbody>
          <!-- 
          <tr>
              <td colspan="5">1</td>
              <td>저도 한번 가보고 싶네요..</td>
              <td>2022.03.28</td>
          </tr>
          <tr>
              <td colspan="5">2</td>
              <td>웨이팅이 심한가요?</td>
              <td>2022.12.11</td>
          </tr>
          <tr>
              <td colspan="5">3</td>
              <td>친구랑 둘이서 가기 좋을까요?</td>
              <td>2023.01.05</td>
          </tr>
          테스트 
          -->
             <c:forEach  var="cl" items="${commentList}">
							<tr>
								<td colspan="5">${cl.comment_num }</td>
								<td><a href="adminrecordbook.action?book_num=${cl.book_num}">${cl.comment_content }</a></td>
								<td>${cl.comment_date}</td>
							</tr>
					</c:forEach>             
                     
              </tbody>
            </table>         
       </div> <!-- main_list -->
       
      
 
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
     ${pageList}
   </nav>
   </div> <!-- tableDiv -->

</div>  <!-- containerDiv -->
    </main>
  
  
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>