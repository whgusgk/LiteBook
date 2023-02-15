<%@ page contentType="text/html; charset=UTF-8"%>
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
            <a href="#"><img src="images/ImageToStl.com_lite12.svg"></a>
          </div>
          <div class="logo_title">
            <span>라이트북</span>
          </div>
        </div> <!-- logo-->
  
        <div class="gnb">
              <div class="gnbleft_a">
                <a href="#">여행 기록</a>
                <a href="#">전체 책보기</a>
                <a href="#">공지사항</a>
              </div><!-- gnbleft_a-->
              
              <div class="gnbleft_b">
                <form action="" id="searchForm">
                  <div class="search-wrapper">
	                  <div class="input-holder">
	                    <input type="text" class="search-input" placeholder="Type to search" />
	                    <button type="button" class="search-icon" onclick="searchToggle(this, event);">
	                    
						<i class="fa-solid fa-magnifying-glass"></i>
	                    
	                    
	                    </button>
	                  </div>
                  <span class="close" onclick="searchToggle(this, event);"></span>
                </form>
              </div> <!-- gnbleft_b-->
            </div><!-- gnb-->
            
            
            
        </div> <!--header-inner-->
<!-- 유저 로그인,회원가입 / 마이페이지 스크랩 로그아웃 알림이 올영역-->
        <div class="userInfo">
          <!-- 세션이 없을경우 띄워줄 영역-->
          
          


            <span class="signUp">
              <button type="button" id="signUpBtn">회원가입
              </button>
            </span>
            <span class="signIn">
              <button type="button" id="signInBtn">로그인</button>
            </span>
            
          
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