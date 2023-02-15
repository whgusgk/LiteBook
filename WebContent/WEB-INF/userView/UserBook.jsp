<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
   pageContext.setAttribute("replaceWord", "\n");
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserBook.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserBook.css">
<style type="text/css">


  .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.3);
        z-index: 1000;

        /* 숨기기 */
        z-index: -1;
        opacity: 0;
      }

      .show {
        opacity: 1;
        z-index: 1000;
        transition: all 0.5s;
      }

      .window {
        position: relative;
        width: 100%;
        height: 100%;
      }

      .popup {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ffffff;
        box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

        /* 임시 지정 */
        width: 1000px;
        height: 800px;

        /* 초기에 약간 아래에 배치 */
        transform: translate(-50%, -40%);
      }

      .show .popup {
        transform: translate(-50%, -50%);
        transition: all 0.5s;
      }

	.close{
		border:none;
	}
.item:before {
	opacity: 0.1;
	
}

.btn{
	border-radius:5px;
	border:transparent;
	color:white;
	margin-left:10px;
	height:30px;
	width:100px;
}

#updateBtn{
	background-color:#1DB1F8;
}
#deleteBtn{
	background-color:gray;
}
.comment-info{
	display:flex;
	justify-content:space-between;
}
.comment-item{
	margin-bottom:20px;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">
	$(function(){
		
		
		$(".updateBtn").click(function(){
			
			//alert("확인");
			$(location).attr("href","userbookupdateform.action?book_num="+$(this).val())
		});
		
		$(".deleteBtn").click(function(){
			
			//alert("확인");
			$(location).attr("href","userbookdelete.action?book_num="+$(this).val());
		});
		
	});
</script>
</head>   
<body class="Site">


<!-- Site-content :body와 묶여서 flex로 footer를 하단 고정시키기 위한 첫번째 방법 -->
<!-- wrap에 min-height을 줘서 footer를 하단 고정시키기 위한 두번째 방법-->
<div class="Site-content" id="wrap">
	<!-- Header (import) -->
	<div class="import">
		<c:import url="UserMenu.jsp"></c:import>
    </div><!-- import -->
   

	<!-- Section (book_container) -->
	<div class="book_container">
		<!-- inner -->
		<div class="inner">
			<!-- inner안에서 여행책개요 / 여행카드영역 세로 구분선 (summary, cardArea) -->
			<!-- summary (여행책 개요 영역)-->
			<div class="summary	">
				<!-- icons (북마크 아이콘이 오게될 영역) -->
				<div class="icons">
					<span class="book">
						<i class="fa-solid fa-bookmark"></i>
					</span>
				</div>
				
				<!-- writer (작가 카테고리 표시할 영역)-->
				<div class="writer">
					<div class="writer_icon">
						<span class="writer_icon_span">
							<i class="fa-solid fa-user-pen"></i>
						</span>
					</div>
					<div class="writer_text">
						<a href="userotherprofilecard.action?sign_num=${book.sign_num }"><span class="writer_text_span">${book.user_name } 작가님</span></a>
					</div>
				</div>
				
				<!-- category (맛집,쇼핑,체험,힐링,기타 등 카테고리 표시할 영역)-->
				<div class="category">
					<div class="category_icon">
						<span class="category_icon_span">
							<i class="fa-solid fa-shapes"></i>
						</span>
					</div>
					<div class="category_text">
						<span class="category_text_span">${book.bcategory_name }</span>
					</div>
				</div>
				
				<!-- title  (제목을 알려줄 영역)-->
				<div class="title">
					<div class="title_icon">
						<span class="title_icon_span">
							<i class="fa-solid fa-t"></i>
						</span>
					</div>
					<div class="title_text">
						<span class="title_text_span">${book.book_title }</span>
					</div>
				</div>
				
				<!-- memo (여행책 내부의 코멘트[메모]를 알려줄 영역)-->
				<div class="memo_container">
					<div class="memo">
						<div class="memo_icon">
							<span class="memo_icon_span">
								<!-- 메모 아이콘이 왜안뜨지.. -->
								<i class="fa-solid fa-file-pen"></i>
							</span>
						</div>
						<div class="memo_text">
							<!-- <span class="memo_text_span">Memo</span>  -->
						</div>
					</div><!-- memo -->
					
					<!-- memo_container 내부에서 메모를 띄워줄 div영역 설정 (UX를 위해 밝은배경, 검은글씨-->
					<div class="memoArea">
						<div class="memoArea_text">
						${fn:replace(book.book_comment, replaceWord, '<br>') }
						</div> <!-- memoArea_text -->
					</div> <!-- memoArea -->
				</div><!-- memo_container -->
			
				<!-- viewsDay (조회수와 날짜를 알려줄 영역)-->
				<div class="viewsDay">
					<span class="viewsDay_viewsSpan"> <i class="fa-solid fa-eye"></i>${book.book_hit }</span>
					<span class="viewsDay_dayspan"> ${book.book_date }</span>
				</div>
			
			</div>	<!-- summary -->
			
			
			<!-- cardArea (카드 영역) -->
			<div class="cardArea">
				
						<!-- <i class="fa fa-commenting"></i> -->
<button id="show" style="display:none;">팝업열기</button>
    <div class="background">
      <div class="window">
        <div class="popup">
          <div>
          <button id="close" style="margin-bottom:10px; border:none;">x</button>
          </div>
        
          <c:forEach var="comment" items="${commentList}">
			  <div class="comment-item">
			  	 <div class="comment-info">
				  	<div class="userName"><span><i class="fa-solid fa-user"></i></span>${comment.user_name} </div>        	
		          	<div class="commentDate"><span><i class="fa-solid fa-calendar-pen"></i></span>${comment.comment_date} </div>
			  	 </div>
		          <div class="comment"><span><i class="fa-solid fa-memo"></i></span>${comment.comment_content} </div>
			  </div>
          </c:forEach>
        
        </div>
        <div>
          <div></div>
        </div>
      </div>
    </div> 
    
       <script>
      function show() {
        document.querySelector(".background").className = "background show";
      }

      function close() {
        document.querySelector(".background").className = "background";
      }

      document.querySelector("#show").addEventListener("click", show);
      document.querySelector("#close").addEventListener("click", close);
    </script>
    
				<!-- icons (좋아요 아이콘 / 댓글 아이콘이 오게될 영역)-->
				<div class="icons">
					<span class="likedComment">
					<c:choose>
							<c:when test="${likedCheck ==1}">
								<button type="button" style="border: 0px;" onclick="location.href='userlikeddelete.action?book_num=${book_num}'"><i class="fa-solid fa-heart"></i></button>
							</c:when>
							<c:when test="${likedCheck ==2}">
							</c:when>
							<c:otherwise>
								<button type="button" style="border: 0px;" onclick="location.href='userlikedinsert.action?book_num=${book_num}'"><i class="fa fa-heart-o"></i></button>
							</c:otherwise>
						</c:choose>
						<!-- <i class="fa-solid fa-heart"></i> -->${book.like_count }
						<label for="show"><i class="fa fa-commenting btn-open-popup"></i></label>${book.comment_count }

<c:choose>
   <c:when test = "${sessionScope.userSession == null }"></c:when>
   
   <c:when test="${userSession == book.sign_num}">
   			<button type="button" id="updateBtn" name="updateBtn" class="btn updateBtn" value="${book.book_num }">수정</button>
			<button type="button" id="deleteBtn" name="deleteBtn" class="btn deleteBtn" value="${book.book_num }">삭제</button>
   </c:when>
  <c:when test="${sessionScope.userSession!=book.sign_num}">
          <button type="button" id="scrapBtn" name="scrapBtn" class="btn scrapBtn" onclick="location.href='userscrapselectlist.action?book_num=${book.book_num}'">스크랩</button> 
          <button type="button" id="reportBtn" name="reportBtn" class="reportBtn"
          style="color: gray; border: none; margin-left: 10px;"
          onclick="location.href='userreportform.action?type=book&num=' + ${book.book_num}">신고</button> 
   </c:when>
   
</c:choose>
						
						
						
						
					</span>
				</div>
				
				<!-- items (카드들이 적재될 영역	)-->
				<div class="items">

				<!-- item(하나하나의 카드 아이템 - 동적으로 구성하게 될것, 현재는 정적으로 구성) -->
				<!-- 데이터 삽입 영역(동적 데이터 구성) -->
				
				<c:forEach var="card" items="${cardList }">
		        <div class="item">
		          <div class="photo">
		            <img src="${card.card_img1 }" alt="">
		          </div>
		          
		          <div class="detail">
		            <h2>${card.card_location }</h2>
		            <p>${card.card_visitdate }</p>
		          </div>
		        </div>
				</c:forEach>
		      <!-- 데이터 삽입 영역 -->

				<!-- item(하나하나의 카드 아이템 - 동적으로 구성하게 될것, 현재는 정적으로 구성) -->
				<!-- 데이터 삽입 영역(동적 데이터 구성) -->
<!-- 		        <div class="item">
		          <div class="photo">
		            <img src="images/jeju1.jpg" alt="">
		          </div>
		          <div class="detail">
		            <h2>제주도 돌하르방</h2>
		            <p>2023-12-31</p>
		            </div>
		        </div> -->
		      <!-- 데이터 삽입 영역 -->
		      
		      
		      
				</div><!-- items -->
			</div><!-- cardArea -->

			


		</div> <!-- inner -->
		
	
	
	
	
	</div><!-- Section (book_container) -->             
   
</div><!-- Site-content -->

<!-- footer -->
<c:import url="UserFooter.jsp"></c:import> 
<!-- footer -->




</body>
</html>