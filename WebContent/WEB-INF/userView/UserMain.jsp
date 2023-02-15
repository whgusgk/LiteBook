<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserMain.jsp</title>
  <!-- jQuery CDN -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <!-- Slick Slider -->
  <link rel="stylesheet" href="js/slick/slick-theme.css">
  <link rel="stylesheet" href="js/slick/slick.css">
  <script src="js/slick/slick.min.js"></script>

  <!-- TypeIt -->
  <script src="js/typeit.min.js"></script>
  <!-- Wow Scroll Reveal Animation -->
  <script src="js/wow.min.js"></script>
<script src="js/custom.js"></script>
  <!-- Custom CSS & JS -->  
<script src="js/mainJS.js"></script>
  
  <!-- 폰트 어썸 추가-->

  <link rel="stylesheet" href="css/UserMain.css">
  <link rel="stylesheet" href="css/responsive.css">
  <script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
  
  <script type="text/javascript">

  </script>
</head>
<body>

  <div class="container">
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
          <!-- 세션이 없을경우 띄워줄 영역-->
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
    <!-- Section : welcome -->
    <!-- display:none 풀어줘야함-->
    <section class="welcome">
      <div class="slideshow" id="slideshow">
        <!--<img src="images/20230111_165516419.jpg">-->

        <img src="images/travel-1767532_1280.jpg">
        <img src="images/photographer-1867417_1280.jpg">
        <img src="images/2019_03_02_66706_1551461528._large.jpg">
      </div>
      <div class="welcome-heading">
        <span>당신의 여행을 한권의 책으로</span>
        <h1>
          Write your travel
          <br>
          light your heart up
          <em id="typing" style="color:rgb(239, 162, 80);"></em>
        </h1>
        <p>
          특별한 여행을 더욱 더 특별하게, 
          <br>
          여행의 모든 기록을 순간의 카드처럼 저장하고
          <br>
          언제든 열람 가능한 여행 비밀노트를 작성하고
          <br>
          오직 당신만의 여행책을 완성하세요
        </p>
      </div>
      <div class="mouse">
        <span class="wheele"></span>
      </div>
    </section>
    
 
    
    <!-- Section : banner -->
    <section class="banner">
      <div class="banner-inner">
        <div class="banner-content">
          <input type="radio" name="tabmenu" id="tab1" checked>
          <input type="radio" name="tabmenu" id="tab2">
          <input type="radio" name="tabmenu" id="tab3">
          <div class="tab-btn">
            <label for="tab1">
              <em><img src="images/banner-note.png"></em>
              <span>여행노트</span>
            </label>
            <label for="tab2">
              <em><img src="images/banner-card.png"></em>
              <span>여행카드</span>
            </label>
            <label for="tab3">
              <em><img src="images/banner-book.png"></em>
              <span>여행책</span>
            </label>
          </div>
          <div class="tabs">
            <div class="tab tab1">
              <h2>Travel Note</h2>
              <p>
                기록하고 싶은 여행의 개요를 작성해보세요.
                <br>
                일목요연하게 정리된 여행을 추억할 수 있습니다.
              </p>
            </div>
            <div class="tab tab2">
              <h2>Travel Card</h2>
              <p>
                여행의 순간을 카드로 기록하세요. 기억하고 싶은 순간을 편하게 저장할 수 있습니다.  
                <br>
                순간을 차곡차곡 모아서 나만의 여행책을 만들 수 있습니다.
              </p>
            </div>
            <div class="tab tab3">
              <h2>Travel Book</h2>
              <p>
                기억하고 싶은 순간들을 모아서 당신만의 여행책을 작성해보세요.
                <br>
                여행책 속에서 새로운 여행이 다시 한번 눈앞에 펼쳐질거예요.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Section : feature -->
    <section class="feature" id="feature2">
      <div class="feature-inner">
        <div class="headline-share">
          <h1>여행 기록</h1>
          <p>
  
          </p>
        </div>
        <div class="feature-content">
          <div class="feature-mockup ltr wow">
            <img src="images/banner-note.png">
          </div>
          <div class="feature-about rtl wow">
            <img src="images/icon-num-01.png">
            <h2>여행 노트</h2>
            <p>
              여행 노트 작성에선 여행에 대한 전반적인 개요를 남길수 있습니다.
              <br> 제목, 여행기간, 여행지역, 동행인, 총 예산 등 특별한 당신만의 여행을 
              <br>추억할 만한 정보를 기입해보세요.
            </p>
          </div>
        </div>
        <div class="feature-content">
          <div class="feature-about ltr wow">
            <img src="images/icon-num-02.png">
            <h2>여행 카드</h2>
            <p>
              여행 노트를 작성할때, 여행 카드를 추가할 수 있습니다.
              해당 여행기간에 알맞는 순간을 기록하기 위해 여행카드를 작성할 수 있습니다.
              <br>
              여행카드에는 지도, 예산, 지출, 사진, 방문시간등과 같이 상세한 정보를 기입할 수 있습니다.
            </p>
          </div>
          <div class="feature-mockup rtl wow">
            <img src="images/banner-card.png">
          </div>
        </div>
        <div class="feature-content">
          <div class="feature-mockup ltr wow">
            <img src="images/banner-book.png">
          </div>
          <div class="feature-about rtl wow">
            <img src="images/icon-num-03.png">
            <h2>여행 책</h2>
            <p>
              특별했던 순간 순간이 모여, 
              <br>
              더욱 더 특별한 나만의 여행책을 만들수 있습니다.
              <br>
              그동안 기록했던 여행카드를 차곡차곡 모아서, 하나의 테마 혹은 나만의 이야기를 담은 여행책을 작성해보세요.
              <br>이야기 속에서 새로운 여행이 다시 펼쳐질 거예요.
            </p>
          </div>
        </div>
      </div>
    </section>
    
   
    
  
    
   
    
 
    
    <!-- Section : popular -->
    <section class="popular" id="feature7">
      <div class="popular-inner">
        <div class="headline-share">
          <h1>인기여행책</h1>
        </div>
        
        
        <div class="popular-content">        	
          <div class="popular-left ltr wow">
          	<c:forEach  var="bl" items="${bookList}">
          	<div class="popular-big" onclick="location.href='userbook.action?book_num=${bl.book_num}'">
              <c:choose>
				<c:when test="${bl.book_cover ==0}">
					<img src="images/kj1.jpg">
				</c:when>
				<c:otherwise>
					<img src="${bl.book_cover}">
				</c:otherwise>
			 </c:choose>
              <span class="badge hot">hot issue</span>
              <div class="popular-headline">
                <h2>${bl.book_title}</h2>
                <p>
                  ${bl.user_name}
                  <small class="date">${bl.book_date}</small>
                </p>
                <button type="button" class="btn-view">자세히 보기</button>
              </div>
            </div> 
			</c:forEach>
            
          </div> <!-- popular-left ltr wow -->
          
          
          <div class="popular-right rtl wow">
            <div class="popular-items">
              <!-- forEach돌릴곳 -->
            <c:forEach  var="bl2" items="${bookList2}">
          	<div class="popular-thum" onclick="location.href='userbook.action?book_num=${bl2.book_num}'">
              <c:choose>
				<c:when test="${bl2.book_cover ==0}">
					<img src="images/kj1.jpg">
				</c:when>
				<c:otherwise>
					<img src="${bl2.book_cover}">
				</c:otherwise>
			 </c:choose>
              <span class="badge hot"></span>
              <p>
                  ${bl2.book_title}
                  <small class="date">${bl2.book_date}</small>
                </p>
            </div> 
			</c:forEach>
            </div>
          </div><!-- popular-right -->
          
          
          
          
          
          
        </div>
      </div>
    </section>
</div>






    <!-- Footer -->
 <footer>
      <div class="footer-inner">
        <div class="footer-content">
          <div class="footer-logo">
            <!-- <img src="images/logoTwo.svg"> -->
          </div>
          <div class="copyright">
            <div class="policy-sns">
              <div class="policy">
                <span>
                  <a href="usernoticelist.action">공지사항</a> <em>|</em>
                  <a href="userfaqlist.action">고객센터</a>
                </span>
                <span>
                  Copyright LITEBOOK. All right reserved.
                </span>
              </div>
              <div class="sns">
                <a href="#none"><i class="xi-facebook"></i></a>
                <a href="#none"><i class="xi-instagram"></i></a>
                <a href="#none"><i class="xi-kakaostory"></i></a>
                <a href="#none"><i class="xi-naver"></i></a>
                <a href="#none"><i class="xi-youtube-play"></i></a>
              </div>
            </div>
            <div class="address">
              <span>
                (주)라이트북 | 대표자 : 고연수 | 사업자번호 : 123-4-56789 사업자 정보 확인 | 개인정보보호책임자 : HJK
              </span>
              <span>
                주소 : 서울특별시 마포구 서교동 447-5 풍성빌딩 2,3,4층 ㅣ 이메일: info@litebook.com
              </span>
            </div>
          </div>
        </div>
      </div>
    </footer>

  <!-- Go to top -->
  <a class="btn-top" href="#"><i class="xi-angle-up-thin"></i></a>
</body>
</html>