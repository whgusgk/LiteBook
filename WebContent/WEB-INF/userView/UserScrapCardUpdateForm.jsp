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
	       
	       
	       
	       // ???????????? ?????? ?????? ?????? (?????? ?????? ????????? ?????? ??? ?????? ?????? ??? ??????)
	       markers = [];
	       
	       var placePosition = new kakao.maps.LatLng(${card.card_lat }, ${card.card_lng });
			marker = new kakao.maps.Marker(
			{
				position: placePosition,
			});
			
			marker.setMap(map);
			
			kakao.maps.event.addListener(marker, "click", function()
		   {
		      // ??????
		      displayInfowindow(marker, '${card.card_location}', '${card.place_url}');
		      
		   });
	       
	       // ?????? ?????? ?????? ?????? ????????? ??????
	       infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
	       
			// ?????? ?????? ?????? ?????? ???
			$(".payAdd").click(function()
			{
				// alert("??????");
				
				// <></> ??????
				var fragment = document.createDocumentFragment();
				
				// div ???????????? ?????? ??? ???????????? ??????
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
				
				// div ?????? ?????? ????????? ?????? ??????
				var inputName = "<input type='text' class='payName' id='payName' name='payName' placeholder='?????????'></div>";
				var select = "<select name='payKind' id='payKind'>";
					select += "<option value='1'>??????</option>";
					select += "<option value='2'>??????</option>";
					select += "<option value='3'>??????</option>";
					select += "</select>";
				var inputAmount = "<input type='text' class='payAmount' id='payAmount' name='payAmount' placeholder='????????????' value='0'>";
				var button = "<button type='button' class='btn btn-default control payDeleteBtn' onclick='deletePayBtn()'>??????</button>";
				
				// ????????? ????????? div ???????????? ?????? ??????
				divNameEl.innerHTML = inputName;
				divKindEl.innerHTML = select;
				divAmountEl.innerHTML = inputAmount;
				divDeleteEl.innerHTML = button;
				
				// ?????? ????????? div ??????????????? ?????? ???????????? ??????
				divDetailEl.appendChild(divNameEl);
				divDetailEl.appendChild(divKindEl);
				divDetailEl.appendChild(divAmountEl);
				divDetailEl.appendChild(divDeleteEl);
				
				// <></> ?????? div ???????????? ??????
				fragment.appendChild(divDetailEl);
				
				// pay ????????? ??????
				var pay = document.getElementById("pays");
				pay.appendChild(fragment);
				
			});
			
			 $("#confirmBtn").click(function()
       		{
       			// alert("??????");
       			if ($("#place").val()=="")
				{
					alert("????????? ??????????????????.");
					$("#keyword").focus();
					return;
				}
				
       			if ($(".payAmount").val()=="")
				{
					alert("??????????????? ??????????????????.");
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
     	
	    /* ???????????? ?????? ?????? / $(document)??? ??????
	    function deletePayBtn()
		{
	    	// ?????? ????????? ?????? ????????? ????????? ???
	    	var idx = $(".payDeleteBtn").index(this);
	    	
	    	// ?????? ???????????? ?????? ????????? ?????? div ??????
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
					// places??? ?????? Json object?????? ????????? String??? ????????? ????????? ??? ???????????? JSON.parse()??? ???????????? ??????.
	              
					// console.log(places[0].place_name);
					// console.log(places.documents[0].place_name);
					// Json ?????? ?????? ????????? ?????? ????????? ????????? ?????? ????????? ????????? documents????????? ?????? ??????
	              
					// $("#place").val(places.documents[0].place_name);
	              
					// ???????????? ??????????????? ?????? ??????
					if (places.documents[0]==null)
					{
						// alert("?????? ????????? ????????????");
						var placeListEl = document.getElementById("placeList");
						
						placeListEl.innerHTML = "<span class='sorry'>?????? ????????? ????????????.</span>";
						
					}
					else
					{
						// ?????? ????????? ????????? ????????? ??????
						displayPlaces(places);
						// ????????? ??????
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
	     
	     // ?????? ?????? ??? ?????? ?????? ??????
	     function searchCheck()
	    {
	        var keyword = $("#keyword").val();
	        
	        if (!$.trim(keyword))
	       {
	          alert("???????????? ??????????????????!");
	          $("#keyword").focus();
	          return false;
	       }
	        
	    }
	     
	     // ?????? ????????? ????????? ????????? ???????????? ??????
	     function displayPlaces(places)
	    {
	        // ??????????????? ????????? ????????? ??????
	        var listEl = document.getElementById("placeList");
	
	        // ????????? ?????? ?????? ??????????????? ????????? <></> ??????
	        // createDocumentFragment() : ?????? ????????? ?????? ??? ?????? ?????? ???????????? (?????? ??????)
	        fragment = document.createDocumentFragment();
	
	        // ????????? ?????? ??? ???????????? ????????? ?????? ?????? ??????
	        menuEl = $("#menu");
	
	        // ????????? ????????? ????????? ????????? ??????????????? ?????? ??????
	        // -- LatLngBounds(sw, ne) : ????????? ????????? ????????? ?????? ????????? ?????? ????????? ????????? ??????
	        bounds = new kakao.maps.LatLngBounds();
	
	        // ????????? ????????? ?????? ?????????
	        var listStr = "";
	
	        // ?????? ???????????? ???????????? ?????? ?????? (??????)
	        removeAllChildNods(listEl);
	
	        // ????????? ???????????? ?????? ?????? ?????? (??????)
	        removeMarker();
	
	        // JSON?????? ????????? ????????? ????????? ?????? ?????? ????????? ??? ????????? ?????????
	        for (var i=0; i<places.documents.length; i++)
	        {
	           // ????????? ???????????? ????????? ??????
	           var placePosition = new kakao.maps.LatLng(places.documents[i].y, places.documents[i].x);
	           marker = addMarker(placePosition);
	
	           // ?????? ?????? ????????? element ?????? (??????)
	           itemEl = getListItem(i, places.documents[i]);
	
	           // ?????? ????????? ?????? ?????? ?????? ?????????
	           // LatLngBounds??? ?????? ?????? ???????????? ?????? ??????
	           // -- extend() : ?????? ?????? ?????? ????????? ?????? ?????? ?????? ??? ???????????? ?????? ??????
	           bounds.extend(placePosition);
	
	           // ?????? ?????? ?????? ??? ????????? ???????????? ??? ?????????????????? ????????? ??? ?????? ?????? ??????
	           // -- ?????? ?????? ?????? ????????? : ?????? ?????? ?????? ????????? ????????? ??????????????? ??????
	           (function(marker, place)
	           {
	              // ?????? ????????????
	              kakao.maps.event.addListener(marker, "click", function()
	              {
	                 // ??????
	                 displayInfowindow(marker, place.place_name, place.place_url);
	                 
					var thisLatLng = new kakao.maps.LatLng(place.y, place.x);
	                 
	                 map.panTo(thisLatLng);
	                 $("#place").val(place.place_name);
	                 $("#lat").val(place.y.substr(0, 9));
	                 $("#lng").val(place.x.substr(0, 9));
	                 $("#address").val(place.road_address_name);
	                 $("#place_url").val(place.place_url);
	                 
	              });
	
	              // ????????? ??? ?????? ????????????
	              kakao.maps.event.addListener(map, "click", function()
	              {
	                 infowindow.close();
	              });
	              
	              // ?????? ?????? ???????????? ?????? ????????? ????????????
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
	           
	           // ?????? ??????????????? ?????????
	           fragment.appendChild(itemEl);
	        }
	
	        // ?????? ?????? ???????????? ???????????? ????????? ????????? ????????? ??????
	        listEl.appendChild(fragment);
	        menuEl.scrollTop = 0;
	
	        // ????????? ?????? ????????? ???????????? ????????? ?????? ?????? ??????
	        map.setBounds(bounds);
	    }
	    
	    // ????????? ?????? ??????
	    function displayPagination(places)
		{
	    	// ????????? ?????? ?????? ??????
	    	var paginationEl = document.getElementById("pagination");
	
	    	// <></> ?????? ??????
	    	var fragment = document.createDocumentFragment();
	
	    	// ????????? ????????? ?????? ??????
	    	while(paginationEl.hasChildNodes())
	    	{
	    		// ??????????????? ????????? ????????? ?????????
	    		paginationEl.removeChild (paginationEl.lastChild);
	    	}
	
	    	for (var i = 1; i < 4; i++)
	    	{
	    		var el = document.createElement("a");
		  	
	    		// pagination ??????(api ??????) ?????? ????????? ?????? ??????
	    		// ????????? ?????? ?????? X
	    		el.href = "#";
	
	    		// ????????? ??????
	    		el.innerHTML = i;
	
	    		// ?????? ?????? ??????
	    		(function(i)
				{
	    			// ????????? ??????????????? ????????? ????????? ????????? ??????
	    			el.addEventListener("click", function()
   					{
   						// alert(i);
   						searchPlaces(i);
   						infowindow.close();
   						
   					});
	    			
				})(i);
				
	    		// ??????????????? ????????? ????????? ?????? ?????? ????????????
	    		fragment.appendChild(el);
	    	 }
	
	    	// ????????? ?????? ?????? ?????? ?????? ?????? ??????
	    	paginationEl.appendChild(fragment);
	
		}
	    
		// ?????? ????????? ????????? ?????? ??????
	    function getListItem(index, place)
	    {
	        // ????????? ???????????? ?????? <li></li>
	        // jQuery ?????? ????????? ????????????...
	        var el = document.createElement("li");
	
	        // ?????? ?????? ????????? ??????
	        itemStr = "<span>" + (index+1) + "</span>"
	              + "<div class='info'>"
	                 + "<h5>" + place.place_name + "</h5>"
	                 + "<span>" + place.road_address_name + "</span><br>"
	                 + "<span>" + place.phone + "</span>"
	              + "</div>";
	
	        // ????????? ??? ????????? ??????????????? ????????? ??????
	        el.innerHTML = itemStr;
	
	        // ????????? ??????????????? className set
	        // el.attr("class", "item");
	        // ??? ?????? ??? ??????...
	        el.className = "item";
	
	        return el;
	    }
	     
	     // ?????? ???????????? ???????????? ?????? : ????????? ?????? ??????
	     function addMarker(position)
	    {
	        // ?????? ???????????? ?????? ??????
	        marker = new kakao.maps.Marker(
	       {
	          position: position
	       });
	
	       // ?????? ?????? ????????? ??????
	       marker.setMap(map);
	
	       // ????????? ????????? ????????? ??????
	       markers.push(marker);
	
	        return marker;
	    }
	     
	    // ?????? ?????? ???????????? ?????? ?????? ?????? ??????
	    function removeMarker()
	    {
	       for (var i = 0; i < markers.length; i++)
	       {
	          markers[i].setMap(null);
	       }
	       
	       markers = [];
	    }
	    
	    // ?????? ????????? ?????? ??????
	    function displayInfowindow(marker, title, url)
	    {
	       var content = "<div style='padding:5px; z-index:1;'><a href='"+ url +"' target='_blank'>" + title + "</a></div>";
	       
	       infowindow.setContent(content);
	       infowindow.open(map, marker);
	    }
	
	    // ?????? ?????? ???????????? ?????? Element ?????? ??????
	    function removeAllChildNods(el)
	    {
	       // el(?????? ????????? ????????? ??????)??? childnode??? ?????????
	       while (el.hasChildNodes())
	       {
	          // ??????????????? ????????? ??????
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
        ?????? ??????
    </h2>
</div>

<div class="card">


    <div class="location">
    
        <div id="map">
        
        </div><!-- map -->
     
	     <div id="menu">
	     
		<div class="location_search">
		            <form onsubmit="searchPlaces(1); return false;">
		      <input type="text" id="keyword" placeholder="????????? ????????????????">
		      <button type="submit" id="searchBtn">??????</button>
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
	         <input type="text" id="startDay" name="startDay" class="form-control" placeholder="????????????"/>
	     </div>
	     <div class="location_detail">????????? ????????? ???????????? ????????? ?????? ??????</div>
	 </div>
	-->

</div>

<div class="info">
	
	<form action="" method="post" id="cardForm" name="cardForm" enctype="multipart/form-data">
    <div class="input-group input_place">
        <div class="input-group-addon">?????????</div>
        <input type="text" id="place" name="place" class="form-control" placeholder="????????? ????????? ?????????." readonly="readonly"
        value="${card.card_location }">
        
        <div id="hidden">
        	<!-- ??????y -->
        	<input type="hidden" id="lat" name="lat" value="${card.card_lat }">
        	<!-- ??????x -->
        	<input type="hidden" id="lng" name="lng" value="${card.card_lng }">
        	
        	<input type="hidden" id="address" name="address" value="${card.card_address }">
        	<input type="hidden" id="day" name="day" value="${day }">
        	<input type="hidden" id="note_num" name="note_num" value="${note_num }">
        	<input type="hidden" id="place_url" name="place_url" value="${card.place_url }">
        </div>
        
    </div>  
    <div class="input-group input_time_budget">
        <div class="input-group-addon input_time">??????</div>
        <div class="selectDiv">
            <select name="hour" id="hour" class="time">
                <option value="">??????</option>
                <option value="01">1???</option>
                <option value="02">2???</option>
                <option value="03">3???</option>
                <option value="04">4???</option>
                <option value="05">5???</option>
                <option value="06">6???</option>
                <option value="07">7???</option>
                <option value="08">8???</option>
                <option value="09">9???</option>
                <option value="10">10???</option>
                <option value="11">11???</option>
                <option value="12">12???</option>
                <option value="13">13???</option>
                <option value="14">14???</option>
                <option value="15">15???</option>
                <option value="16">16???</option>
                <option value="17">17???</option>
                <option value="18">18???</option>
                <option value="19">19???</option>
                <option value="20">20???</option>
                <option value="21">21???</option>
                <option value="22">22???</option>
                <option value="23">23???</option>
                <option value="24">24???</option>
            </select>
            <select name="minute" id="minute" class="time">
                <option value="">???</option>
                <option value="00">00???</option> 
                <option value="10">10???</option>
                <option value="20">20???</option>
                <option value="30">30???</option>
                <option value="40">40???</option>
                <option value="50">50???</option>
            </select>
        </div>
        <div class="input-group-addon input_budget">??????</div>
        <input type="text" id="budget" name="budget" class="form-control" placeholder="????????? ????????? ?????????."
        value="${card.card_budget  }">
    </div>   
    <div class="input-group input_memo">
        <div class="input-group-addon">??????</div>
        <textarea rows="5" cols="111" id="memo" name="memo" class="form-control" placeholder="????????? ??????????????????."></textarea>
        <!-- ???????????? ?????? ?????? -->
    </div>

	<div class="input_photo">
		<h4><b>??????</b></h4>
		<div class="uploadFiles">
		    <input type="file" name="uploadFile1" >
		    <input type="file" name="uploadFile2" >   
		    <input type="file" name="uploadFile3" >
		</div>
    </div>

    <div class="input-group input_pay" id="pay">
        <div class="pay_btn">
            <h4><b>?????? ??????</b></h4>
            <button type="button" class="btn btn-default control payAdd">??????</button>
        </div>
        
        <div class="pays" id="pays">
    	</div>
	</div><!-- pay -->
	
    <div class="action">
        <input type="checkbox" id="switch" name="switch" class="input_on-off" checked="checked" value="1">
        <label for="switch" class="label_on-off">
            <span class="marble"></span>
            <span class="on">??????</span>
            <span class="off">?????????</span>
        </label>
        <button type="button" class="btn btn-primary control confirmBtn" id="confirmBtn">??????</button>
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