<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html aria-hidden="false">
<head>
<meta charset="UTF-8">
<title>UserNotificationList.jsp</title>

<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/styleMain.css">
<link rel="stylesheet" type="text/css" href="css/UserNotificationList.css">
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/mainJS.js"></script>

</head>	
<body class="Site">
	<div class="Site-content" id="wrap">
		<div class="import">
				<c:import url="UserMenu.jsp"></c:import>
		</div><!-- import -->
<div class="container">
  <div class=".col-xs-4 .col-md-offset-2">
    <div class="panel panel-default panel-info Profile">
      <div class="panel-heading">알림</div>
      <div class="alert alert-danger">
        <strong>경고 받은 내역이 n건 있습니다.</strong>  자세한 내용은 마이페이지에서 확인해주세요.
         <span class="sr-only">이 영역 클릭 시 마이페이지 경고 리스트로 이동</span>
      </div>
      <div class="alert alert-warning">
        <strong>답변 내역이 n건 있습니다.</strong>  자세한 내용은 마이페이지에서 확인해주세요.
         <span class="sr-only">이 영역 클릭 시 마이페이지의 질문 리스트로 이동</span>
      </div>
      <div class="alert alert-primary">
        <strong>댓글 내역이 n건 있습니다.</strong>  자세한 내용은 여행책에서 확인해주세요.
         <span class="sr-only">이 영역 클릭 시 해당 여행책으로 이동</span>
      </div>
      <div class="alert alert-secondary">
        <strong>좋아요 내역이 n건 있습니다.</strong>  자세한 내용은 여행책에서 확인해주세요.
         <span class="sr-only">이 영역 클릭 시 해당 여행책으로 이동</span>
      </div>
      </div>
      </div>
      </div>


	
		<select class="form-control selectArea" aria-label=abled id="type">
                  <option value="0" selected>전체</option>
                  <option value="liked">좋아요</option>
				  <option value="warning">경고</option>
				  <option value="comment">댓글</option>
				  <option value="question">질문</option>
               </select>
          <br>     	
		<div class="main_listWrapper">
			<div class="main_list">
				<table class="table table-hover">
				<thead>
					<tr>
						<th>카테고리</th>
						<th>내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>좋아요</td>
						<td>홍길동님이 여행책 '울릉도 맛집 10선'에 좋아요를 누르셨습니다.</td>
					</tr>
					<tr>
						<td>댓글</td>
						<td>김첨지님이 여행책 '울릉도 맛집 10선'에 댓글을 남기셨습니다.</td>
					</tr>
				</tbody>
			</table>
			</div><!-- main_list -->
		</div>
		</div>
	

<!-- footer -->
<!-- pageNav -->
<nav aria-label="" class="pageNav">
  <ul class="pagination" >
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">◀</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item active" aria-current="page">
      <a class="page-link" href="#">2</a>
    </li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item">
      <a class="page-link" href="#">▶</a>
    </li>
  </ul>
</nav>
<!-- pageNav -->
<c:import url="UserFooter.jsp"></c:import> 

<!-- footer -->




</body>
</html>