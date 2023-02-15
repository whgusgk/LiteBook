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
<title>UserMyPageLikedbook.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserMyPageLikedbook.css">

<style type="text/css">
	#userImg
	{
		width: 143px;
		height: 143px; 
		object-fit: cover;
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">

	$(function()
	{
		$(".infoBtn").click(function()
		{
			$(location).attr("href", "usermyinfo.action");
		});
		
		$("#writeBtn").click(function()
		{
			$(location).attr("href", "usermypagewritecomment.action");
		});
		
	});

</script>

</head>   
<!-- 테이블 영역 tr데이터 20개이상 불가능 -->
<body class="Site">
   <div class="Site-content" id="wrap">
      <div class="import">
            <c:import url="UserMenu.jsp"></c:import>
      </div><!-- import -->
   
<div class="layout-content">
          <!-- Content -->
          <div class="container" >

            <!-- Header -->
            <div class="container-m-nx container-m-ny theme-bg-white mb-4" >
            <div style="display:flex;">
              <div class="media col-md-10 col-lg-10 col-xl-4 py-5" style="margin-left:200px;" >
                <c:choose>
                	<c:when test="${user.user_profile eq null }">
		                <img id="userImg"  src="images/150854603.png" alt="" class="d-block ui-w-100 rounded-circle">
                	</c:when>
                	<c:otherwise>
		                <img id="userImg"  src="${user.user_profile }" alt="" class="d-block ui-w-100 rounded-circle">
                	</c:otherwise>
                </c:choose>
                <br>
                <button id="book" type="button" class="btn btn-info infoBtn">나의 정보</button>
               
                <div class="media-body ml-5"><br>
                  <h4 class="font-weight-bold mb-4">${user.user_name }</h4>
                  <div class="text-muted mb-4">
                   ${fn:replace(user.user_intro, replaceWord, '<br>') }
                  </div>

                  <a class="d-inline-block text-body">
                    <strong>관심지역</strong>
                    <c:forEach var="fregion" items="${fregionList }">
                    	<span class="text-muted">${fregion }</span>
                    </c:forEach>
                    <!-- <span class="text-muted">제주</span> -->
                  </a>
                  <br>
                  <a class="d-inline-block text-body">
                    <strong>관심카테고리</strong>
                    <c:forEach var="fcategory" items="${fcategoryList }">
	                    <span class="text-muted">${fcategory }</span>
                    </c:forEach>
                    <!-- <span class="text-muted">먹거리</span> -->
                  </a>
                </div>
            </div>
                
               <div class="col-xl-4">
                <div class="card mb-4" style="margin-top:100px;">
                  <div class="card-header">활동게이지</div>
                  <div class="card-body">

                    <div class="mb-1">좋아요 -<small class="text-muted">${lcount }%</small></div>
                    <div class="progress mb-3" style="height: 4px;">
                      <div class="progress-bar bg-secondary" style="width: ${lcount*10 }%;"></div>
                    </div>

                    <div class="mb-1">여행책 기록 - <small class="text-muted">${bcount }%</small></div>
                    <div class="progress mb-3" style="height: 4px;">
                      <div class="progress-bar bg-success" style="width: ${bcount*10 }%;"></div>
                    </div>

                    <div class="mb-1">댓글 - <small class="text-muted">${ccount }%</small></div>
                    <div class="progress mb-3" style="height: 4px;">
                      <div class="progress-bar bg-warning" style="width: ${ccount*10 }%;"></div>
                    </div>

                    <div class="mb-1">경고 - <small class="text-muted">${wcount }%</small></div>
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar bg-danger" style="width: ${wcount*10 }%;"></div>
                    </div>

                  </div>
                </div>
            </div>
                
              </div>
            </div>
            </div>
            </div>
            
            <!-- Header -->

            <div class="row table_content">
              <div class="col">
                <div class="card mb-4">
                  <div class="card-body">
               
                 <div class="card-footer text-center p-0">
                    <div class="row no-gutters row-bordered row-border-light">
                     <div class="main_header">
         <button type="button" class="btn btn-primary " id="bookBtn">좋아요 한 여행책</button>
         <button type="button" class="btn btn-default" id="writeBtn">내가 쓴 댓글</button>
      </div>
       <div class="main_list">
         
         
         <table class="table table-hover">
            <thead>
               <tr>
                  <th></th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
            	<c:forEach var="book" items="${likeBookList }">
            		<tr>
            			<td>${book.book_num }</td>
            			<td>
            				<a href="userbook.action?book_num=${book.book_num }">
            					${book.book_title }
            				</a>
            			</td>
            			<td>${book.writer_name }</td>
            			<td>${book.book_date }</td>
            			<td></td>
            		</tr>
            	</c:forEach>
               
               <!-- 
               <tr>
                  <td>1</td>
                  <td>우리동네 한바퀴</td>
                  <td>홍길동</td>
                  <td>2022.12.11</td>
                  <td></td>
                  
               </tr>
               <tr>
                  <td>2</td>
                  <td>2022 고기집 어워드</td>
                  <td>김첨지</td>
                  <td>2022.12.06</td>
                  <td></td>      
               </tr>
               -->
            </tbody>
         </table>
      </div>
      </div>
      </div>
      </div>
                <!-- / Info -->


              </div>

              </div>
            </div>

          </div>
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