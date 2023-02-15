<%@page import="com.fp.dto.NoteDTO"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UserNoteUpdateForm.jsp</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <style type="text/css">
        .header{
            width:100%;
            height: 100px;
        }
        .footer{
            width:100%;
            height: 200px;
        }
        .main{
            margin-top: 3rem;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .content{
            width:1280px;
        }

        .content_frame{
            margin:3rem;
            margin-bottom: 0rem;
            width:95%;
            height:100px;
            
            display:flex;
            justify-content: space-between;
        }
        .content_info{
            margin-bottom: 2rem;
        }
        .addBtn{
            background-color:#1DB1F8;
            border: #1DB1F8;
        }
        .day{
            background-color:#1DB1F8;
            border: #1DB1F8;
        }
        
        .input_all_group {
            margin:auto;
            height: 100%;
            width:95%;
        }
        .input-group-addon{
            width:100px;
        }
        .input-group{
            width:100%;
        }
        .input_date{
            display:flex;
        }
        .input_money_companion{
            display:flex;
        }
        .content_cardInfo{
            margin-left:3rem;
            margin-right:4rem;
        }

        .day{
            width:11rem;
            margin-bottom: 1rem;
        }
        th{
            background-color: rgba(241, 240, 240, 0.96);
        } 
        .card_add{
            display:flex;
            justify-content: flex-end;
        }
        .cardAddBtn{
            width:30rem;
            background-color: rgba(241, 240, 240, 0.96);
        }
        .scrapAddBtn{
            width:30rem;
            background-color: rgba(172, 172, 172, 0.96);
        }
        .main {
        	margin-bottom: 50px;
        }
        .form-control[readonly] {
        	background-color: #fff;
        }
        .sorry {
        	text-align: center;
        	color: #ccc;
        }
    </style>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
    
    	$(function()
		{
    		$("#region").val(${note.region_num}).prop("selected", true);
    		
			$(".addBtn").click(function()
			{
				if ($("#title").val().trim()=="")
				{
					alert("제목을 입력해주세요.");
					$("#title").focus();
					return;
				}
				if ($("#region").val()==0)
				{
					alert("대표지역을 입력해주세요.");
					$("#region").focus();
					return;
				}
				if ($("#startDate").val()=="")
				{
					alert("시작일을 입력해주세요.");
					$("#startDate").focus();
					return;
				}
				if ($("#lastDate").val()=="")
				{
					alert("종료일을 입력해주세요.");
					$("#lastDate").focus();
					return;
				}
				
				$("#noteForm").submit();

			});
			
			$(".deleteBtn").click(function()
			{
				// alert("확인");
				
				var card_num = $(this).val();
				// alert(card_num);
				$(location).attr("href", "usercarddelete.action?card_num=" + card_num);
			});
			
			$(".cancelBtn").click(function()
			{
				// alert("확인");
				$(location).attr("href", "usernoteupdatecancel.action?note_num=${note.note_num}")
			});
			
		});
    
    </script>
</head>
<body>

    <div class="header">
    	<c:import url="UserMenu.jsp"></c:import>
    </div>

    <div class="main">

        <div class="content">
            <div class="content_frame">
                <div class="content_write"><h1><b>여행노트 작성</b></h1></div>
                <div class="content_frame_btn">
                    <button type="button" class="btn btn-primary control addBtn">등록</button>
                    <button type="button" class="btn btn-default control cancelBtn">취소</button>
                </div>
            </div>
            
            <div class="content_info">
                <div class="input_all_group">
                	<form action="usernoteupdate.action?note_num=${note.note_num }" method="post" id="noteForm">
                    <div class="input-group input_title">
                        <div class="input-group-addon">제목</div>
                        <input type="text" id="title" name="title" class="form-control" value="${note.note_title }">
                    </div>     
                    
                    <div class="input-group">
                        <div class="input-group-addon">대표지역</div>
                        <select class="form-control" id="region" name="region">
							<option value="0" >대표지역을 입력해주세요.</option>
							<c:forEach var="region" items="${regionList }">
								<option value="${region.region_num }">${region.region_name }</option>
							</c:forEach>
						</select>
                    </div>
                    <div class="input_date">
                        <div class="input-group">
                            <div class="input-group-addon">시작일</div>
                            <input type="text" id="startDate" name="startDate" class="form-control" value="${note.note_startdate }">
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">종료일</div>
                            <input type="text" id="lastDate" name="lastDate" class="form-control" value="${note.note_lastdate }">
                        </div>
                    </div>

                    <div class="input_money_companion">
                            <div class="input-group">
                                <div class="input-group-addon">총예산</div>
                                <input type="text" id="totalMoney" name="totalMoney" class="form-control" value="${note.note_budget }">
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">동행인</div>
                                <input type="text" id="companion" name="companion" class="form-control" value="${note.note_company }">
                            </div>
                    </div >
                    </form>
                </div>
            </div>
            
            <div class="content_cardInfo">
            
            	<c:forEach var="list" items="${lists }" varStatus="status">
               
                  <c:choose>
               
                  <c:when test="${empty list }">
					<button type="button" class="btn btn-primary control day">Day${status.count }</button>
					<table class="table">
	                        <tr>
	                            <th></th>
	                            <th>장소명</th>
	                            <th>방문시간</th>
	                            <th>예산</th>
	                            <th>메모</th>
	                            <th></th>
	                        </tr>
	                        <tr>
								<td class="sorry" colspan="7">아직 등록하신 카드가 없습니다.</td>
							</tr>
					</table>
					<div class="card_add">
                        <button type="button" class="btn btn-default control cardAddBtn" onclick="location.href='usercardinsertform.action?note_num=${note.note_num}&day=${days.get(status.count) }'"> 카드 추가</button>
                        <button type="button" class="btn btn-default control scrapAddBtn" onclick="location.href='usernotescrapselectlist.action?note_num=${note.note_num}&day=${days.get(status.count) }'">스크랩 추가</button>
                    </div>
                  </c:when>
                  
                  <c:otherwise>
                   	<button type="button" class="btn btn-primary control day">Day${status.count }</button>
					<table class="table">
                        <tr>
                            <th></th>
                            <th>장소명</th>
                            <th>방문시간</th>
                            <th>예산</th>
                            <th>메모</th>
                            <th></th>
                        </tr>
                  <c:forEach var="card" items="${list }">
                        <tr>
                            <td></td>
                            <td>
                            	<a href="usercard.action?card_num=${card.card_num }">
                            		${card.card_location }
                            	</a>
                            </td>
                            <td>${card.card_time }</td>
                            <td>${card.card_budget }</td>
                            <td>${card.card_comment eq null ? " " : card.card_comment }</td>
                            <td><button type="button" class="btn btn-default control deleteBtn" value="${card.card_num }"><b>─</b></button></td>
                       	</tr>
                  </c:forEach>
					</table>
					<div class="card_add">
                        <button type="button" class="btn btn-default control cardAddBtn" onclick="location.href='usercardinsertform.action?note_num=${note.note_num}&day=${days.get(status.count) }'"> 카드 추가</button>
                        <button type="button" class="btn btn-default control scrapAddBtn" onclick="location.href='usernotescrapselectlist.action?note_num=${note.note_num}'">스크랩 추가</button>
                    </div>
                  </c:otherwise>
               
                  </c:choose>
               
               </c:forEach>
            
            	<!-- 
                <div class="card_day1">
                    <button type="button" class="btn btn-primary control day">Day1</button>
                    <table class="table">
                        <tr>
                            <th>순서</th>
                            <th>장소명</th>
                            <th>방문시간</th>
                            <th>예산</th>
                            <th>지출</th>
                            <th>메모</th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>쌍용강북교육센터</td>
                            <td></td>
                            <td>20,000</td>
                            <td></td>
                            <td>컨펌받기</td>
                            <td><button type="button" class="btn btn-default control deleteBtn"><b>─</b></button></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>쌍용강남교육센터</td>
                            <td></td>
                            <td>10,000</td>
                            <td></td>
                            <td>불러보기</td>
                            <td><button type="button" class="btn btn-default control deleteBtn"><b>─</b></button></td>
                        </tr>
                    </table>
                    <div class="card_add">
                        <button type="button" class="btn btn-default control cardAddBtn"> 카드 추가</button>
                        <button type="button" class="btn btn-default control scrapAddBtn">스크랩 추가</button>
                    </div>
                </div>
                 -->
                 
                </div>
            </div>
        </div>

    <div class="footer">
		<c:import url="UserFooter.jsp"></c:import>
    </div>
</body>
</html>
