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
<title>UserBookInsertForm.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserBookInsertForm.css">
<style type="text/css">
	/* 필요한 CSS 제작 사용 영역*/
	.file p{
		margin-bottom:0;
		margin-top:3px;
	}
	#cards{
		width:inherit;
	}
	.cardTable , .cardTable_forEach{
		width:100%;
		display:flex;
	}
	.cardNum , .cardNum_forEach{
		outline:none;
		border:none;
		background-color:#E0E0E0;
		width:50px;
	}
	.cardName , .cardName_forEach{
		outline:none;
		border:none;
		background-color:#E0E0E0;
		min-width:45vw;
	}
	.minus, .minus_forEach{
		display:inline-block;
		border:none;
		border:1px solid black;
		width:40px;
		height:25px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>
<script type="text/javascript">
$(document).on("click", ".minus", function(){
    var idx = $('.minus').index(this);
    
    var bcardNum = $("#bcardNum").eq(idx).val();
    
    //$('.cardTable').eq(idx).remove();
    
    if( bcardNum != '0')
	 {	
		 $.ajax(
		 {
			 type : "POST"
			 , url : "userajaxbookedcarddelete.action"
			 , data : {bcardNum:bcardNum}
		 	 , success : function(data)
		 	 {
		 		 
		 	 }
		 	 , error: function(e)
		 	 {
		 		 console.log(e);
		 	 }
		 });

		 $(".cardTable").eq(idx).remove(); 			 
	 }
	 else
	 {
		 $(".cardTable").eq(idx).remove(); 			 
	 }
		
});
	$(function(){
		
		$(".category").val(${userBook.bcategory_num}).prop("selected",true);
		
		
		$("#noteSelect").change(function(){
			
			//alert("확인");
			
			let note_num = $(this).val();
			
			//alert(note_num);
			//1, 2, 6 노트 번호 잘넘어옴.
			
			//ajaxList(note_num);
			
			$("#cardSelect").empty();
			
			let params = "noteSelect=" + $.trim($("#noteSelect").val());
			
		
			$.ajax(
			{
				type: "POST"
				,url: "notedcardajax.action"
				,data: params
				,dataType:"xml"
				,success:function(args)
				{	
					$(args).find("card").each(function(){
												
						let item = $(this);
						let num = item.find("cardnum").text();
						let location = item.find("cardlocation").text();
						
	
						let insertOption ="";
						insertOption +="<option value="+num+">"+location+"</option>";
						
						$("#cardSelect").append(insertOption);
						

					});
					
					
				}
				,error : function(e)
				{
					alert(e.responseText);
				}
					
			});
		});
		
		
		$("#submitBtn").click(function(){
			
			//alert("확인");
			$("#bookForm").submit();
		});
	});
	
	function appendDiv()
	{	
		//<></>생성
		var fragment = document.createDocumentFragment();
		
		let card_num =  $("#cardSelect").val();
		let card_location = $("#cardSelect  option:checked").text();
		//div 엘리먼트 생성및 클래스명 설정
		
		var divCardTableEl = document.createElement("div");
		
		var divBcardNumEl = document.createElement("div");
		var divNumEl = document.createElement("div");
		var divNameEl = document.createElement("div");
		var divDeleteEl = document.createElement("div");
		
		//divCardTableEl.className = "cardTable";
		divCardTableEl.className = "cardTable";
		
		
		
		divBcardNumEl.className = "bcard_num";
		divNumEl.className = "card_name";
		divNameEl.className = "card_location";
		divDeleteEl.className = "card_delete";
		
		var bcardNum = "<input type='text' class='bcardNum' name='bcardNum' value='0'>";
		var inputNum = "<input type='text' class='cardInput cardNum' name='cardNum' id='cardNum'value="+ card_num +">";
		var inputName= "<input type='text' class='cardInput cardName' name='cardName' id='cardName'value="+ card_location +">";
		var button = "<button type='button' id='removeBtn' class='minus cardInput' value="+card_num+">-</button>";
		//var button = "<button type='button' id='removeBtn' class='cardInput minus' value="+card_num+" onclick='removeCard()'>-</button>";
		//var button = "<button type='button' class='minus' value="+card_num+">-</button>";

		// 구성한 내용을 div 엘리먼트 안에 배치
		divBcardNumEl.innerHTML = bcardNum;
		divNumEl.innerHTML = inputNum;
		divNameEl.innerHTML = inputName;
		divDeleteEl.innerHTML = button;
		
		//가장 바깥쪽 div엘리먼트에 세부 엘리먼트 배치
		divCardTableEl.appendChild(divBcardNumEl);
		divCardTableEl.appendChild(divNumEl);
		divCardTableEl.appendChild(divNameEl);
		divCardTableEl.appendChild(divDeleteEl);
		
		fragment.appendChild(divCardTableEl);
		
		//cards 영역에 배치
		var cards = document.getElementById("cards");
		cards.appendChild(fragment);
		
		//alert("확인");
		//alert(num +", "+location);
 		//alert(card_num+ ", " + card_location);
		// let insertTr = "";
		//insertTr += "<tr>";
		//insertTr += "<th>"+card_location+"</th>";
		//insertTr += "<td>"
		//insertTr += "<button class='minus' name='cardNum' value="+card_num+" onclick='removeCard("+card_num+")'>-</button>";
		//insertTr += "</td>";
		//insertTr += "</tr>"
		
		//$("#cardTbody").append(insertTr);  
		//alert(card_num);
		
/* 		$(".minus").click(function(){
			
			alert($(this).val());
		}) */
		
		/*
	<div class="cardTable">
<div>
	<input type="text" class="cardInput cardNum" name ="cardNum" id="cardNum" value="1"/>
	<input type="text" class="cardInput cardName" name ="cardName" id="cardName" value="쌍용강북교육센터"/>
	<button type="button" class="cardInput minus">-</button>
</div>
		*/

	}
	
/*	
	function removeCard()
	{	
		 //var idx = $(this).index();
		 //var idx = $(".minus").index(this);
		// alert($(this).val());
		 var idx = $(".cardTable").index(this);
		 //alert(idx);
		
		 alert(idx);

		 
		 var bcardNum = $("#bcardNum").eq(idx).val();
		 alert(bcardNum);
		 /*var bcardNum = $(".cardTable").eq(idx).val();
		 
		 if( bcardNum != 0)
		 {	
			 $.ajax(
			 {
				 type : "POST"
				 , url : "userajaxbookedcarddelete.action"
				 , data : {bcardNum:bcardNum}
			 	 , success : function(data)
			 	 {
			 		 
			 	 }
			 	 , error: function(e)
			 	 {
			 		 console.log(e);
			 	 }
			 });

			 $(".cardTable").eq(idx).remove(); 			 
		 }
		 else
		 {
			 $(".cardTable").eq(idx).remove(); 			 
		 }
		 //parent.removeChild(idx); 
		 //$(".minus").eq(idx).remove(); 
			*/
//	}
	
/* 	function removeAjaxCard()
	{
		 var jidx = $(".minus_forEach").index(this);
		 alert(jidx);
		 
		 var bcardNum = $("#bcardNum").eq(idx).val();
		 alert(bcardNum);
		 
		 if( bcardNum != 0)
		 {	
			 $.ajax(
			 {
				 type : "POST"
				 , url : "userajaxbookedcarddelete.action"
				 , data : {bcardNum:bcardNum}
			 	 , success : function(data)
			 	 {
			 		 
			 	 }
			 	 , error: function(e)
			 	 {
			 		 console.log(e);
			 	 }
			 });

			 $(".cardTable_forEach").eq(jidx).remove();
		 }
		 else
		 {
			 $(".cardTable_forEach").eq(jidx).remove();
		 }
	} */
	
/* 	function removeCard(card_num)
	{
			var eventTarget = document.getElementsByClassName('minus');
			
	    	for (var i=0; i<eventTarget.length; i++) {
			eventTarget[i].addEventListener('click', function() {
				var parent = document.querySelector('#cardTable tbody');
				parent.removeChild(this.parentElement.parentElement);
				i --;
			})
		}
	} */

	
</script>
</head>	
<body class="Site">
<!-- Site-content :body와 묶여서 flex로 footer를 하단 고정시키기 위한 첫번째 방법 -->
<!-- wrap에 min-height을 줘서 footer를 하단 고정시키기 위한 두번째 방법-->
<form action="userbookupdate.action" method="post" id="bookForm" name="bookForm" enctype="multipart/form-data">
	<div class="Site-content" id="wrap">
		<div class="import">
				<c:import url="UserMenu.jsp"></c:import>
		</div><!-- import -->
	
		<div class="main_title">
			<h2>여행책 수정 </h2>
			<hr>
			<input type="hidden" name="bookNum" id="bookNum" value="${book_num }"/>
		</div><!-- main_title -->
		
		<div class="main_listWrapper">
			<div class="main_list">
	<div class="sub">
		<input type="text" name="title" placeholder="제목을 입력해주세요" value=${userBook.book_title }>
	</div>
	
	<div>
		<span>카테고리</span>
		
		<select class="category" name="category">
			<option>카테고리 선택</option>
			<option value="1">맛집</option>
			<option value="2">쇼핑</option>
			<option value="3">체험</option>
			<option value="4">힐링</option>
			<option value="5">기타</option>
		</select>

	</div>
	
	<div class="file">
		<p>대표사진</p>
		<div>
		<img src="${userBook.book_cover }" style="width:300px; height:200px;"></img>
		</div>
		<input type="file" name="uploadFile"/>
	</div>	
		여행카드
		<div class="note">
			<div class="selectNote">
 				<select id="noteSelect"  name="noteSelect" style="margin-bottom: 5px;">
					<option>여행노트 선택</option>
					<c:forEach var="note" items="${noteList }">
						<option value="${note.note_num }">${note.note_title }</option>
					</c:forEach>
				</select> 
				<br>
				<select id="cardSelect" onchange="appendDiv()">
					<option>여행노트에 포함된 여행카드 선택</option>
<!-- 					<option value="">울릉도 맛집 10선</option>
					<option value="">국내 꽃구경 명소 TOP 3</option>
					<option value="">서울 빈티지 쇼핑 지도</option> -->
				</select>
			</div>
		</div>
			
			<div>
				<div class="cardList"> 
					
					<div class="cards" id="cards">
						<c:forEach var="bcard" items="${bookedCardList }">
							<div class="cardTable">
								<div class="bcard_num">
									<input type="text" class="bcardNum" id="bcardNum" name="bcardNum" value="${bcard.bcard_num}">
								</div>
								<div class="card_name_forEach">
									<input type="text" class="cardInput cardNum" name="cardNum" id="cardNum"value="${bcard.card_num }">
								</div>
								<div class="card_location_forEach">
									<input type="text" class="cardInput cardName" name="cardName" id="cardName" value="${bcard.card_location }">
								</div>
								<div class="card_delete_forEach">
									<button type="button" id="removeBtn" class="cardInput minus" value="${bcard.card_num}" onclick="removeAjaxCard()">-</button>						
								</div>
							</div>	 
						</c:forEach>
					</div>
				</div>
			</div>
	<br>
		<div class="mb-3">
		  <textarea class="form-control" id="formTextarea" rows="25"  name="comment"
		  placeholder="내용을 입력해주세요.">${fn:replace(userBook.book_comment, replaceWord, '<br>') }</textarea>
		</div><!-- 내용입력 폼 -->
		
	<br>
	<div class="buttonLine" style="text-align: right;">
		<button type="button" class="btn" id="submitBtn" style="margin-right: 10px; background-color: #1DB1F8;">발행</button>
		<button type="button" class="btn" style="background-color: #BDBDBD">나가기</button>
	</div>
<br><br><br>
			</div><!-- main_list -->
		</div><!-- main_listWrapper -->
</div><!-- wrapper -->
</form>

<!-- footer -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>