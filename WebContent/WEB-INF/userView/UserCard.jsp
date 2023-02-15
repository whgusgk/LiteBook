<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	pageContext.setAttribute("replaceWord", "\n");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>UserCard.jsp</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<style>
		input[type="checkbox"] {
		display:none;
		}
		
		body{
		    /*width: 1000px;*/
		
		}
		.label_on-off {
		    top:5px;
		    right:20px;
		    overflow: hidden;
		    position: relative;
		    display: inline-block;
		    width: 81px;
		    height: 34px;
		    -webkit-border-radius: 45px;
		    -moz-border-radius: 45px;
		    border-radius: 45px;
		    background-color: #ed4956 ;
		    color: #fff;
		    font-weight: bold;
		    cursor: pointer;
		    -webkit-transition: all .3s;
		    -moz-transition: all .3s;
		    -ms-transition: all .3s;
		    -o-transition: all .3s;
		    transition: all .3s;
		}
		
		.label_on-off > * {
		    vertical-align: middle;
		    -webkit-transition: all .3s;
		    -moz-transition: all .3s;
		    -ms-transition: all .3s;
		    -o-transition: all .3s;
		    transition: all .3s;
		    font-size: 15px;
		}
		
		.label_on-off .marble {
		    position: absolute;
		    display: block;
		    top:0.5px;
		    left:0.5px;
		    width: 28px;
		    height: 36px;
		    background-color: #fff;
		    -webkit-border-radius: 50%;
		    -moz-border-radius: 50%;
		    border-radius: 50%;
		    -webkit-box-shadow: 0 0 10px rgba(0, 0, 0, .3);
		    -moz-box-shadow: 0 0 10px rgba(0, 0, 0, .3);
		    box-shadow: 0 0 10px rgba(0, 0, 0, .3);
		}
		
		.label_on-off .on {
		    display: none;
		    line-height: 35px;
		    padding-left: 20px;
		}
		
		.label_on-off .off {
		    padding-left: 32px;
		    line-height: 35px;
		}
		
		.input_on-off:checked + .label_on-off {
		    background-color: #0bba82;
		}
		
		.input_on-off:checked + .label_on-off .on {
		    display: inline-block;
		}
		
		.input_on-off:checked + .label_on-off .off {
		    display: none;
		}
		
		.input_on-off:checked + .label_on-off .marble {
		    left: 56px;
		}
		.form-control[readonly]{
			background-color: #fff;
		}
		
		
		.cardBtn{
		    background-color:#8B00FF;
		    color:white;
		    border:transparent;
		    border-radius:3px;
		    font-size: 25px;
		}
		
		.location{
		    display: flex;
		    margin-bottom: 1rem;
		}
		#map{
		    width:100%;
		    height:520px;
		    position:relative;
		}
		#menu{
		   display: block;
		   border-radius: 10px;
		   margin: 10px 0 30px 10px;
		   padding: 1px;
		   text-align: center;
		   width: 350px;
		   height: 500px;
		   background:rgba(255, 255, 255, 0.7);
		   border: 1px solid #ccc;
		}
		.menu hr{
		   margin: 3px 0;
		   border: 1px solid #ccc;
		}
		#searchBtn{
		   border: 0;
		   border-radius: 5px;
		   background-color: #1DB1F8;
		   color: white;
		}
		#keyword{
		   border: thin solid gray;
		   border-radius: 5px;
		}
		#placeList{
			height: 400px;
			padding: 0;
			overflow: auto; 
		}
		#placeList li{
		   list-style: none;
		}
		#placeList .item{
		   border-bottom: 1px solid #E6E6E6;
		}
		.sorry{
			color: #E6E6E6;
		}
		.info h5{
			font-weight: bold;
		}
		.location_search{
		    /* width:100%; */
		    margin-left: 1rem;
		    display: inline;
		}
		.location_detail{
		    width: 100%;
		    height:calc(100% - 34px - 0.5rem);
		    margin-top: 0.5rem;
		    background-color: rgb(209, 209, 209);
		}
		.pay{
		    width:100%;
		}
		.pay_btn{
		    margin-top: 1rem;
		    display: flex;
		    justify-content: space-between;
		}
		.payAdd{
		    background-color: black;
		    color:white;
		}
		.payAdd:hover{
		    background-color: gray;
		}
		.pay_detail{
		    display: flex;
		}
		.pay_delete{
		    margin-left: auto;
		}
		#payKind{
		    width:200px;
		    height:25px;
		}
		
		.input-group-addon{
		    width:70px;
		}
		.input-group{
		    width:100%;
		}
		.input_time_budget{
		    height:34px;
		    padding:0;
		    margin:0;
		    display: flex;
		    justify-content: flex-end;
		}
		.selectDiv{
		    display: flex;
		    width:100%;
		}
		.input_time{
		    width:135px;
		}
		.time{
		    width:50%;
		    border: 1px solid #ccc;
		    padding: 6px 12px;
		}
		.uploadFiles{
		    border:1px solid rgb(187, 183, 183);
		    border-bottom-right-radius: 5px;
		    border-top-right-radius: 5px;
		    padding-left: 2px;
		}
		
		.action{
		    margin-top:2rem;
		    display: flex;
		    justify-content: flex-end;
		}
		.input_photo {
			margin: 5px;
		}
		.updateBtn {
			float: right;
		}
	</style>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7a5a94359b08e09ad7b3d2618c343a44"></script>
   <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script>
      
	    $(function()
	    {
	       container = document.getElementById("map");
	       mapCenter = new kakao.maps.LatLng(${card.card_lat }, ${card.card_lng });
	       options =
	       {
	          center: mapCenter,
	          level: 3,
	       }
	       
	       map = new kakao.maps.Map(container, options);
	       
	       var placePosition = new kakao.maps.LatLng(${card.card_lat }, ${card.card_lng });
	       marker = new kakao.maps.Marker(
   		   {
   		   		position: placePosition,
   		   });

   		   marker.setMap(map);
	       
	       // 마커 위로 띄울 인포 윈도우 생성
	       infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
	       
	       kakao.maps.event.addListener(marker, "click", function()
           {
              // 함수
              displayInfowindow(marker, '${card.card_location}', '${card.place_url}');
              
           });
	       
	       $(".updateBtn").click(function()
		   {
				// alert("확인");
				$(location).attr("href", "usercardupdateform.action?card_num=${card.card_num}")
		   });
	       
	       $("#listBtn").click(function()
			{
				// alert("확인");
				$(location).attr("href", "usernoteupdateform.action?note_num=${note_num}&startdate=${startdate}&lastdate=${lastdate}");
			});
	       
	    });
	     
	    // 인포 윈도우 생성 함수
	    function displayInfowindow(marker, title, url)
	    {
	       var content = "<div style='padding:5px; z-index:1;'><a href='"+ url +"' target='_blank'>" + title + "</a></div>";
	       
	       infowindow.setContent(content);
	       infowindow.open(map, marker);
	    }
	
  </script>
</head>
<body class="Site">
<div class="Site-content" id="wrap">
	<!-- Header (import) -->
	<div class="import">
		<c:import url="UserMenu.jsp"></c:import>
	</div><!-- import -->   

	<!-- Section (card_container) -->
<div style="width:60%; margin:auto;">

<div class="btnArea">
    <h2>여행 카드</h2>
	<button type='button' class='btn btn-default control updateBtn' value="${card.card_num }">수정</button>
</div>

<div class="card">


    <div class="location">
    
        <div id="map">
        
        </div><!-- map -->
     
	</div><!-- location -->

	<!--
	 <div class="location_search">
	     <div class="input-group">
	         <div class="input-group-addon">
	             <span class="glyphicon glyphicon-search searchIcon" id="searchIcon"></span>
	         </div>
	         <input type="text" id="startDay" name="startDay" class="form-control" placeholder="장소검색"/>
	     </div>
	     <div class="location_detail">검색한 장소에 해당하는 장소가 나올 영역</div>
	 </div>
	-->

</div>

<div class="info">
	
    <div class="input-group input_place">
        <div class="input-group-addon">장소명</div>
        <input type="text" id="place" name="place" class="form-control" value="${card.card_location }" readonly>
    </div>
    
    <div class="input-group input_time_budget">
        <div class="input-group-addon input_time">시간</div>
        <div class="selectDiv">
        	<input id="hour" class="time" value="${fn:substring(card.card_time, 0, 2) }" readonly> :
        	<input id="minute" class="time" value="${fn:substring(card.card_time, 2, 4) }" readonly>
        </div>
        <div class="input-group-addon input_budget">예산</div>
        <input type="text" id="budget" name="budget" class="form-control" value="${card.card_budget }" readonly>
    </div>   
    <div class="input-group input_memo">
        <div class="input-group-addon">메모</div>
        <textarea rows="5" cols="111" id="memo" name="memo" class="form-control" readonly>${fn:replace(card.card_comment, replaceWord, '<br>') }</textarea>
        <!-- 메모부분 수정 필요 -->
    </div>

	<div class="input_photo">
		<h4><b>사진</b></h4>
		<div class="uploadFiles">
		    <div class="image" id="img1">
		    	<c:if test="${card.card_img1 ne '' }">
		    		<img alt="img1" src="${card.card_img1 }">
		    	</c:if>
		    </div>
		    <div class="image" id="img2">
		    	<c:if test="${card.card_img2 ne '' }">
		    		<img alt="img2" src="${card.card_img2 }">
		    	</c:if>
		    </div>
		    <div class="image" id="img3">
				<c:if test="${card.card_img3 ne '' }">
		    		<img alt="img3" src="${card.card_img3 }">
		    	</c:if>
		    </div>
		</div>
    </div>

    <div class="input-group input_pay" id="pay">
        <div class="pay_btn">
            <h4><b>지출 내역</b></h4>
        </div>
        
        <div class="pays" id="pays">
        	<c:forEach var="pay" items="${pays }">
		        <div class="pay_detail">
					<div class="pay_name">
						<input type='text' class='payName' id='payName' name='payName' value="${pay.pay_name }" readonly>
					</div>
					<div class="pay_kind">
						<input type="text" class="ptypeName" id="ptypeName" name="ptypeName" value="${pay.ptype_name }" readonly>
					</div>
					<div class="pay_amount">
						<input type="text" class="payAmount" id="payAmount" name="payAmount" value="${pay.pay_amount }" readonly>
					</div>
		    	</div>
	    	</c:forEach>
	</div><!-- pay -->
	
    <div class="action">
        <input type="checkbox" id="switch" name="switch" class="input_on-off" checked="checked" value="1" disabled>
        <label for="switch" class="label_on-off">
            <span class="marble"></span>
            <span class="on">공개</span>
            <span class="off">비공개</span>
        </label>
        <button type="button" class="btn btn-primary control confirmBtn" id="listBtn">목록으로</button>
    </div>
	
    	<br><br><br>
</div><!-- info -->

</div><!-- Site-content -->
</div>
</div>
<!-- footer -->
<c:import url="UserFooter.jsp"></c:import>
<!-- footer -->



</body>
</html>