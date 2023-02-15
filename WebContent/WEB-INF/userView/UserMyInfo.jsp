<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserMyInfo.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserMyInfo.css">
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
	$(document).ready(function()
	{
		$("#submit").click(function()
		{
        	// alert("확인");
        	$(location).attr("href", "usermyinfoupdateform.action");
         
		});
		
		$(".quabtn").click(function()
		{
			//alert("확인");
			$(location).attr("href", "usermyqna.action");
		});
		
		$(".reportbtn").click(function()
		{
			$(location).attr("href", "usermyreport.action");
		});
		
		$(".warningbtn").click(function()
		{
			$(location).attr("href", "usermywarning.action");
		});
   });
   
</script>
</head>   
<body class="Site">
   <div class="Site-content" id="wrap">
      <div class="import">
            <c:import url="UserMenu.jsp"></c:import>
      </div><!-- import -->
         
<div class="container">
<div class="row flex-lg-nowrap">
  <div class="col">
    <div class="row">
      <div class="col mb-3">
        <div class="card">
          <div class="card-body">
            <div class="e-profile">
            
              <div class="row profileRow">
                <div class="col-12 col-sm-auto mb-3 ">
                  <div class="mx-auto profileDiv">
                    <c:choose>
	                	<c:when test="${user.user_profile eq null }">
			                <img src="images/150854603.png" id="userImg" alt="" class="d-block ui-w-100 rounded-circle">
	                	</c:when>
	                	<c:otherwise>
			                <img src="${user.user_profile }" id="userImg"  alt="" class="d-block ui-w-100 rounded-circle">
	                	</c:otherwise>
                	</c:choose>
                    </div>
                  </div>
                </div>
              </div>
              
              <ul class="nav nav-tabs">
                <li class="nav-item"><a href="" class="active nav-link">나의 정보</a></li>
              </ul>
              <div class="updateBtnDiv">
                 <button class="btn btn float-right" id="submit" style="background-color: #a6a19b" type="button">수정</button>
              </div>
              
              
              <!-- table영역 -->
              <div class="tab-content">
                <div class="tab-pane active">
                    <div class="row">
                      <div class="col">
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                             <table class="table table-bordered customTable">
                        <tr>
                            <th>닉네임</th>
                             <td>${user.user_name }</td>
                         </tr>
                         <tr>   
                            <th>아이디</th>
                            <td>${user.user_id }</td>
                          </tr>  
                         <tr> 
                            <th>자기소개</th>
                             <td>${fn:replace(user.user_intro, replaceWord, '<br>') }</td>
                          </tr>
                          <tr>
                            <th>이메일</th>
                             <td>${user.user_email }</td>
                           </tr>
                           <tr>  
                            <th>전화번호</th>
                            <td> ${user.user_tel }</td>
                            </tr>
                            
                            <tr>
                            <th>성별</th>
                            <td>${user.user_gender }</td>
                            </tr>
                           
                           <tr>
                            <th>관심지역</th>
                            <td>
                            	<c:forEach var="fregion" items="${fregionList }">
                            		${fregion } 
                            	</c:forEach>
                            </td>
                            <!-- <td>부산 서울 제주</td> -->
                            </tr>
                            <tr>
                            <th>관심 카테고리</th>
                            <td>
                            	<c:forEach var="fcategory" items="${fcategoryList }">
                            		${fcategory } 
                            	</c:forEach>
                            </td>
                            <!-- <td>먹거리 힐링</td> -->
                            </tr>
                        </table>
                       </div>
                     </div>
                  </div>
                 </div>
             </div>
             
           <!-- table영역 -->            
             
             
                 <ul class="nav nav-tabs">
                <li class="nav-item"><a href="" class="active nav-link">나의 이력 관리</a></li>
                 </ul><br>
                        
                    <div class="row ">
                      <div class="col reportBtns"> 
                        <button class="btn btn-lg quabtn" style="background-color: #3b5998; color:white; width: 230px;" type="submit">내가 질문 한 내역</button>
                        <button class="btn btn-lg reportbtn" style="background-color: #3b5998; color:white; width: 230px;" type="submit">내가 신고 한 내역</button>
                         <button class="btn btn-lg warningbtn" style="background-color: #3b5998; color:white; width: 230px;" type="submit">경고 받은 내역</button>
                      </div>
                    </div>
                     <div class="col d-flex justify-content-end"><a href="userwithdrawal.action">회원탈퇴</a> 
                     </div>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
   </div>
 </div>
</div><!-- wrapper -->

<!-- footer -->

<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->
</body>
</html>