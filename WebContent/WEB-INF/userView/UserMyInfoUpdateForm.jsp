<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserMyInfoUpdateForm.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserMyInfoUpdateForm.css">
<style type="text/css">

  	.err
	{
		margin-left: 10px;
		font-size: 15px;
	}
	
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
		//alert(${user.gender_num});
		
		// 성별 라디오 버튼 설정
		$('input[name="gender"][value="${user.gender_num}"]').prop("checked", true);
		
		// 비밀번호 변경 버튼 클릭 시
		$("#pwdChange").click(function()
		{
			// alert("확인");
			$(location).attr("href", "userpwfindform.action");
			
		});
		
		// 저장 버튼 눌렀을 때 / 변경가능 : 닉네임, 비번, 자기소개, 이메일, 전화번호, 성별, 관심지역 
		$(".submitBtn").click(function()
		{
			
			// 유효성 검사 - 닉네임, 비번, -- 이메일, 전화번호 
			// alert($('input[name="gender"]:checked').val());
			
			// 에러 문구 초기화
			$(".err").css("display", "none");
			$("#nickErr").css("color", "red");
			
			// 공란 검사(생년월일, 프로필이미지, 자기소개 제외)
			if ( $("#id").val()=="" ) 
			{
				$("#nickErr").html("닉네임은 필수 입력사항입니다.").css("display", "inline");
				$("#id").focus();
				return;
			}
			if ( $("#email").val()=="" )
			{
				$("#emailErr").html("이메일은 필수 입력사항입니다.").css("display", "inline");
				$("#email").focus();
				return;
			}
			if ( $("#phone1").val()=="" || $("#phone2").val()=="" || $("#phone3").val()=="")
			{
				$("#telErr").html("전화번호는 필수 입력사항입니다.").css("display", "inline");
				$("#tel").focus();
				return;
			}
			
			
			
			// 유효성 검사
			
			// 이메일 정규식
			var emailTest =/^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/;
			
			// 이메일 유효성 검사 
			if(!emailTest.test($("#email").val()))
			{
				$("#emailErr").html("잘못된 형식의 이메일입니다.").css("display", "inline");
				$("#email").val()=="";
				$("#email").focus();
				return;
			}
			
			// 전화번호 정규식
			var telTest1 = /^01([0|1|6|7|8|9])$/;
			var telTest2 = /^([0-9]{3,4}$)/;
			var telTest3 = /^([0-9]{4})$/;
			
			
			// 전화번호 유효성 검사
			if(!telTest1.test($("#phone1").val()))
			{
				$("#telErr").html("잘못된 형식의 전화번호입니다.").css("display", "inline");
				$("#tel").val()=="";
				$("#tel").focus();
				return;
			}
			if(!telTest2.test($("#phone2").val()))
			{
				$("#telErr").html("잘못된 형식의 전화번호입니다.").css("display", "inline");
				$("#phone2").val()=="";
				$("#phone2").focus();
				return;
			}
			if(!telTest3.test($("#phone3").val()))
			{
				$("#telErr").html("잘못된 형식의 전화번호입니다.").css("display", "inline");
				$("#phone3").val()=="";
				$("#phone3").focus();
				return;
			}
			
			// 닉네임 기존값과 다른 경우 && 에러메시지에 '사용가능합니다' 문구 없는 경우 || 에러메시지 문구 없는 경우
			if( ($("#id").val() != "${user.user_name }" && $("#nickErr").html()!="사용 가능합니다.")
					|| ($("#id").val() != "${user.user_name }" && $("#nickErr").html() == ""))		
			{
				alert("중복 확인 검사가 필요합니다!");
				$("#id").focus();
				return;
			}
			
			$("#submitForm").submit();
			
		});
		
		
		// 취소 버튼 눌렀을 때, 이전페이지(UserMyInfo.jsp)로 이동
		$(".cancelBtn").click(function()
		{
			// alert($("#category2").val());
			$(location).attr("href", "usermyinfo.action");
		});
		
		// 닉네임 중복확인 버튼 클릭 시
		$("#nameCheck").click(function()
		{
			//alert("중복확인!");
			$("#nickErr").css("display", "none");
			$("#nickErr").css("color", "red");
			
			// 공백 입력 시
			if ( $("#id").val()=="" ) 
			{
				$("#nickErr").html("닉네임을 입력해주세요").css("display", "inline");
				$("#id").focus();
				return;
			}
			
			// 닉네임 정규식 - 영문,숫자,한글 조합 10자리이내
			var ninkNameRegExp = /[0-9|a-zA-Z|가-힣]$/gi;
			
			if (!ninkNameRegExp.test($("#id").val())) 
			{
				$("#nickErr").html("닉네임은 영문,숫자,한글 조합만 가능합니다.(10자리이내)").css("display", "inline");
				$("#id").val("");
				$("#id").focus();
				return;
			}
			
			// Ajax - 회원이 입력한 값이 DB상에 존재하는 닉네임인지 확인
			$.post("nicknamecheck.action"
			, {nickname : $("#id").val()}
			,function(data)
			{
				//alert($.trim(data));
				
				if($.trim(data) == 0)	// 사용 가능
				{
					//alert("로그인 실패");
					$("#nickErr").css("color", "green");
					$("#nickErr").html("사용 가능합니다.").css("display", "inline");	
					$("#id").attr("disabled", "disabled");	
					return;
				}
				else				    // 이미 존재
				{
					$("#nickErr").html("이미 사용중인 닉네임입니다.").css("display", "inline");	
					$("#id").val("");
					$("#id").focus();
					return;
				}
			});
			
			
		});
		
		// 회원이 프로필 사진 교체했을 때 미리보기 기능
		$("#uploadFile").on('change', function()
		{
			ext = $(this).val().split('.').pop().toLowerCase();	// 확장자
			
			// 배열에 추출한 확장자가 존재하는지 체크
			if($.inArray(ext, ['png','jpg','jpeg'])== -1)
			{
				//resetFormElement(($this));	// 폼 초기화
				window.alert('이미지 파일이 아닙니다!');
			}
			else
			{
				file = $("#uploadFile").prop("files")[0];
				blobURL = window.URL.createObjectURL(file);
				$("#userImg").attr('src', blobURL);
			}
			
			//alert("이미지 변경");
			// 미리보기 띄워주면서 DB에 사진 업데이트
			var userImg = document.getElementById("userImg").src;
			var fileForm = document.getElementById("fileForm");
			fileForm.submit();
		});
		
		// 사진 삭제 버튼 클릭 시
		$(".delImgBtn").click(function()
		{
			//alert("사진 삭제");
			$(location).attr("href", "userprofiledelete.action");
		});
		
		
	});	
		
		
	// 사진 변경 버튼 눌렀을 때
	function fileUpload()
	{
		// 회원이 올린 사진 파일 이름으로 교체 필요
		//document.getElementById("userImg").src = "./images/123.jpg";
		var fileInput = document.getElementById("uploadFile");
		fileInput.click();
	}
	
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
                <div class="col-12 col-sm-auto mb-3">
                <form action="fileupload.action" id="fileForm" enctype="multipart/form-data" method="post">
                  <div class="mx-auto profileDiv">
                  <c:choose>
	                	<c:when test="${user.user_profile eq null }">
			                <img id="userImg" src="images/150854603.png" alt="pofile_img" 
			                onerror="this.src='images/150854603.png'" class="d-block ui-w-100 rounded-circle">	<!-- 기본 이미지 -->
	                	</c:when>
	                	<c:otherwise>
			                <img id="userImg" src="${user.user_profile }" alt="pofile_img"
			                onerror="this.src='images/150854603.png'"  class="d-block ui-w-100 rounded-circle"> <!-- 회원이 설정한 이미지 -->
	                	</c:otherwise>
                	</c:choose>
                	<input type="file" name="uploadFile" id="uploadFile" accept="image/*" hidden="">	<!-- accept 이미지만 업로드 가능 -->
                    </div>
                    </form>
                  </div>
                </div>
  
                    <div class="mt-10">
                      <button class="btn btn-primary changeBtn" type="button" onclick="fileUpload()">
                        <i class="fa fa-fw fa-camera"></i>
                        <span>사진변경</span>&nbsp;
                      </button>&nbsp;&nbsp;
                      <button class="btn delImgBtn" style="border: 1px solid gray;">사진삭제</button>
                </div>
              </div>
              
          <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="home">
              
              
             <!-- form영역 --> 
             <form action="usermyinfoupdate.action" method="post" id="submitForm">
                 <div class="col-md-7 mb-3 center">
                    <label for="nickname">닉네임(*)</label>
                    <div class="nameInput">
                       <input type="text" class="form-control" id="id" name="id" placeholder="닉네임을 입력해주세요."
                       maxlength="10" value="${user.user_name }" required >
                       <button type="button" class="btn btn-secondary" id="nameCheck" class="checkBtn">중복확인</button>
                    	<input type="hidden" name="nickName_check" value="nickName_check"> 
                    </div>
                    <div><span class="err" id="nickErr" style="color: red; display: none;"></span></div><!-- errMsg -->
            
          <br>       
            <div class="col-md-7 mb-3 center">
                  <label for="password" id="password">비밀번호 변경</label>
                   <button type="button" class="btn btn-secondary" id="pwdChange" class="checkBtn">변경</button>
             </div>
            </div>
           <div class="col-md-7 mb-3 center">
              <label for="nickname">자기소개</label>
              <div class="inputCustom">
              <textarea class="form-control" rows="3" name="intro" placeholder="${user.user_intro }"></textarea>
            </div> 
            </div>
            
              <div class="col-md-7 mb-3 center">
            <label for="email">이메일(*)</label>
              <div class="inputCustom">
            <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요."
            maxlength="30" value="${user.user_email }" required>
             </div>
          </div>
           <div><span class="err" id="emailErr" style="color: red; display: none;"></span></div><!-- errMsg -->
          
            <br>
         
            
            <div class="col-md-7 mb-2 center">
              <label for="telephone">전화번호(*)</label>
             <div class="form-outline mb-4 telInput">
           
            <c:set var="TextValue" value="${user.user_tel }"/>
             	<input id="phone1" type="text" class="form-control form-control-lg" name="phone1"
             	 placeholder="${fn:substring(TextValue,0,3) }" value="${fn:substring(TextValue,0,3) }"> -
             	 
	            <input id="phone2" type="text" class="form-control form-control-lg" name="phone2"
	             placeholder="${fn:substring(TextValue,4,8) }" value="${fn:substring(TextValue,4,8) }"> -
	             
	            <input id="phone3" type="text" class="form-control form-control-lg" name="phone3"
	             placeholder="${fn:substring(TextValue,9,13) }" value="${fn:substring(TextValue,9,13) }">
              </div>
              <div><span class="err" id="telErr" style="color: red; display: none;"></span></div><!-- errMsg -->
              </div>
             
           
           <div class="custom-control custom-checkbox genderinput">
                <label for="gender">성별</label>
                <div class="radio_gender">
                  <input type="radio" name="gender" id="man" value="1" >
                  <label for="man">남자</label>
                  <input type="radio" name="gender" id="woman" value="2" >
                  <label for="woman">여자</label>
                  <input type="radio" name="gender" id="notChecked" value="3" >
                  <label for="notChecked">선택 안함</label>
            </div>  
          </div><br>
          
           
            <div class="col-md-7 mb-3">
              <label for="area">관심 지역</label><br>
              <div class="form-outline mb-3 telInput">
              <select class="custom-select d-block w-100" id="area1" name="area1">
                <option value="0">선택1</option>
                <c:forEach var="region" items="${regionList }">
                	<c:choose>
                		<c:when test="${region.region_name eq fregionList[0].fregion_name }">
		                	<option value="${region.region_num }" selected>${region.region_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${region.region_num }">${region.region_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
                <!-- 
                <option>서울</option>
                <option>인천</option>
                <option>경기</option>
                 -->
              </select>
               <select class="custom-select d-block w-100" id="area2" name="area2">
                <option value="0">선택2</option>
                <c:forEach var="region" items="${regionList }">
                	<c:choose>
                		<c:when test="${region.region_name eq fregionList[1].fregion_name}">
		                	<option value="${region.region_num }" selected>${region.region_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${region.region_num }">${region.region_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
              </select>
               <select class="custom-select d-block w-100" id="area3" name="area3">
                <option value="0">선택3</option>
                <c:forEach var="region" items="${regionList }">
                	<c:choose>
                		<c:when test="${region.region_name eq fregionList[2].fregion_name }">
		                	<option value="${region.region_num }" selected>${region.region_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${region.region_num }">${region.region_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
              </select>
             </div>
            </div>
            
             <div class="col-md-7 mb-3">
              <label for="category">관심 카테고리</label><br>
              <div class="form-outline mb-4 telInput">
              <select class="custom-select d-block w-100" id="category1" name="category1">
                <option value="0">선택1</option>
                <c:forEach var="tcategory" items="${tcategoryList }">
                	<c:choose>
                		<c:when test="${tcategory.tcategory_name eq fcategoryList[0] }">
		                	<option value="${tcategory.tcategory_num }" selected>${tcategory.tcategory_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${tcategory.tcategory_num }">${tcategory.tcategory_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
               
                <!-- 
                <option>힐링</option>
                <option>맛집</option>
                <option>카페</option>
                 -->
              </select>
               <select class="custom-select d-block w-100" id="category2" name="category2">
                <option value="0">선택2</option>
                <c:forEach var="tcategory" items="${tcategoryList }">
                	<c:choose>
                		<c:when test="${tcategory.tcategory_name eq fcategoryList[1] }">
		                	<option value="${tcategory.tcategory_num }" selected>${tcategory.tcategory_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${tcategory.tcategory_num }">${tcategory.tcategory_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
              </select>
               <select class="custom-select d-block w-100" id="category3" name="category3">
                <option value="0">선택3</option>
                <c:forEach var="tcategory" items="${tcategoryList }">
                	<c:choose>
                		<c:when test="${tcategory.tcategory_name eq fcategoryList[2] }">
		                	<option value="${tcategory.tcategory_num }" selected>${tcategory.tcategory_name }</option>
                		</c:when>
                		<c:otherwise>
		                	<option value="${tcategory.tcategory_num }">${tcategory.tcategory_name }</option>
                		</c:otherwise>
                	</c:choose>
                </c:forEach>
              </select>
             </div>
            </div>
       
                    <div class="row">
                      <div class="col d-flex submitBtns"> 
                        <button class="btn btn-lg submitBtn" type="button"
                         style="margin-right: 10px; margin-left: 90px; background-color: #1DB1F8; color: white;">저장</button>
                        <button class="btn btn-lg btn-secondary cancelBtn" type="button"
                        style="">취소</button>
     
                      </div>
                    </div>
                    
         </form>
            <!-- form영역 -->          
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