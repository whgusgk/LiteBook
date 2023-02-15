<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserAllBookList.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserAllBookList.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
	.btn-explore{
		width:100%;
	}
	.btn-explore:hover{
		background-color:#1DB1F8;
		color:white;
	}
</style>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">
	$(function(){
		$(".btn-explore").click(function()
		{
			//alert($(this).val());
			$(location).attr("href", "userbook.action?book_num="+$(this).val());
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
			<h2>전체 책보기 </h2>
		</div><!-- main_title -->
		
		
		
		<div class="main_header">
			<div class="main_leftHeader">
				<!-- 선택되면 쿼리문쏴서 데이터 끌어올수있게 함수 처리해줘야하는 셀렉트 영역 -->
				<select>
					<option>최신순</option>
					<option>좋아요 많은 순</option>
					<option>조회수 많은 순</option>
				</select>
				<select>
				<option>책 제목</option>
				<option>발행인</option>
				<option>내용</option>
			</select>
			</div><!-- main_leftHeader -->
				<form action="" method="post" id="searchForm" class="form-inline">
	               <div class="main_rightHeader">
	              			<div class="input-group inputArea">
			                  <input type="text" name="searchValue" class="form-control searchInput" id="searchInput">
				               <button type="submit" class="btn btn-primary submitBtn" id="submitBtn">
				                  <i class="fa-solid fa-magnifying-glass"></i> 
		               		   </button>
	     				 	</div>
	     			</div><!-- main_rightHeader -->
	        	</form>
			</div><!-- main_header -->

		
		<br><br>	
		<div class="main_listWrapper">
			<div class="main_list">
			
			<!-- 카드 영역 -->
			<div class="inner">
		      <div class="items">
		      
		      <!-- 데이터 삽입 영역(동적 데이터 구성) -->
		      <c:forEach var = "allBook" items="${allBookList}">
		        <div class="item">
		          <div class="photo">
		            <img src="${allBook.book_cover }" alt="">
		          </div><!-- photo -->
		          <div class="detail">
		            <h2>${allBook.book_title }</h2>
		            <div class="user-info">
		              <span class="user">
		              	<!-- 유저 프로필 사진 있다면 추가해도됨 -->
		                <!-- <img src="images/client-01.jpg" alt=""> -->${allBook.user_name }
		              </span>
		              <span class="comment">
		              	<!-- 좋아요 조회수 댓글 남길곳...   -->
		                <i class="fa fa-heart-o"></i>${allBook.like_count } <i class="fa fa-commenting"></i>${allBook.comment_count } <i class="fa-solid fa-eye"></i>${allBook.book_hit }
		              </span>
		            </div><!-- user-info -->
		          </div><!-- detail -->
 		          <button type="button" class="btn btn-explore" value="${allBook.book_num}">책보기</button> 
<!-- 		          <a class="btn-explore">책보기</a> -->
		        </div><!-- item -->
		      <!-- 데이터 삽입 영역 -->
		      </c:forEach>
		      
			 
		        

		      </div>
		    </div>
			
			
			
			
			
			
			
			
			
			
			<!-- 카드 영역 -->
			</div><!-- main_list -->
		</div><!-- main_listWrapper -->
</div><!-- wrapper -->

<!-- footer -->
<!-- pageNav -->
<nav aria-label="" class="pageNav">
	${pageList }
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
  
</nav>
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>