<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	pageContext.setAttribute("replaceWord", "\n");
	String pageNum = request.getParameter("pageNum");
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>AdminQuestion.jsp</title>

     <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

	<style type="text/css">
	
		.insertBtn{
			background-color: #1DB1F8;
			border: #1DB1F8;
			margin-right: 10px;
		}
	
	</style>

    <!-- Custom styles for this template -->
    <link href="css/AdminQuestion.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 왼쪽 사이드 메뉴 스크립트 -->
<script>

	$(function()
	{
		$(".insertBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "adminquestionreplyform.action?question_num=" + $(".insertBtn").val());
			
		});
		
		$(".listBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "adminquestionlist.action?pageNum=<%=pageNum%>");
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
           <h2>질문 답변</h2>
      </div>
        
       

        <!-- 채워야 할 영역 -->
      	.
		<div class="main_article">
                <div class="main_article_title row">
                        <div class="main_article_info row">
                          <div class="main_article_info_group row">
                              <div class="main_article_category row">
                                  <div class="main_article_form category">카테고리</div>
                                  <div class="main_article_answer category_answer">${question.qcategory_class } </div>
                               </div>     
                                
                              <div class="main_article_writter">
                                  <div class="main_article_form writter">작성자</div>
                                  <div class="main_article_answer writter_answer">${question.user_name }</div>
                                  <div class="main_article_form admin">담당자</div>
                                  <div class="main_article_answer admin_answer">${question.admin_name }</div>
                              </div>

                              <div class="main_article_day">
                                  <div class="main_article_form writtenDay">작성일시</div>      
                                  <div class="main_article_answer writtenDay_answer">${question.question_date }</div>      
                                  <div class="main_article_form answerDay">답변일시</div>      
                                  <div class="main_article_answer answerDay_answer">${question.answer_date }</div>      
                                </div> <!-- main_article_day-->
                                
                                <div class="main_section_question">
                                  <div class="main_section_form question_title">제목</div>      
                                  <div class="main_section_answer question_answer">${question.question_title }</div>      
                                </div>

                                <div class="main_section_content">
                                  <div class="main_section_form content">내용</div>      
                                  <div class="main_section_answer content_answer">${fn:replace(question.question_content, replaceWord, '<br>') }</div>      
                                </div>

                                <div class="main_section_reply">
                                  <div class="main_section_form reply">답변</div>      
                                  <div class="main_section_answer reply_answer">${fn:replace(question.answer_content, replaceWord, '<br>') }</div>      
                                </div>

                            </div> <!--main_article_info_group-->

                    </div><!-- main_article_info -->
                </div> <!-- main_article_title  -->
	  	 	<div class="main_footer_toList">
				<button type="button" class="btn btn-primary control insertBtn" value="${question.question_num }">답변하기</button>
				<button type="button" class="btn btn-default control listBtn">목록으로</button>
	      	</div>
    	</div><!-- main_article -->
      	<!-- 채워야 할 영역 -->
    </main>
  </div>
</div>


    <script src="assets/dist/js/bootstrap.bundle.min.js"></script>

      <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="js/dashboard.js"></script>
  </body>
</html>
