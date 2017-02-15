<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>voc</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />

<!-- Latest compiled and minified JavaScript -->
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
  .lockimage{
  width:15px;
  height:15px;
  }
  .clickable-row{
	cursor: pointer; 
	/* list에 마우스 가져갔을 때 click 가능 표시 */
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
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="pageContainer">
<div>
<c:if test="${!empty loginuser }">
<a href="write.action" class="btn btn-default" role="button">새로운 글쓰기</a>	
</c:if>
</div>
<div class="container">
        <div class="col-sm-12">
        	<c:if test="${ loginuser.userType }">
	        		<a id="writeButton" href="write.action" class="btn btn-primary visible-xs-block writeButton" style="margin-bottom: 10px">글쓰기</a>
	        </c:if>
	    </div>    		
        	<div class="hidden-xs">
				<table class="table table-hover boardList">
					<thead>
				    	<tr>
					        <th>번호</th>
					        <th>카테고리</th>
					        <th>작성자</th>
					        <th>제목</th>
					        <th>등록일</th>
					        <th>조회수</th>
				      	</tr>
				    </thead>
				    <tbody>
				    	<c:forEach var="storeNotice" items="${ storeNoticeList }">
				    	<tr class="clickable-row" data-href="detail.action?articleNo=${ voc.articleNo }&pageno=${ pageno }">
					        <td>${ storeNotice.articleNo }</td>
					        <td><font color="#29c7a4">${ storeNotice.storeName }</font></td>
					        <td>${ storeNotice.id }</td>
							<td>
							<c:choose>
								<c:when test="${ storeNotice.deleted }">
									<span style="color:gray" onclick="alert('삭제된 글입니다.')">
										${ storeNotice.articleTitle } [삭제된 글]
									</span>
								</c:when>
								<c:otherwise>
									${ storeNotice.articleTitle }
								</c:otherwise>
							</c:choose>
							</td>
					        <td>${ storeNotice.regDate }</td>
					        <td>
						        <span class="label label-primary">${ storeNotice.readCount }</span>
					        </td>
				        </tr>
				        </c:forEach>
				    </tbody>
				</table>
			</div>
			<div class="visible-xs-block">
				<table class="table table-hover boardList">
					<c:forEach var="storeNotice" items="${ storeNoticeList }">
						<tr class="clickable-row" data-href="detail.action?articleNo=${ storeNotice.articleNo }&pageno=${ pageno }&storeSearch=${ storeSearch }">
							<td id="miniTitle"><font color="#29c7a4">[${ storeNotice.storeName }]</font>&nbsp;${ storeNotice.articleTitle }</td>
							<td id="miniWriter">
								<div>${ storeNotice.id }</div>
								<span id="miniReadCount" class="label label-primary">${ storeNotice.readCount }</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br /><br />
		</div>
	
        <div id="bottomDiv" class="col-sm-12" style="text-align:center">
        	<c:choose>
        		<c:when test="${ list }">
        			${ pager }
        		</c:when>
        		<c:otherwise>
        			${ pager.toString() }
        		</c:otherwise>
        	</c:choose>
			
			<c:if test="${ loginuser.userType }">
        		<a id="writeButton" href="write.action" class="btn btn-primary hidden-xs writeButton">글쓰기</a>
        	</c:if>
		</div>
		</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>