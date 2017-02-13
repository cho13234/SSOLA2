<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>SSOLA</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/ssola2/resources/styles/comments.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

a:link {text-decoration: none; color: #5A5A5A; font-weight:bold; }
a:visited {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:active {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:focus {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:hover {text-decoration: none; color: #5A5A5A; font-weight:bold;}

body, h1, h2, h3, h4, h5 {
	font-family: "Raleway", sans-serif
}

#layer_fixed {
	height: 20%;
	width: 5%;
	color: black;
	position: fixed;
	z-index: 999;
	top: 30%;
	left: 90%;
	/* opacity: 0.8; */
}

.buttons {
	text-align: center;
}

</style>
<!-- 이미지 , iframe 크기 css jquery 로 제어  -->
<script type="text/javascript">
	$(document).ready(
			function() {
				$(".w3-content p").css("text-align","center");
				$(".w3-content p img").css("width", "600px").css("height",
						"500px").css("margin-left", "auto").css("margin-right","auto");
				$(".w3-content p iframe").css("width", "600px").css("height",
				"400px").css("margin-left", "auto").css("margin-right","auto");

			});
</script>

<script type="text/javascript">
	var view = null;
	var edit = null;

	/* function deleteComment(commentNo) {
		var ok = confirm("Are you sure to delete?");
		if (ok) {
			location.href = '/ssola2/comment/delete.action?commentNo='
					+ commentNo;
		}
	} */

	function toggleCommentStatus(commentNo, isEdit) {
		// 취소 버튼을 눌러도 toggleStatus를 거치고
		// 취소를 눌렀을 때는 이전 항목이 현재 항목이 되므로 이전 항목의 수정이 필요없다.

		if (view != null && isEdit) {
			$(view).css("display", "block");
			$(edit).css("display", "none");
			var area = $("#" + edit.id + "updateCommentContents");
			area.val($("#" + view.id + " .panel-body").text().replace(/<br>/gi,
					'\r\n'));
		}

		view = $("#commentDiv" + commentNo);
		edit = $("#commentEditDiv" + commentNo);

		view.css("display", isEdit ? "none" : "block");
		edit.css("display", isEdit ? "block" : "none");
	}
	
	

	$(function() {

		/* $("#btnUpdate").on("click", function(event) {
			var commentContents = $("#updateCommentContents").val();
			var commentNo = $("#commentNo").val();
			/* var param = "commentContents=" + commentContents; */
			/* $.ajax({
				type : "post",
				url : "/ssola2/comment/update.action",
				data : {
					commentContents : $("#updateCommentContents").val(),
					commentNo : $("#commentNo").val()

				},
				success : function() {
					alert("success!");
				}
			});
		}); */

		$(".button").on("click", function(event) {
			var id = $(event.currentTarget).attr("id"); //commentBox_1
            var sectionNo = id.split("_")[1]; //1
            
            // toggle section당 commentBox 바꿈
            var b = $("#demo_"+sectionNo).toggle();
		});
		
		$(".form-control").keypress(function(event){
			if(event.charCode == 13)
			{
				//submit이 아닌 다른 동작하도록 기술
				alert("enter");
				return false;
			}
		});
		
		
		$("button[id^=btnComment]").on("click", function(event) {
			var id = $(event.currentTarget).attr("id");
			var sectionNo = id.split("_")[1];

			var commentContents = $("#commentContents_" + sectionNo).val();
			/* var sectionNo = $("#sectionNo").val();  */

			/* var param = "commentContents=" + commentContents; */
			var response;
			$.ajax({
				type : "post",
				url : "/ssola2/comment/insert.action",
				data : {
					"commentContents" : commentContents,
					"sectionNo" : sectionNo
				},
				success : function(data) { // data 안에 datafeed 갖고와서 처리
					response = data;
					$("#commentText_"+sectionNo+" > .form-group").append(response);
				}
			});
		});
		
		$("a[id^=btn_update_comment]").click(function(event) {
			event.preventDefault();
			
			/* var a = event.currentTarget();
			var id = $(a).attr('id');
			var tokens = id.split('_');
			var commentNo = tokens[tokens.length - 1]; */
			
			var commentNo = $(this).attr('data-commentno');
			var contents = $("#formCommentUpdate"+commentNo+" > #updateCommentContents").val();
			
			$.ajax({
				type : "post",
				url : "/ssola2/comment/update.action",
				data : {
					"commentContents" : contents,
					"commentNo" : commentNo
				},
				success : function() { // data 안에 datafeed 갖고와서 처리
					view.css("display", "block");
					edit = $("#commentEditDiv" + commentNo);
					$("#commentDiv"+commentNo+" > #commentContents").text(contents);
					
					edit.css("display","none");
				}
			});
			
			
		})
	
	

	$("a[id^=btn_delete_comment]").click(function(event) {
		event.preventDefault();
		
		
		/* var a = event.currentTarget();
		var id = $(a).attr('id');
		var tokens = id.split('_');
		var commentNo = tokens[tokens.length - 1]; */
		
		var commentNo = $(this).attr('data-commentno');
		
		$.ajax({
			type : "get",
			url : "/ssola2/comment/delete.action",
			data : {
				
				"commentNo" : commentNo
			},
			success : function() { // data 안에 datafeed 갖고와서 처리
				$("#commentDiv"+commentNo).remove();
			}
		});
	})
});
</script>

</head>
<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />

	<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
	<div class="w3-content" style="max-width: 80%">
		<h2 style="text-align : center">${confirm}</h2>

		<!-- Header : -->
		<header class="w3-container w3-center w3-padding-32">
			<input type="hidden" id="articleNo" value="${recommend.articleNo}" />
			<div id="layer_fixed"> <!-- layer_fixed section 위치 div 찾아가기 -->
				<a href="#" style="font-family: 'Nanum Pen Script', serif; font-size:25pt;">
				<i style="font-size:24px" class="fa">&#xf0aa;</i>&nbsp;Top</a> <br/>
				<a href="#lunch" style="font-family: 'Nanum Pen Script', serif; font-size:20pt;">${article.section1.category}</a>&nbsp;&nbsp;
				<a href="#dessert" style="font-family: 'Nanum Pen Script', serif; font-size:20pt;">${article.section2.category}</a><br/>
				<a href="#dinner" style="font-family: 'Nanum Pen Script', serif; font-size:20pt;">${article.section3.category}</a>&nbsp;&nbsp;
				<a href="#alcohol" style="font-family: 'Nanum Pen Script', serif; font-size:20pt;">${article.section4.category}</a> 
			</div>
		</header>
		<!--container  -->
		<div class="container"> <!--전체를 감싸줌  -->
			<h3 style="text-align: center;">${article.articleTitle }</h3> <!--main 이미지와 메인 타이틀을 쓴다.  -->
			<div class="w3-row">
				${article.mainImage}
				<!-- Blog entries -->
				<div class="w3-col l8 s12" style="margin-left: 20%;">
					<!-- Blog entry -->
<!--section1 시작  -->					
					<div class="w3-card-4 w3-margin w3-light-grey" style="width: 90%;">

						<div id="lunch">
							<!--이미지도 파일 이름으로 등록  -->
							<h3 style="text-align: center;">${article.section1.category}</h3>
							<br/><br/><br/><br/><br/>
							 ${article.section1.mainTag} 
							<p style="text-align: center;">${article.section1.address }</p>

						<!--section1 댓글 시작 /////////////////////////////////////////////////////////////////////// -->
							<div class="detailbox">
								<button id="commentBox_1" type="button" class="button">Comment Box</button>
								<div id="demo_1" class="demo" style="display: none">



									<div class="commentText">
										<form class="form-inline" role="form" method="post">

											<div class="form-group">
												<input type="text"
													id="commentContents_${article.section1.sectionNo}"
													class="form-control" placeholder="Write in your wall" /> <input
													id="sectionNo" type="hidden" name="sectionNo"
													value="${article.section1.sectionNo}" />
											</div>

											
											<button id="btnComment_${article.section1.sectionNo}"
												type="button" class="[ btn btn-default ]"
												data-loading-text="Loading...">Add</button>
										</form>
									</div>


									<!-- ////////////////////////////////////////////////////////////////// -->
									<div id="commentText_${article.section1.sectionNo}" class="commentText">
										<!-- <form role="form" method="post"> -->
										<div class="form-group">
											<c:forEach var="row" items="${list1}">
												<div id="commentDiv${ row.commentNo }" class="row_${article.section1.sectionNo}">
													<span class="sub-text">${row.id}</span> <span
														class="date sub-text">${row.regDate}</span>
													<div class="panel-body" id="commentContents"
														style="background-color: white">
														${row.commentContents}</div>
													<c:choose>

														<c:when test="${loginuser.id eq row.id }">

															<a
																href="javascript:toggleCommentStatus(${row.commentNo},true)"
																role="button" class="btn btn-default">Update</a>
															<a href="#"
																	id="btn_delete_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Delete</a>
																
															<%-- <a href="javascript:deleteComment(${row.commentNo})"
																class="btn btn-default" role="button">Delete</a> --%>
															<br>
														</c:when>
														<c:otherwise>
															<br>
														</c:otherwise>
													</c:choose>
												</div>
												<c:if test="${loginuser.id eq row.id }">
													<div id="commentEditDiv${ row.commentNo }" class="row_${article.section1.sectionNo}"
														class="panel panel-default" style='display: none'>
														<div class="panel-body">
															<form id="formCommentUpdate${row.commentNo}"
																action="/ssola2/comment/update.action" method="post">
																<input type="hidden" name="commentNo"
																	value="${ row.commentNo }" /> <input type="text"
																	class="form-control" id="updateCommentContents"
																	name="commentContents" style="resize: none;"
																	value="${row.commentContents}" />
																<div class="rightBtn">
																	<a href="#"
																	id="btn_update_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Update</a> <a
																	href="javascript:toggleCommentStatus(${ row.commentNo  }, false)"
																	class="btn btn-default" role="button">Cancel</a>
																</div>
															</form>
														</div>
													</div>
												</c:if>
											</c:forEach>
										</div>
										<!-- </form> -->
									</div>
								</div>
							</div>
						<!--section1 댓글 끝  ////////////////////////////////////////////////////////////////////////////////////// -->
						</div>
					</div>
<!-- section2 -->					
					<div id="dessert" class="w3-card-4 w3-margin w3-light-grey" style="width: 90%;">
					<h3 style="text-align: center;">${article.section2.category }</h3>
						 ${article.section2.mainTag}
						<p style="text-align: center;">${article.section2.address }</p>

				<!--section2 댓글 시작 /////////////////////////////////////////////////////////////////////////////... -->
						<div class="detailbox">
							<button id="commentBox_2" type="button" class="button">Comment Box</button>
							<div id="demo_2" class="demo" style="display: none">



								<div class="commentText">
									<form class="form-inline" role="form" method="post">

										<div class="form-group">
											<input type="text"
												id="commentContents_${article.section2.sectionNo}"
												class="form-control" placeholder="Write in your wall" /> <input
												id="sectionNo" type="hidden" name="sectionNo"
												value="${article.section2.sectionNo}" />
										</div>

										<button id="btnComment_${article.section2.sectionNo}"
											type="button" class="[ btn btn-default ]"
											data-loading-text="Loading...">Add</button>
									</form>


								<!-- ////////////////////////////////////////////////////////////////// -->
								<div id="commentText_${article.section2.sectionNo}" class="commentText">
									<!-- <form role="form" method="post"> -->
									<div class="form-group">
										<c:forEach var="row" items="${list2}">
											<div id="commentDiv${ row.commentNo }" class="row_${article.section2.sectionNo}">
												<span class="sub-text">${row.id}</span> <span
													class="date sub-text">${row.regDate}</span>
												<div class="panel-body" id="commentContents"
													style="background-color: white">
													${row.commentContents}</div>
												<c:choose>

													<c:when test="${loginuser.id eq row.id }">

														<a
															href="javascript:toggleCommentStatus(${row.commentNo},true)"
															role="button" class="btn btn-default">Update</a>
														<a href="#"
																	id="btn_delete_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Delete</a>
														<br>
													</c:when>
													<c:otherwise>
														<br>
													</c:otherwise>
												</c:choose>
											</div>
											<c:if test="${loginuser.id eq row.id }">
												<div id="commentEditDiv${ row.commentNo }" class="row_${article.section2.sectionNo}"
													class="panel panel-default" style='display: none'>
													<div class="panel-body">
														<form id="formCommentUpdate${row.commentNo}"
															action="/ssola2/comment/update.action" method="post">
															<input type="hidden" name="commentNo"
																value="${ row.commentNo  }" /> <input type="text"
																class="form-control" id="updateCommentContents"
																name="commentContents" style="resize: none;"
																value="${row.commentContents}" />
															<div class="rightBtn">
																
																<a href="#"
																	id="btn_update_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Update</a> <a
																	href="javascript:toggleCommentStatus(${ row.commentNo  }, false)"
																	class="btn btn-default" role="button">Cancel</a> 
															</div>
														</form>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
									<!-- </form> -->
								</div>
							</div>
						</div>
						<!-- ///////////////////////////////////////////////////////////////////////////////////// -->
					</div>
				<!--section2 댓글 끝  -->
				</div>
<!-- section3  -->
				<div id="dinner" class="w3-card-4 w3-margin w3-light-grey" style="width: 90%;">
					<h3 style="text-align: center;">${article.section3.category}</h3>
						${article.section3.mainTag}
						<p style="text-align: center;">${article.section3.address }</p>
					<!--section3 댓글 시작/////////////////////////////////////////////////////////////////////////////... -->
						<div class="detailbox">
							<button id="commentBox_3" type="button" class="button">Comment Box</button>
							<div id="demo_3" class="demo" style="display: none">



								<div class="commentText">
									<form class="form-inline" role="form" method="post">

										<div class="form-group">
											<input type="text"
												id="commentContents_${article.section3.sectionNo}"
												class="form-control" placeholder="Write in your wall" /> <input
												id="sectionNo" type="hidden" name="sectionNo"
												value="${article.section3.sectionNo}" />
										</div>

										<button id="btnComment_${article.section3.sectionNo}"
											type="button" class="[ btn btn-default ]"
											data-loading-text="Loading...">Add</button>
									</form>
								</div>


								<!-- ////////////////////////////////////////////////////////////////// -->
								<div id="commentText_${article.section3.sectionNo}" class="commentText">
									<!-- <form role="form" method="post"> -->
									<div class="form-group">
										<c:forEach var="row" items="${list3}">
											<div id="commentDiv${ row.commentNo }" class="row_${article.section3.sectionNo}">
												<span class="sub-text">${row.id}</span> <span
													class="date sub-text">${row.regDate}</span>
												<div class="panel-body" id="commentContents"
													style="background-color: white">
													${row.commentContents}</div>
												<c:choose>

													<c:when test="${loginuser.id eq row.id }">

														<a
															href="javascript:toggleCommentStatus(${row.commentNo},true)"
															role="button" class="btn btn-default">Update</a>
														<a href="#"
																	id="btn_delete_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Delete</a>
														<br>
													</c:when>
													<c:otherwise>
														<br>
													</c:otherwise>
												</c:choose>
											</div>
											<c:if test="${loginuser.id eq row.id }">
												<div id="commentEditDiv${ row.commentNo }" class="row_${article.section3.sectionNo}"
													class="panel panel-default" style='display: none'>
													<div class="panel-body">
														<form id="formCommentUpdate${row.commentNo}"
															action="/ssola2/comment/update.action" method="post">
															<input type="hidden" name="commentNo"
																value="${ row.commentNo  }" /> <input type="text"
																class="form-control" id="updateCommentContents"
																name="commentContents" style="resize: none;"
																value="${row.commentContents}" />
															<div class="rightBtn">
																<a href="#"
																	id="btn_update_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Update</a> <a
																	href="javascript:toggleCommentStatus(${ row.commentNo  }, false)"
																	class="btn btn-default" role="button">Cancel</a>
															</div>
														</form>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
									<!-- </form> -->
								</div>
							</div>
						</div>
					<!--section3 댓글 끝 ///////////////////////////////////////////////////////////////////////////////////// -->
					</div>
<!--section4  -->
					<div id="alcohol" class="w3-card-4 w3-margin w3-light-grey" style="width: 90%;">
					<h3 style="text-align: center;">${article.section4.category}</h3>
						${article.section4.mainTag}
						<p style="text-align: center;">${article.section4.address }</p>

					<!--section4 댓글 시작 /////////////////////////////////////////////////////////////////////////////... -->
						<div class="detailbox">
							<button id="commentBox_4" type="button" class="button">Comment Box</button>
							<div id="demo_4" class="demo" style="display: none">



								<div class="commentText">
									<form class="form-inline" role="form" method="post">

										<div class="form-group">
											<input type="text"
												id="commentContents_${article.section4.sectionNo}"
												class="form-control" placeholder="Write in your wall" /> <input
												id="sectionNo" type="hidden" name="sectionNo"
												value="${article.section4.sectionNo}" />
										</div>

										<button id="btnComment_${article.section4.sectionNo}"
											type="button" class="[ btn btn-default ]"
											data-loading-text="Loading...">Add</button>
									</form>
								</div>


								<!-- ////////////////////////////////////////////////////////////////// -->
								<div id="commentText_${article.section4.sectionNo}" class="commentText">
									<!-- <form role="form" method="post"> -->
									<div class="form-group">
										<c:forEach var="row" items="${list4}">
											<div id="commentDiv${ row.commentNo }" class="row_${article.section4.sectionNo}">
												<span class="sub-text">${row.id}</span> <span
													class="date sub-text">${row.regDate}</span>
												<div class="panel-body" id="commentContents"
													style="background-color: white">
													${row.commentContents}</div>
												<c:choose>

													<c:when test="${loginuser.id eq row.id }">

														<a
															href="javascript:toggleCommentStatus(${row.commentNo},true)"
															role="button" class="btn btn-default">Update</a>
														<a href="#"
																	id="btn_delete_comment_${row.commentNo }"
																	data-commentno="${row.commentNo }"
																	class="btn btn-default" role="button">Delete</a>
														<br>
													</c:when>
													<c:otherwise>
														<br>
													</c:otherwise>
												</c:choose>
											</div>
											<c:if test="${loginuser.id eq row.id }">
												<div id="commentEditDiv${ row.commentNo }" class="row_${article.section4.sectionNo}"
													class="panel panel-default" style='display: none'>
													<div class="panel-body">
														<form id="formCommentUpdate${row.commentNo}"
															action="/ssola2/comment/update.action" method="post">
															<input type="hidden" name="commentNo"
																value="${ row.commentNo  }" /> <input type="text"
																class="form-control" id="updateCommentContents"
																name="commentContents" style="resize: none;"
																value="${row.commentContents}" />
															<div class="rightBtn">
																<a href="javascript:submitComment(${row.commentNo})"
																	class="btn btn-default" role="button">Update</a> <a
																	href="javascript:toggleCommentStatus(${ row.commentNo  }, false)"
																	class="btn btn-default" role="button">Cancel</a>
															</div>
														</form>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
									<!-- </form> -->
								</div>
							</div>
						</div>
					<!--section4 댓글 끝 ///////////////////////////////////////////////////////////////////////////////////// -->
					</div>
				</div>
			</div>
		</div>
		<br />
		
		<!-- END GRID 관리자 수정 , 삭제 버튼 -->
		
		<div class="buttons">
			<c:if test="${ loginuser.userType }">
				<!-- 아래 a 링크는 input type='submit' 버튼을 누르는 효과 발생 -->
				<a class="btn btn-default" style="font-family: 'Jeju Gothic', serif;"
					href="/ssola2/main/edit.action?articleNo=${article.articleNo}">Update</a>
	
				&nbsp;&nbsp; <a class="btn btn-default"
					style="font-family: 'Jeju Gothic', serif;"
					href="/ssola2/main/delete.action?articleNo=${article.articleNo}">delete</a>
			</c:if>
			&nbsp;&nbsp; <a class="btn btn-default"
				style="font-family: 'Jeju Gothic', serif;"
				href="/ssola2/main/main.action">List</a>
		</div>
		
	</div>

	<!-- END w3-content -->

	<c:import url="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>
