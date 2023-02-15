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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>UserScrapCardUpdateForm.jsp</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<style>
		input[type="checkbox"] {
		display:none;
		}
		
		body{
		
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
	</style>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7a5a94359b08e09ad7b3d2618c343a44"></script>
   <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script>

   
		$(document).on("click", ".payDeleteBtn", function()
		{
			var idx = $('.payDeleteBtn').index(this);
			$('.pay_detail').eq(idx).remove();
		});
   
	    $(function()
	    {
	       container = document.getElementById("map");
	       mapCenter = new kakao.maps.LatLng(${card.card_lat}, ${card.card_lng});
	       options =
	       {
	          center: mapCenter,
	          level: 3,
	       }
	       
	       map = new kakao.maps.Map(container, options);
	       
	       
	       
	       // 마커들을 담을 배열 생성 (다음 검색 결과를 위해 한 번에 지울 때 사용)
	       markers = [];
	       
	       var placePosition = new kakao.maps.LatLng(${card.card_lat }, ${card.card_lng });
			marker = new kakao.maps.Marker(
			{
				position: placePosition,
			});
			
			marker.setMap(map);
			
			kakao.maps.event.addListener(marker, "click", function()
		   {
		      // 함수
		      displayInfowindow(marker, '${card.card_location}', '${card.place_url}');
		      
		   });
	       
	       // 마커 위로 띄울 인포 윈도우 생성
	       infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
	       
			// 예산 추가 버튼 클릭 시
			$(".payAdd").click(function()
			{
				// alert("확인");
				
				// <></> 생성
				var fragment = document.createDocumentFragment();
				
				// div 엘리먼트 생성 및 클래스명 설정
				var divDetailEl = document.createElement("div");
				var divNameEl = document.createElement("div");
				var divKindEl = document.createElement("div");
				var divAmountEl = document.createElement("div");
				var divDeleteEl = document.createElement("div");
				
				divDetailEl.className = "pay_detail";
				divNameEl.className = "pay_name";
				divNameEl.className = "pay_kind";
				divAmountEl.className = "pay_amount";
				divDeleteEl.className = "pay_delete";
				
				// div 영역 안에 들어갈 구문 구성
				var inputName = "<input type='text' class='payName' id='payName' name='payName' placeholder='지출명'></div>";
				var select = "<select name='payKind' id='payKind'>";
					select += "<option value='1'>카드</option>";
					select += "<option value='2'>현금</option>";
					select += "<option value='3'>기타</option>";
					select += "</select>";
				var inputAmount = "<input type='text' class='payAmount' id='payAmount' name='payAmount' placeholder='지출금액' value='0'>";
				var button = "<button type='button' class='btn btn-default control payDeleteBtn' onclick='deletePayBtn()'>삭제</button>";
				
				// 구성한 내용을 div 엘리먼트 안에 배치
				divNameEl.innerHTML = inputName;
				divKindEl.innerHTML = select;
				divAmountEl.innerHTML = inputAmount;
				divDeleteEl.innerHTML = button;
				
				// 가장 바깥쪽 div 엘리먼트에 세부 엘리먼트 배치
				divDetailEl.appendChild(divNameEl);
				divDetailEl.appendChild(divKindEl);
				divDetailEl.appendChild(divAmountEl);
				divDetailEl.appendChild(divDeleteEl);
				
				// <></> 안에 div 엘리먼트 배치
				fragment.appendChild(divDetailEl);
				
				// pay 영역에 배치
				var pay = document.getElementById("pays");
				pay.appendChild(fragment);
				
			});
			
			 $("#confirmBtn").click(function()
       		{
       			// alert("확인");
       			if ($("#place").val()=="")
				{
					alert("장소를 선택해주세요.");
					$("#keyword").focus();
					return;
				}
				
       			if ($(".payAmount").val()=="")
				{
					alert("지출내역을 입력해주세요.");
					return;
				}
       			
       			if ($(".payAmount").length > 0)
				{
					$("#cardForm").attr("action", "usercardpayinsert.action");
	       			$("#cardForm").submit();
				}
       			else
       			{
					$("#cardForm").attr("action", "usercardinsert.action");
	       			$("#cardForm").submit();
				}
       			
       			
       		});
			 
	       
	    });
     	
	    /* 지출내역 삭제 함수 / $(document)로 이동
	    function deletePayBtn()
		{
	    	// 삭제 버튼이 속한 영역의 인덱스 값
	    	var idx = $(".payDeleteBtn").index(this);
	    	
	    	// 해당 인덱스와 같은 위치에 있는 div 삭제
			$(".pay_detail").eq(idx).remove(); 	
	    	
		}
	    */
	    
		function searchPlaces(page)
	    {
	        // alert($("#keyword").val());
	        
	        $.ajax(
	        {
	           type : "GET"
	           , url : "//dapi.kakao.com/v2/local/search/keyword?query=" + encodeURIComponent($("#keyword").val()) + "&page=" + page
	           , headers : {"Authorization" : "KakaoAK 7a5a94359b08e09ad7b3d2618c343a44"}
	           , success : function(places)
	            {
					// console.log(places);
					
					// var places = JSON.parse(places);
					// places가 이미 Json object이기 때문에 String을 객체로 변환할 때 사용하는 JSON.parse()는 가용하지 않다.
	              
					// console.log(places[0].place_name);
					// console.log(places.documents[0].place_name);
					// Json 객체 구조 안에서 장소 정보를 가지고 있는 배열의 이름이 documents이므로 접근 필요
	              
					// $("#place").val(places.documents[0].place_name);
	              
					// 리스트에 표시해주는 작업 필요
					if (places.documents[0]==null)
					{
						// alert("검색 결과가 없습니다");
						var placeListEl = document.getElementById("placeList");
						
						placeListEl.innerHTML = "<span class='sorry'>검색 결과가 없습니다.</span>";
						
					}
					else
					{
						// 검색 결과를 목록과 마커로 표시
						displayPlaces(places);
						// 페이징 처리
						displayPagination(places);
						
					}
	              
	          }
	           , beforeSend : searchCheck
	           , error : function(e)
	          {
	             // alert(e.responseText);
	             console.log(e);
	          }
	           
	        });
	        
	    }
	     
	     // 장소 검색 시 공란 확인 함수
	     function searchCheck()
	    {
	        var keyword = $("#keyword").val();
	        
	        if (!$.trim(keyword))
	       {
	          alert("키워드를 입력해주세요!");
	          $("#keyword").focus();
	          return false;
	       }
	        
	    }
	     
	     // 검색 결과를 목록과 마커로 표시하는 함수
	     function displayPlaces(places)
	    {
	        // 검색결과를 표시할 영역의 주소
	        var listEl = document.getElementById("placeList");
	
	        // 생성한 검색 결과 엘리먼트를 담아낼 <></> 생성
	        // createDocumentFragment() : 다른 노드를 담을 수 있는 임시 컨테이너 (가상 노드)
	        fragment = document.createDocumentFragment();
	
	        // 목록을 만든 후 스크롤바 설정을 위해 객체 지정
	        menuEl = $("#menu");
	
	        // 지도의 범위를 선택한 장소로 이동시키기 위한 객체
	        // -- LatLngBounds(sw, ne) : 북동쪽 좌표와 남서쪽 좌표 정보를 넘겨 화면의 범위를 결정
	        bounds = new kakao.maps.LatLngBounds();
	
	        // 검색된 목록을 담을 문자열
	        var listStr = "";
	
	        // 기존 검색으로 존재했던 항목 삭제 (함수)
	        removeAllChildNods(listEl);
	
	        // 기존에 존재하던 지도 마커 삭제 (함수)
	        removeMarker();
	
	        // JSON으로 얻어온 객체의 결과를 화면 내에 표시할 수 있도록 반복문
	        for (var i=0; i<places.documents.length; i++)
	        {
	           // 마커를 생성하고 지도에 표시
	           var placePosition = new kakao.maps.LatLng(places.documents[i].y, places.documents[i].x);
	           marker = addMarker(placePosition);
	
	           // 검색 결과 항목용 element 생성 (함수)
	           itemEl = getListItem(i, places.documents[i]);
	
	           // 검색 결과에 따라 지도 범위 재설정
	           // LatLngBounds에 좌표 값을 대입하여 위치 지정
	           // -- extend() : 받은 좌표 값이 기존의 범위 밖에 있을 때 포함하여 범위 확장
	           bounds.extend(placePosition);
	
	           // 검색 결과 항목 및 마커를 클릭했을 때 인포윈도우로 장소명 및 장소 정보 표기
	           // -- 즉시 실행 함수 표현식 : 뒤쪽 괄호 안에 들어간 값들이 매개변수로 대입
	           (function(marker, place)
	           {
	              // 마커 클릭하면
	              kakao.maps.event.addListener(marker, "click", function()
	              {
	                 // 함수
	                 displayInfowindow(marker, place.place_name, place.place_url);
	                 
					var thisLatLng = new kakao.maps.LatLng(place.y, place.x);
	                 
	                 map.panTo(thisLatLng);
	                 $("#place").val(place.place_name);
	                 $("#lat").val(place.y.substr(0, 9));
	                 $("#lng").val(place.x.substr(0, 9));
	                 $("#address").val(place.road_address_name);
	                 $("#place_url").val(place.place_url);
	                 
	              });
	
	              // 지도의 빈 곳을 클릭하면
	              kakao.maps.event.addListener(map, "click", function()
	              {
	                 infowindow.close();
	              });
	              
	              // 검색 결과 목록에서 특정 상호를 클릭하면
	              itemEl.addEventListener("click", function() 
	              {
	            	 displayInfowindow(marker, place.place_name, place.place_url);
	                 
	            	 var thisLatLng = new kakao.maps.LatLng(place.y, place.x);
	            	 
	                 map.panTo(thisLatLng);
	                 $("#place").val(place.place_name);
	                 $("#lat").val(place.y.substr(0, 9));
	                 $("#lng").val(place.x.substr(0, 9));
	                 $("#address").val(place.road_address_name);
	                 $("#place_url").val(place.place_url);
	                 
	              });
	
	           })(marker, places.documents[i]);
	           
	           // 노드 컨테이너에 담는다
	           fragment.appendChild(itemEl);
	        }
	
	        // 검색 결과 항목들을 검색하고 목록이 위치할 공간에 추가
	        listEl.appendChild(fragment);
	        menuEl.scrollTop = 0;
	
	        // 검색된 장소 위치를 기준으로 설정한 지도 범위 셋업
	        map.setBounds(bounds);
	    }
	    
	    // 페이징 처리 함수
	    function displayPagination(places)
		{
	    	// 페이징 처리 영역 주소
	    	var paginationEl = document.getElementById("pagination");
	
	    	// <></> 객체 생성
	    	var fragment = document.createDocumentFragment();
	
	    	// 기존의 페이징 번호 삭제
	    	while(paginationEl.hasChildNodes())
	    	{
	    		// 뒤에서부터 페이징 구문을 지운다
	    		paginationEl.removeChild (paginationEl.lastChild);
	    	}
	
	    	for (var i = 1; i < 4; i++)
	    	{
	    		var el = document.createElement("a");
		  	
	    		// pagination 객체(api 제공) 내의 메소드 사용 예정
	    		// 별도의 설정 필요 X
	    		el.href = "#";
	
	    		// 페이징 번호
	    		el.innerHTML = i;
	
	    		// 즉시 실행 함수
	    		(function(i)
				{
	    			// 링크가 클릭됐다면 실행할 이벤트 리스너 등록
	    			el.addEventListener("click", function()
   					{
   						// alert(i);
   						searchPlaces(i);
   						infowindow.close();
   						
   					});
	    			
				})(i);
				
	    		// 만들어놓은 객체에 페이징 처리 링크 담아내기
	    		fragment.appendChild(el);
	    	 }
	
	    	// 페이징 처리 영역 주소 안에 노드 삽입
	    	paginationEl.appendChild(fragment);
	
		}
	    
		// 장소 전달용 문자열 구성 함수
	    function getListItem(index, place)
	    {
	        // 리스트 엘리먼트 생성 <li></li>
	        // jQuery 쓰는 방법은 모르겠음...
	        var el = document.createElement("li");
	
	        // 정보 담을 문자열 구성
	        itemStr = "<span>" + (index+1) + "</span>"
	              + "<div class='info'>"
	                 + "<h5>" + place.place_name + "</h5>"
	                 + "<span>" + place.road_address_name + "</span><br>"
	                 + "<span>" + place.phone + "</span>"
	              + "</div>";
	
	        // 생성해 둔 리스트 엘리먼트에 문자열 추가
	        el.innerHTML = itemStr;
	
	        // 리스트 엘리먼트에 className set
	        // el.attr("class", "item");
	        // 왜 일케 안 되지...
	        el.className = "item";
	
	        return el;
	    }
	     
	     // 마커 생성하고 배치하는 함수 : 이미지 조정 필요
	     function addMarker(position)
	    {
	        // 마커 생성하고 위치 지정
	        marker = new kakao.maps.Marker(
	       {
	          position: position
	       });
	
	       // 지도 위에 마커를 표시
	       marker.setMap(map);
	
	       // 배열에 생성된 마커를 추가
	       markers.push(marker);
	
	        return marker;
	    }
	     
	    // 지도 위에 표시되고 있는 마커 모두 제거
	    function removeMarker()
	    {
	       for (var i = 0; i < markers.length; i++)
	       {
	          markers[i].setMap(null);
	       }
	       
	       markers = [];
	    }
	    
	    // 인포 윈도우 생성 함수
	    function displayInfowindow(marker, title, url)
	    {
	       var content = "<div style='padding:5px; z-index:1;'><a href='"+ url +"' target='_blank'>" + title + "</a></div>";
	       
	       infowindow.setContent(content);
	       infowindow.open(map, marker);
	    }
	
	    // 검색 결과 목록에서 자식 Element 제거 함수
	    function removeAllChildNods(el)
	    {
	       // el(목록 객체를 담아둔 변수)에 childnode가 있다면
	       while (el.hasChildNodes())
	       {
	          // 뒤에서부터 차례로 삭제
	          el.removeChild(el.lastChild);
	       }
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
    <h2>
        여행 카드
    </h2>
</div>

<div class="card">


    <div class="location">
    
        <div id="map">
        
        </div><!-- map -->
     
	     <div id="menu">
	     
		<div class="location_search">
		            <form onsubmit="searchPlaces(1); return false;">
		      <input type="text" id="keyword" placeholder="어디로 떠나볼까요?">
		      <button type="submit" id="searchBtn">검색</button>
		   </form>
		</div> <!-- location_search -->
		   <hr />
		   
		   <ul id="placeList"></ul>
		   <div id="pagination"></div>
		   
		</div> <!-- menu -->
		
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
	
	<form action="" method="post" id="cardForm" name="cardForm" enctype="multipart/form-data">
    <div class="input-group input_place">
        <div class="input-group-addon">장소명</div>
        <input type="text" id="place" name="place" class="form-control" placeholder="장소를 선택해 주세요." readonly="readonly"
        value="${card.card_location }">
        
        <div id="hidden">
        	<!-- 위도y -->
        	<input type="hidden" id="lat" name="lat" value="${card.card_lat }">
        	<!-- 경도x -->
        	<input type="hidden" id="lng" name="lng" value="${card.card_lng }">
        	
        	<input type="hidden" id="address" name="address" value="${card.card_address }">
        	<input type="hidden" id="day" name="day" value="${day }">
        	<input type="hidden" id="note_num" name="note_num" value="${note_num }">
        	<input type="hidden" id="place_url" name="place_url" value="${card.place_url }">
        </div>
        
    </div>  
    <div class="input-group input_time_budget">
        <div class="input-group-addon input_time">시간</div>
        <div class="selectDiv">
            <select name="hour" id="hour" class="time">
                <option value="">시간</option>
                <option value="01">1시</option>
                <option value="02">2시</option>
                <option value="03">3시</option>
                <option value="04">4시</option>
                <option value="05">5시</option>
                <option value="06">6시</option>
                <option value="07">7시</option>
                <option value="08">8시</option>
                <option value="09">9시</option>
                <option value="10">10시</option>
                <option value="11">11시</option>
                <option value="12">12시</option>
                <option value="13">13시</option>
                <option value="14">14시</option>
                <option value="15">15시</option>
                <option value="16">16시</option>
                <option value="17">17시</option>
                <option value="18">18시</option>
                <option value="19">19시</option>
                <option value="20">20시</option>
                <option value="21">21시</option>
                <option value="22">22시</option>
                <option value="23">23시</option>
                <option value="24">24시</option>
            </select>
            <select name="minute" id="minute" class="time">
                <option value="">분</option>
                <option value="00">00분</option> 
                <option value="10">10분</option>
                <option value="20">20분</option>
                <option value="30">30분</option>
                <option value="40">40분</option>
                <option value="50">50분</option>
            </select>
        </div>
        <div class="input-group-addon input_budget">예산</div>
        <input type="text" id="budget" name="budget" class="form-control" placeholder="예산을 입력해 주세요."
        value="${card.card_budget  }">
    </div>   
    <div class="input-group input_memo">
        <div class="input-group-addon">메모</div>
        <textarea rows="5" cols="111" id="memo" name="memo" class="form-control" placeholder="내용을 입력해주세요."></textarea>
        <!-- 메모부분 수정 필요 -->
    </div>

	<div class="input_photo">
		<h4><b>사진</b></h4>
		<div class="uploadFiles">
		    <input type="file" name="uploadFile1" >
		    <input type="file" name="uploadFile2" >   
		    <input type="file" name="uploadFile3" >
		</div>
    </div>

    <div class="input-group input_pay" id="pay">
        <div class="pay_btn">
            <h4><b>지출 내역</b></h4>
            <button type="button" class="btn btn-default control payAdd">추가</button>
        </div>
        
        <div class="pays" id="pays">
    	</div>
	</div><!-- pay -->
	
    <div class="action">
        <input type="checkbox" id="switch" name="switch" class="input_on-off" checked="checked" value="1">
        <label for="switch" class="label_on-off">
            <span class="marble"></span>
            <span class="on">공개</span>
            <span class="off">비공개</span>
        </label>
        <button type="button" class="btn btn-primary control confirmBtn" id="confirmBtn">확인</button>
    </div>
    </form>

        <br><br><br>
</div><!-- info -->

</div><!-- Site-content -->
</div>
<!-- footer -->
<c:import url="UserFooter.jsp"></c:import>
<!-- footer -->



</body>
</html>