<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%
	String note_num = request.getParameter("note_num");
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserNote.jsp</title>

 <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
 
<script src="https://kit.fontawesome.com/b6c38d4bdc.js" crossorigin="anonymous"></script>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserNote.css">
<style type="text/css">

   .note_date{
      margin-top:20px;
      float:right;
      margin-left:20px;
   }
   .updateBtn{
      margin-left:20px;
      margin-top:20px;
      border-radius:5px;
      background-image: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);
      border:transparent;
      color:white;
      margin-left:10px;
      height:30px;
      width:100px;
      float:right;
   }
   .deleteBtn{
      margin-left:20px;
      margin-top:20px;
      border-radius:5px;
      background-image: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);
      border:transparent;
      color:white;
      margin-left:10px;
      height:30px;
      width:100px;
      float:right;
   }
   .dayCount{
      width:900px; margin-bottom:30px; margin-top:20px; margin-left:-330px;
   }
   .sorry{
      margin-bottom:30px;
   }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">

	$(function()
	{
		$(".updateBtn").click(function()
		{
			// alert("확인");
			$(location).attr("href", "usernoteupdateform.action?note_num=<%=note_num %>&startdate=${note.note_startdate }&lastdate=${note.note_lastdate}");
		});
		
		$(".deleteBtn").click(function()
		{
			// alert("확인");
			if (!confirm("노트를 지우면 복구할 수 없습니다.\n정말로 삭제하시겠습니까?"))
			{
				return;
			}
			else 
			{
				$(location).attr("href", "usernotedelete.action?note_num=<%=note_num%>");
			}
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
   

   <!-- Section (note_container) -->
   <div class="note_container">
      <!-- inner -->
      <div class="inner">
         <!-- inner안에서 여행책개요 / 여행카드영역 세로 구분선 (summary, cardArea) -->
         <!-- summary (여행책 개요 영역)-->
         <div class="summary   ">
            <!-- icons (노트 아이콘이 오게될 영역) -->
            <div class="icons">
               <span class="note">
                  <i class="fa-solid fa-note-sticky"></i>
               </span>
            </div>
            
            <!-- title  (제목을 알려줄 영역)-->
            <div class="title">
               <div class="title_icon">
                  <span class="title_icon_span">
                     <i class="fa-solid fa-t"></i>
                  </span>
               </div>
               <div class="title_text">
                  <span class="title_text_span">${note.note_title }</span>
               </div>
            </div>
            
            
            <!-- place  (장소를 알려줄 영역)-->
            <div class="place">
               <div class="place_icon">
                  <span class="place_icon_span">
                     <i class="fa-sharp fa-solid fa-location-dot"></i>
                  </span>
               </div>
               <div class="place_text">
                  <span class="place_text_span">${note.region_name }</span>
               </div>
            </div>
            
            
            <!-- company  (동행인을 알려줄 영역)-->
            <div class="company">
               <div class="company_icon">
                  <span class="company_icon_span">
                     <i class="fa-solid fa-users"></i>
                  </span>
               </div>
               <div class="company_text">
                  <span class="company_text_span">${note.note_company } 명 </span>
               </div>   
            </div>
            
            <!-- start  (시작일을 알려줄 영역)-->
            <div class="start">
               <div class="start_icon">
                  <span class="start_icon_span">
                     <i class="fa-regular fa-calendar-days"></i>
                  </span>
               </div>
               <div class="start_text">
                  <span class="start_text_span" id="startdate">${note.note_startdate } (시작일)</span>
               </div>
            </div>
            
            <!-- end  (종료일을 알려줄 영역)-->
            <div class="end">
               <div class="end_icon">
                  <span class="end_icon_span">
                     <i class="fa-regular fa-calendar-days"></i>
                  </span>
               </div>
               <div class="end_text">
                  <span class="end_text_span" id="lastdate">${note.note_lastdate } (종료일)</span>
               </div>
            </div>
            
            <!-- budget  (예산을 알려줄 영역) -->
            <div class="budget">
               <div class="budget_icon">
                  <span class="budget_icon_span">
                     <i class="fa-sharp fa-solid fa-file-invoice-dollar"></i>
                  </span>
               </div>
               <div class="budget_text">
                  <span class="budget_text_span">${note.note_budget }원 (총예산)</span>
               </div>
            </div>
            
            
            <!-- pay  (가계부[카드/현금/기타]를 알려줄 영역)-->
            <div class="pay_container">
               <div class="pay">
                  <div class="pay_icon">
                     <span class="pay_icon_span">
                        <i class="fa-sharp fa-solid fa-wallet"></i>
                     </span>
                  </div>
                  <div class="pay_text">
                     <span class="pay_text_span">가계부 (지출내역)</span>
                  </div>   
               </div>
               
               <div class="payArea">
                  <div class="payArea_text">
                  
                     <div class="pay_detail">
                        <p>
                           <span>카드</span> <span class="pay_card">${card } 원</span>
                        </p>
                        <p>
                           <span>현금</span> <span class="pay_cash">${cash } 원</span>
                        
                        </p>
                        <p>
                           <span>기타</span> <span class="pay_other">${etc } 원</span>
                        </p>
                        <p>
                           <span>총액</span> <span class="pay_total">${all } 원</span>
                        </p>
                     </div>
                  
                  </div> <!-- payArea_text -->
               </div> <!-- payArea -->
            </div><!-- pay_container -->

            <!-- pay (가계부[카드/현금/기타]  -->


         
         </div>   <!-- summary -->
         
         
         <!-- cardArea (카드 영역) -->
         <div class="cardArea">
            
            <!-- icons (좋아요 아이콘 / 댓글 아이콘이 오게될 영역)-->
            <div class="icons">
            <!-- -->
               <button type="button" id="deleteBtn" name="deleteBtn" class="deleteBtn">삭제</button>
               <button type="button" id="updateBtn" name="updateBtn" class="updateBtn">수정</button>
               <span class="note_date"> 작성일 | ${note.note_date }</span>
            </div> 
            
            <!-- items (카드들이 적재될 영역   )-->
            <div class="items">
            
               <c:forEach var="list" items="${lists }" varStatus="status">
               
                  <c:choose>
               
                  <c:when test="${empty list }">
                     <div class="dayArea">
                        <div class="dayCount">${status.count } 일차</div>
                        <div class="sorry">
                           아직 등록하신 카드가 없습니다.
                     </div>
                  </div>
                  </c:when>
                  
                  <c:otherwise>
                  <div class="dayCount">${status.count } 일차</div>
                  <c:forEach var="card" items="${list }">
                     <div class="item">
                        <div class="photo">
                           <c:choose>
                              <c:when test="${empty card.card_img1 }">
                                 <img src="images/notepad-g173876df1_640.jpg" alt="">
                              </c:when>
                              <c:otherwise>
                                 <img src="${card.card_img1 }" alt="">
                              </c:otherwise>
                           </c:choose>
                        </div>
                     
                        <div class="detail">
                        	<a href="usercard.action?card_num=${card.card_num }"><h2>${card.card_location }</h2></a>
                        <p>
                           <span class="detail_day">Day ${status.count }</span>
                           <span class="detail_time">${card.card_time }</span>
                        </p>
                        </div>
                        
                     </div>
                  </c:forEach>
                  </c:otherwise>
               
                  </c:choose>
               
               </c:forEach>
         
         </div><!-- items -->
            <!-- 데이터 삽입 영역 -->

            <!-- item(하나하나의 카드 아이템 - 동적으로 구성하게 될것, 현재는 정적으로 구성) -->
            <!-- 데이터 삽입 영역(동적 데이터 구성) -->
              <!-- 
              <div class="item">
                <div class="photo">
                  <img src="images/yeosoo2.jpg" alt="">
                </div>
                
                <div class="detail">
                  <h2>전남 여수시 종화동</h2>
                  <p>
                     <span class="detail_day">Day1</span>
                     <span class="detail_time">23시 15분</span>
                  </p>
                </div>
              </div>
              
              <div class="item">
                <div class="photo">
                  <img src="images/jeju1.jpg" alt="">
                </div>
                <div class="detail">
                  <h2>제주도 돌하르방</h2>
                  <p>
                     <span class="detail_day">Day2</span>
                     <span class="detail_time">15시 00분</span>
                  </p>
                  </div>
              </div>
               -->
            <!-- 데이터 삽입 영역 -->
            
            
         </div><!-- cardArea -->
      </div> <!-- inner -->
      
   
   
   
   
   </div><!-- Section (note_container) -->             
   
</div><!-- Site-content -->

<!-- footer -->
<c:import url="UserFooter.jsp"></c:import> 
<!-- footer -->




</body>
</html>