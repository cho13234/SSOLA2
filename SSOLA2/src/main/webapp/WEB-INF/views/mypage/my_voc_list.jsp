<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>my_voc</title>
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

#pageBlock {
	padding: 3%, 3%, 3%, 3%;
}

.pagerGroup {
	font-family: 'Jeju Gothic', serif;
	size: 20%;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}

#titleOfthepage {
	font-family: 'Noto Sans KR', sans-serif;
	margin-left: 20%;
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
								<th class="tablerow">카테고리</th>
								<th class="tablerow">제목</th>
								<th class="tablerow">작성자</th>
								<th class="tablerow">등록일</th>
								<th class="tablerow">비밀글</th>
								<th class="tablerow">조회수</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="m_voc" items="${m_voc}">
								<c:if test="${m_voc.deleted eq false }">
									<tr class="clickable-row" data-href="/ssola2/voc/detail.action?articleNo=${ m_voc.articleNo }&pageno=${ pageno }">
										<td>${ m_voc.articleNo }</td>
										<td><m_voc color="#29c7a4">${ m_voc.category }</font></td>
										<td>${ m_voc.articleTitle }</td>
										<td id="writer">${ m_voc.id }</td>
										<td>
											<div>
												<fmt:formatDate var="dateString" value="${ m_voc.regDate }"
													type="date" pattern="yyyy년MM월dd일 HH:mm:ss" />
												${dateString}
											</div>
										</td>

										<!-- 비밀글  -->
										<td><c:choose>
												<c:when test="${m_voc.secure}">
													<img src="/ssola2/resources/images/lock.png">
												</c:when>
												<c:otherwise>
													<img src="/ssola2/resources/images/unlock.png">
												</c:otherwise>
											</c:choose></td>

										<td><span class="label label-primary">${ m_voc.readCount }</span>
										</td>
									</tr>
								</c:if>
							</c:forEach>


						</tbody>
					</table>
				</div>

				<br /> <br />
			</div>
		</div>

		<!-- pager 구현 -->

		<div style="text-align: center" class="pagerGroup">${ pager }</div>
		<!-- ends of pager -->

	</div>





	<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>