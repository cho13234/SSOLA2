<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>freeboard</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />

<style type="text/css">
/*font source*/
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#titleOfthepage {
	font-family: 'Noto Sans KR', sans-serif;
	margin-left: 20%;
}

#title {
	font-family: 'Jeju Gothic', serif;
}

.tablerow {
	text-align: center;
	font-family: 'Jeju Gothic', serif;
}

.clickable-row {
	cursor: pointer;
	/* list에 마우스 가져갔을 때 click 가능 표시 */
}

#writeButtonDiv {
	margin-right: 10%;
	float: right;
}

.pagerGroup {
	font-family: 'Jeju Gothic', serif;
	size: 20%;
}

.pagerGroup a:link {
	color: black;
	text-decoration: none;
}

.pagerGroup a:visited {
	color: black;
	text-decoration: none;
}

.pagerGroup a:hover {
	color: black;
	text-decoration: none;
}

.pagerGroup a:active {
	background-color: #4CAF50;
	color: white;
	border-radius: 5px;
}

.pagerGroup a:hover:not (.active ) {
	background-color: #ddd;
	border-radius: 5px;
}
</style>
<script type="text/javascript">
$(function() {
	$(".clickable-row").on("click", function(event) {
		$(location).attr("href", $(this).data("href"));
	});
});
</script>

</head>
<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
		<c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />
	<div id="pageContainer">
		

		<div>

			<div class="container">
				<div class="col-sm-12"></div>
				<div class="hidden-xs">
					<table class="table table-hover boardList" style="text-align: center;">
						<thead>
							<tr>
								<th class="tablerow">번호</th>
								<th class="tablerow">제목</th>
								<th class="tablerow">작성자</th>
								<th class="tablerow">작성일</th>
								<th class="tablerow">조회수</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="m_fboard" items="${m_fboard}">
								<c:if test="${m_fboard.deleted eq false }">
									<tr class="clickable-row" data-href="/ssola2/freeboard/detail.action?articleNo=${ m_fboard.articleNo }&pageno=${ pageno }">
										<td>${ m_fboard.articleNo }</td>
										<td>${ m_fboard.articleTitle }</td>
										<td id="writer">${ m_fboard.id }</td>
										<td>
											<div>
												<fmt:formatDate var="dateString"
													value="${ m_fboard.regDate }" type="date"
													pattern="yyyy년MM월dd일 HH:mm:ss" />
												${dateString}
											</div>
										</td>
										<td><span class="label label-primary">${ m_fboard.readCount }</span>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<br />
				<br />
			</div>
		</div>

		<!-- pager 구현 -->

		<div style="text-align: center" class="pagerGroup">${ pager }</div>
		<!-- ends of pager -->

	</div>


	<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>