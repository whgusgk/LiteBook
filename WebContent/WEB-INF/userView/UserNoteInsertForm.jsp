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
    <title>UserNoteInsertForm.jsp</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
        .content_cardInfo {
        	height: 600px;
        }
        
    </style>
    <script type="text/javascript">
    	$(function()
		{
    		
			$(".addBtn").click(function()
			{
				// alert("확인");
				// 다음 컨트롤러에서 인서트 작업 시킨 후 UserNotedCardInsertForm 페이지로 이동
				
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
			
			$(".cancelBtn").click(function()
			{
				$(location).attr("href", "usernotelist.action");
				
			});
			
			$("#startDate").change(function()
			{
				$("#lastDate").attr("min", $("#startDate").val());
			});
			
			$("#lastDate").change(function()
			{
				$("#startDate").attr("max", $("#lastDate").val());
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
                    <button type="submit" class="btn btn-primary control addBtn">등록</button>
                    <button type="button" class="btn btn-default control cancelBtn">취소</button>
                </div>
            </div>
            
			<form action="usernoteinsert.action" method="post" id="noteForm">
            <div class="content_info">
                <div class="input_all_group">
                    <div class="input-group input_title">
                        <div class="input-group-addon">제목</div>
                        <input type="text" id="title" name="title" class="form-control" placeholder="제목을 입력해 주세요." required/>
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
                            <input type="date" id="startDate" name="startDate" class="form-control">
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">종료일</div>
                            <input type="date" id="lastDate" name="lastDate" class="form-control">
                        </div>
                    </div>

                    <div class="input_money_companion">
                            <div class="input-group">
                                <div class="input-group-addon">총예산</div>
                                <input type="text" id="totalMoney" name="totalMoney" class="form-control" placeholder="총예산"/>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">동행인</div>
                                <input type="text" id="companion" name="companion" class="form-control" placeholder="동행인"/>
                            </div>
                    </div >
                </div>
            </div>
            </form>
            
            <div class="content_cardInfo">
            </div>
        </div>
    </div>

    <div class="footer">
		<c:import url="UserFooter.jsp"></c:import>
    </div>
</body>
</html>
