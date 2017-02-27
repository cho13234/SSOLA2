<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/ssola2/resources/styles/main_mypage.css">


<script type="text/javascript">


	$(function() {
		$("#loingdelete").on("click", function(event) {

			if (confirm("탈퇴하시겠습니까")) {

				var tabledelete = $("#tabledelete").val();

				$.ajax({
					type : "get",
					url : "/ssola2/mypage/logindelete.action",
					data : {
						tabledelete : $("#tabledelete").val()
					},
					success : function() {
						alert("탈퇴 성공");
					}
				});
			}
			;
		});
	});
</script>

</head>
<body>

<div id = "wrap">
	<div class="collapse navbar-collapse">
		<ul class="nav navbar-nav">	
			<%-- <c:choose>
				<c:when test='${loginuser.id eq requestScope.id}'>	 --%>	
					<li><a href="friends_list.action">친구 목록</a></li>
			<%-- 	</c:when>
			</c:choose> --%>
			<li><a href="friend_add_confirm.action">나를 등록한 사람(친구추천)</a></li>
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">회원정보관리 <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li ><a href="loginedit.action">회원정보 수정</a></li>
					<li id="loingdelete"><a href="logindelete.action">회원탈퇴</a></li>
				</ul>
			</li>
			
			<li class = "dropdown">
				<a href = "#" class = "fropdown-toggle" data-toggle="dropdown">나의 스크랩</a>
				<ul class="dropdown-menu">
					<li><a href="scrapform.action">전체공개</a></li>
					<li><a href="scrapform_0.action">비공개</a></li>
					<li><a href="scrapform_1.action">나의 친구에게 공개</a></li>	
				</ul>
			</li>
			
			<!-- <li><a href="q_mail.action">문의 작성</a></li> -->
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">작성한 글<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="my_voc_list.action">고객의 소리</a></li>
					<li><a href="my_fboard_list.action">자유게시판</a></li>
				</ul>
			</li>
			
		</ul>
	</div><!--/.nav-collapse -->
</div>

</body>
</html>