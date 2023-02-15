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
<title>UserOtherProfileCard.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserOtherProfilebCard.css">
<style type="text/css">
	#userImg
	{
		width: 170px;
		height: 170px; 
		object-fit: cover;
	}
</style>
<script type="text/javascript">
	$(function()
	{
		
		$("#cardBtn").click(function()
		{
			$(location).attr("href", "userotherprofilebook.action");
		});
		
	});
</script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

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
                <img id="userImg" src="images/150854603.png" alt="" class="d-block ui-w-100 rounded-circle">
                
                  <div class="media-body ml-5">
                  <h4 class="font-weight-bold mb-4">${user.user_name }</h4>
                  <div class="text-muted mb-4">
                      ${fn:replace(user.user_intro, replaceWord, '<br>') }
                  </div>

                  <a class="d-inline-block text-body">
                    <strong>관심지역</strong>
                    <c:forEach var="fregion" items="${fregionList }">
                    	<span class="text-muted">${fregion }</span>
                    </c:forEach>
                  </a>
                  <br>
                  <a class="d-inline-block text-body">
                    <strong>관심카테고리</strong>
                    <c:forEach var="fcategory" items="${fcategoryList }">
	                    <span class="text-muted">${fcategory }</span>
                    </c:forEach>
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
         <button type="button" class="btn btn-default likedBtn" id="bookBtn">여행카드</button>
         <button type="button" class="btn btn-primary" id="cardBtn" onclick="location.href='userotherprofilebook.action?user_num=${user_num }'">여행책</button>
      </div>
       <div class="main_list"><input type="text" hidden="" ${user_num }>
       <table class="table table-hover">
				<thead>
					  <tr>
					  		  <th></th>	
                              <th>장소명</th>
                              <th>방문시간</th>
                              <th>예산</th>
                              <th></th>
                              <th>작성일</th>
                         	  <th>스크랩</th>
                              </tr>
                         </thead>     
                           <tbody>
            	<c:forEach var="card" items="${CardList }">
            		<tr>
            			<td>${card.card_num }</td>
            			<td>
            				<a href="usercard.action?card_num=${card.card_num }">
            					${card.card_location }
            				</a>
            			</td>
            			<td>${card.card_time }</td>
            			<td>${card.card_budget }</td>
            			<td></td>
            			<td>${card.card_date }</td>
            			<td><button id="book" type="button"class="btn btn-info" onclick="location.href='userscrapotherprofilecardinsert.action?card_num=${card.card_num}&user_num=${user_num}'">스크랩</button></td>
            		</tr>
            	</c:forEach>
                
                        <!-- 
                          <tr>
                          	  <td>1</td>
                              <td colspan="5">한라산</td>
                              <td>11:00</td>
                              <td>30,000</td>
                              <td>생각보다 높음...</td>
                              <td>2022.10.25</td>
                              <td><button id="book" type="button"class="btn btn-info" >스크랩</button></td>
                          </tr>
                            
                          <tr>
                          	  <td>2</td>
                              <td colspan="5">부산 ooo식당</td>
                              <td>14:45</td>
                              <td>15,000</td>
                              <td>부산여행 1일차</td>
                              <td>2019.09.15</td>
                              <td><button id="book" type="button"class="btn btn-info">스크랩</button></td>
                          </tr>
                       
                          <tr>
                          	  <td>3</td>
                              <td colspan="5">홍대입구역 oo카페</td>
                              <td>15:30</td>
                              <td>30,000</td>
                              <td>인스타 카페</td>
                              <td>2015.01.05</td>
                              <td><button id="book" type="button"class="btn btn-info">스크랩</button></td>
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