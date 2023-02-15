<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>UserResiForm.jsp</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link href="css/UserResiForm.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/UserResiForm.css">

 <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
 <script type="text/javascript">
 
 $(function()
{
	$("#id_check").click(function()
			{
				//alert("확인");
				// ID 중복 여부 검사
				
					var search = $("#user_id").val();
					
					// 입력 내용이 존재할 경우에만 서버로 전송할 수 있도록 처리
					if (search.replace(" ", "")=="")
					{
						return;
					}
					
					// ajax 처리
					idCheck();   
					
				});
		
	
	$("#name_check").click(function()
			{
				//alert("확인");
				// ID 중복 여부 검사
					var search = $("#user_name").val();
					
					// 입력 내용이 존재할 경우에만 서버로 전송할 수 있도록 처리
					if (search.replace(" ", "")=="")
					{
						return;
					}
					
					// ajax 처리
					nameCheck(); 
					
					
				});
		
				
				$("#submitBtn").click(function()
				{
					// alert("클릭 확인");
					// alert($("input[name=grade]:checked").val());
					
					// 입력 항목 검사
					if ($("#user_id").val()=="" || $("#user_pw").val()=="" || $("#user_name").val()==""
							|| $("#user_tel").val()=="" || $("#user_email").val()==""|| $("#year").val()==""|| $("#month").val()==""|| $("#day").val()=="")
					{
						alert("필수 입력 항목을 모두 기입해주세요.");
						return;
					}
					$('#frm').submit();
					
				});
					
			});
			
			function idCheck()
			{
				var user_id = $("#user_id").val().trim();
				$.post("idajax.action", {user_id : user_id}, function(data)
				{
					$("#err2").html(data).css("display", "inline");
					// alert($("#err2").html().trim());
					
				});
			}
			
			
			function nameCheck()
			{
				var user_name = $("#user_name").val().trim();
				$.post("nameajax.action", {user_name : user_name}, function(data)
				{
					$("#err").html(data).css("display", "inline");
					// alert($("#err2").html().trim());
					
				});
			}

/* 			
	// 생년월일 selectbox
	$(document).ready(function(){            
		 var now = new Date();
		 var year = now.getFullYear();
		var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
		var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
			  //년도 selectbox만들기               
			 for(var i = 1900 ; i <= year ; i++) {
			        $('#year').append('<option value="' + i + '">' + i + '년</option>');    
			   }

			    // 월별 selectbox 만들기            
			    for(var i=1; i <= 12; i++) {
			        var mm = i > 9 ? i : "0"+i ;            
			        $('#month').append('<option value="' + mm + '">' + mm + '월</option>');    
			    }
			    
			    // 일별 selectbox 만들기
			    for(var i=1; i <= 31; i++) {
			        var dd = i > 9 ? i : "0"+i ;            
			        $('#day').append('<option value="' + dd + '">' + dd+ '일</option>');    
			    }
			    $("#year  > option[value="+year+"]").attr("selected", "true");        
			    $("#month  > option[value="+month+"]").attr("selected", "true");    
			    $("#day  > option[value="+day+"]").attr("selected", "true");       
			  
			})			
			
 */ 
 </script>

</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h3 class="mb-3" style="text-align:center;">회원가입</h3>
        <form action="userinsert.action" method="post" role="form" id="frm"class="validation-form">
         <!--  <div class="row"> -->
            <div class=" input_id col-md-8 mb-3">
                    <label for="user_id">아이디(*)</label>
                    <div class="inputCustom">
                    <input type="text" class="input_id form-control" id="user_id" name="user_id" value="">
                  <button type="button" class="btn btn-secondary" id="id_check">중복확인</button>
                  </div>
                  <div>
                   <span id="err2" style="display: none; color: red; font-size: small;">중복된 아이디 입니다.</span><br>
                   </div> 
  
            </div>
         <!--    </div> -->
            <div class="col-md-7 mb-3">
              <label for="user_pw">비밀번호(*)</label>
              <input type="password" class="form-control"  id="user_pw" name="user_pw"  value="">
                 <!-- <span id="err" style="display: none; color: red; font-size: small;">비밀번호를 입력해주세요.</span><br> -->
            </div>
            
        <div class="col-md-8 mb-3">
              <label for="user_name">닉네임(*)</label>
              <div class="inputCustom">
              <input type="text" class="form-control" id="user_name" name="user_name" value="">
              <button type="button" class="btn btn-secondary" id="name_check">중복확인</button>
            </div>
             <span id="err" style="display: none; color: red; font-size: small;">중복된 닉네임 입니다.</span><br> 
            </div>
            
            <div class="col-md-10 mb-2">
              <label for="user_tel">전화번호(*)</label>
             <div class="form-outline mb-4 telInput">
             <input id="tel1" name="tel1" type="text" class="form-control form-control-lg" style="width: 27%;" maxlength='3'> -
            <input id="tel2" name="tel2"  type="text" class="form-control form-control-lg" style="width: 27%;" maxlength='4' > -
            <input id="tel3" name="tel3"  type="text" class="form-control form-control-lg" style="width: 27%;" maxlength='4' >
                <!--  <span id="err" style="display: none; color: red; font-size: small;">전화번호를 입력해주세요.</span><br> -->
            </div>
          
          <div class="mb-3">
            <label for="user_email">이메일</label>
              <div class="inputCustom">
            <input type="text" class="form-control"  id="user_email" name="user_email" placeholder="you@example.com">
            <!--  <button type="button" class="btn btn-secondary" id="email_check">인증하기</button> -->
             <!-- <span id="e_msg" style="display: none; color: red; font-size: small;">이메일을 입력해주세요.</span><br> -->
         </div>
          </div>

          <div class="col-md-30 mb-3">
            <label for="user_birth">생년월일</label>
             <div class="form-outline mb-4 telInput" id="user_birth">
            <input type="text" class="form-control"  id="user_birth" name="user_birth" placeholder="2000-05-05">
          </div>
          </div>
          
          </div>
          
          
          <div>
             <!--  선택사항 표시해줄 영역 -->
          </div>
          
           <div class="custom-control custom-checkbox genderinput">
               <!--   <label for="gender">성별</label><br>
                <label><input type="checkbox" name="gender">남자</label>
                <label><input type="checkbox" name="gender">여자</label>
                <label><input type="checkbox" name="gender">선택안함</label>  -->
                <label for="gender_num">성별</label>
                <div class="radio_gender">
                  <input type="radio" name="gender_num" value="1" id="gender_num" checked="checked">
                  <label for="gender_num">남자</label>
                  <input type="radio" name="gender_num" id="gender_num" value="2" >
                  <label for="gender_num">여자</label>
                  <input type="radio" name="gender_num" id="gender_num" value="0" >
                  <label for="notChecked">선택 안함</label>
            </div>  
          </div>
          
             <hr class="mb-3">
           
            <div class="col-md-10 mb-3">
              <label for="region_selected">관심 지역 (선택)</label><br>
              <div class="form-outline mb-4 telInput">
              <select class="custom-select d-block w-100" name="region_num1" id="region_num1">
                <option value="0">선택1</option>
                <c:forEach var="list" items="${list }"> 
                	<option value="${list.region_num }">${list.region_name }</option>
                </c:forEach>
              </select>
              
               <select class="custom-select d-block w-100" name ="region_num2" id="region_num2">
                <option value="0">선택2</option>
                <c:forEach var="list" items="${list }"> 
                	<option value="${list.region_num }">${list.region_name }</option>
                </c:forEach>
              </select>
               <select class="custom-select d-block w-100" name ="region_num3" id="region_num3">
                <option value="0">선택3</option>
                <c:forEach var="list" items="${list }"> 
                	<option value="${list.region_num }">${list.region_name }</option>
                </c:forEach>
              </select>
             </div>
            </div>
            
             <div class="col-md-10 mb-3">
              <label for="category_selected">관심 카테고리 (선택)</label><br>
              <div class="form-outline mb-4 telInput">
              <select class="custom-select d-block w-100" name="tcategory_num1" id="tcategory_num1">
                <option value="0">선택1</option>
                 <c:forEach var="tlist" items="${tlist }"> 
                	<option value="${tlist.tcategory_num }">${tlist.tcategory_name }</option>
                </c:forEach>
              </select>
               <select class="custom-select d-block w-100" name ="tcategory_num2" id="tcategory_num2">
                <option value="0">선택2</option>
                <c:forEach var="tlist" items="${tlist }"> 
                	<option value="${tlist.tcategory_num }">${tlist.tcategory_name }</option>
                </c:forEach>
              </select>
               <select class="custom-select d-block w-100" name ="tcategory_num3" id="tcategory_num3">
                <option value="0">선택3</option>
                 <c:forEach var="tlist" items="${tlist }"> 
                	<option value="${tlist.tcategory_num }">${tlist.tcategory_name }</option>
                </c:forEach>
              </select>
             </div>
            </div>
     
          <div class="mb-4"> </div>
          <button class="btn btn-primary btn-lg btn-block" type="button" id="submitBtn" style="width:85%;">가입 완료</button>
        </form>
      </div>
    </div>
    </div>
    
</body>
</html>