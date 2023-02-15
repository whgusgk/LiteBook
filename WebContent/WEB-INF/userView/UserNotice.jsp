<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
   
   String pageNum = request.getParameter("pageNum");
   pageContext.setAttribute("replaceWord", "\n");
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserSearch.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserNotice.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
        .main_footer_toList{
          float: right;
        }

        .main_content_container{
          display:flex;
        }
        .container_form{
          width : 20%;
          margin:1rem;
        }
        .container_answer{
          width : 100%;
        }
        .content_answer{
          height:48rem;
          border:1px solid black;
          margin-bottom: 3rem;
        }
                .listBtn{
            background-color:#1DB1F8;
            border: #1DB1F8;
            color:white;
        }
                .main_content{
          width:80%;
        }
        .main_listWrapper, .main_title
        {
           /* border: 1px solid red; */
           width: 1200px; 
           margin: auto;
        }
        
        .main_title
        {
           margin-top: 25px;
        }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

<script type="text/javascript">
	$(function()
	{
		// 목록으로 버튼 클릭 시
		$(".listBtn").click(function()
		{
			$(location).attr("href", "usernoticelist.action?pageNum=<%=pageNum %>");
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
         <h2>공지사항</h2>
      </div><!-- main_title -->
               
	
               
   
      <br><br>   
      <div class="main_listWrapper">
         <div class="main_list">

		 <div class="main_content_container">
            <div class="main_content_container number"></div>
                <div class="main_content_container container_form">번호</div>
              <div class="main_content_container container_answer">${notice.notice_num }</div>
            </div>
            <div class="main_content_container writtenDay">
              <div class="main_content_container container_form">작성일</div>
              <div class="main_content_container container_answer">${notice.notice_date }</div>
            </div>  
            <div class="main_content_container title">
              <div class="main_content_container container_form">제목</div>
              <div class="main_content_container container_answer">${notice.notice_title }</div>
              
            </div>
            
            
            <div class="main_content_container content">
              <div class="main_content_container container_form">내용</div>
              <div class="main_content_container container_answer content_answer" style="padding: 10px;">
			      ${fn:replace(notice.notice_content, replaceWord, '<br>') }      
            </div>
		
		<br />	
         </div><!-- main_list -->
         <div class="main_footer_toList">
              <button type="button" class="btn btn-default control listBtn">목록으로</button>
            </div><!-- main_footer_toList-->
      </div><!-- main_listWrapper -->
</div><!-- wrapper -->
</div>
<!-- footer -->
<!-- pageNav -->
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>