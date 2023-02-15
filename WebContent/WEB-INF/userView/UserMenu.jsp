<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserMenu.jsp</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <!-- Custom CSS & JS -->  
<script src="js/mainJS.js"></script>
  
  <!-- 폰트 어썸 추가-->
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="css/UserMain.css">
<script>

</script>
<style type="text/css">

</style>
</head>
<body>

<!-- <div class="container"> -->
   <!-- Header -->

   <header>

      <div class="header-inner">

        <div class="logo">
          <div class="logo_img">
            <a href="usermain.action"><img src="images/ImageToStl.com_lite12.svg"></a>
          </div>
          <div class="logo_title">
            <span>라이트북</span>
          </div>
        </div> <!-- logo-->
  
        <div class="gnb">
              <div class="gnbleft_a">
                <a href="usernotelist.action">여행 기록</a>
                <a href="userallbooklist.action">전체 책보기</a>
                <a href="usernoticelist.action">공지사항</a>
              </div><!-- gnbleft_a-->
              
              <div class="gnbleft_b">
                <form action="usersearch.action" id="searchForm" method="post">
                  <div class="search-wrapper">
                     <div class="input-holder">
                       <input type="text" class="search-input" placeholder="Type to search" name="title"/>
                       <button type="button" class="search-icon" onclick="searchToggle(this, event);" > <!-- onclick="searchToggle(this, event);" -->
                     <i class="fa-solid fa-magnifying-glass"></i>
                       </button>
                     </div>
                  <span class="close" onclick="searchToggle(this, event);"></span> <!-- onclick="searchToggle(this, event);" -->
                </form>
              </div> <!-- gnbleft_b-->
            </div><!-- gnb-->
            
            
            
        </div> <!--header-inner-->
<!-- 유저 로그인,회원가입 / 마이페이지 스크랩 로그아웃 알림이 올영역-->
        <div class="userInfo">



 <c:choose>
			   <c:when test = "${sessionScope.userSession == null }">
			            <span class="signUp">
			              <button type="button" id="signUpBtn" onClick="location.href='resiinsert.action'">회원가입
			              </button>
			            </span>
			            <span class="signIn">
			              <button type="button" id="signInBtn" onClick="location.href='userloginform.action'">로그인</button>
			            </span>
			   </c:when>
			   <c:otherwise>
			            <span>
			              <button type="button"  id="mypageBtn" onClick="location.href='usermypagelikedbook.action'">마이페이지
			                  </button>
			                </span>
			                <span>
			              <button type="button"  id="mypageBtn" onClick="location.href='userscraplist.action'">스크랩
			              </button>
			            </span>
			            <span>
			              <button type="button"  id="mypageBtn" onClick="location.href='userlogout.action'">로그아웃
			              </button>
			            </span>
			
			            <span> 
			              <button type="button" id="notificationBtn">
			                알림
			              </button>
			            </span>
			   </c:otherwise>
</c:choose>




          <!-- 세션이 없을경우 띄워줄 영역-->
          <!-- 
            <span class="signUp">
              <button type="button" id="signUpBtn">회원가입
              </button>
            </span>
            <span class="signIn">
              <button type="button" id="signInBtn">로그인</button>
            </span>
            
           -->
          
          <!-- 세션이 있을경우 띄워줄 영역-->
          <!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->

          <!--

            <span>
              <button type="button"  id="mypageBtn">마이페이지
                  </button>
                </span>
                <span>
              <button type="button"  id="mypageBtn">스크랩
              </button>
            </span>
            
            <span>
              <button type="button"  id="mypageBtn">로그아웃
              </button>
            </span>

            <span> 
              <button type="button" id="notificationBtn">
                알림
              </button>
            </span>
            
          -->
            <!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--> 
        </div><!--userInfo-->
    </header>



</body>
</html>