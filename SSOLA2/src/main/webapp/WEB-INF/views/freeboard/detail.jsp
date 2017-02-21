<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<title>freeBoard상세보기</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.postcodify/3.4.1/search.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="//cdn.ckeditor.com/4.6.1/full/ckeditor.js"></script> -->
<script src="/ssola2/resources/ckeditor/ckeditor.js"></script>


<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/kopubbatang.css);
@import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

#inputcontent {
	
	margin-left: 10%;
	width: 80%;
}

.inputsubtitle {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 25pt;
	font-weight: bold;
	color: #4d4d4d;
	margin: auto;
}

.buttons {
	text-align: center;
}


#articleContent {
	margin: 1px auto;
	/* width: 1000px; */
	height: 100%;
	/* resize: none; */
	padding: 10px 10px 10px 10px;
}
#contentGroup{
border: 1px solid #bdbcbc;
border-radius: 5px;
padding: 5% 5% 5% 5%;
}
#contentTitle{
border-bottom :  1px solid #bdbcbc;
padding: 1% 1% 1% 1%;
font-family: 'Jeju Gothic', serif;
font-size:20pt;
}
#contentSubtitle{
padding: 1% 1% 1% 1%;
}

#writer{
font-weight: bold;
font-size:10pt;
margin:auto;
font-color:#404040;
}
#regDate{
margin:auto;
font-size:10pt;
margin:auto;
font-color:#606060;
float:right;
}

.secureImage{
width:1%;
margin:auto;
}


</style>
<script type="text/javascript">
</script>
<body>
<c:import url="/WEB-INF/views/include/header.jsp" />
	<br />
	<br />
	<div id="pageContainer">
		<div id="inputcontent">
			<br /> <br />
			<div class="inputsubtitle">상세보기</div>
			<br /> <br /><br /> <br />
	<!-- Content -->
		<div id="contentGroup">
			<div id="contentTitle">
				<%-- <span class="input-group-addon">Title</span>
				<input class="form-control" type="text" name="articleTitle" style="width: 100%; font-family: 'Jeju Gothic', serif;"
				value='${ voc.articleTitle }' readonly /> --%>
				<span style="width: 100%; ">${ freeBoard.articleTitle }</span>
			</div>
			<br/>
		      	
		      	
		      	<div id="contentSubtitle" >
		      	<span  id="writer" >[ ${freeBoard.id } ]</span>&nbsp;&nbsp;
		      	<strong id="regDate">registered Date:
		      	<fmt:formatDate var="dateString" value="${ freeBoard.regDate }" type="date" pattern="yyyy년MM월dd일  HH:mm:ss" />
				${dateString}
		      	</strong> 
		      	</div>
		      	
		      	<br/><br/><br/>
		      	<div id="articleContent" style="width:100%; height:100%;">
		      	${ freeBoard.articleContent}
		      	</div>
		  </div>
		  <br/><br/><br/><br/><br/><br/>
		     <!-- END GRID 관리자 수정 , 삭제 버튼 -->
		
		
		
		<div class="buttons">
		<c:choose>
			<c:when test="${loginuser.userType }">
				<!-- 관리자일 경우 -->
				<a class="btn btn-default" style="font-family: 'Jeju Gothic', serif;"
						href="/ssola2/freeboard/delete.action?articleNo=${freeBoard.articleNo}">delete</a>
			</c:when>
			<c:otherwise>
				<c:if test="${ loginuser.id eq freeBoard.id }">
				<!-- 작성자 일 경우 -->
					<a class="btn btn-default" style="font-family: 'Jeju Gothic', serif;"
						href="/ssola2/freeboard/edit.action?articleNo=${freeBoard.articleNo}">Update</a>
		
					&nbsp;&nbsp; <a class="btn btn-default"
						style="font-family: 'Jeju Gothic', serif;"
						href="/ssola2/freeboard/delete.action?articleNo=${freeBoard.articleNo}">delete</a>
				</c:if>
			</c:otherwise>
		</c:choose>	
			&nbsp;&nbsp; <a class="btn btn-default"
				style="font-family: 'Jeju Gothic', serif;"
				href="/ssola2/freeboard/list.action">List</a>
		</div>
		<!-- 여기서 부터 코맨트 입니당 ㅎㅎ -->
		<div>
			<table style="border:1; width:70%">
			<c:forEach var="freeBoardComment" items="${freeBoardComment}">
			<tr>
				<td>
				${ freeBoardComment.id }
				( <fmt:formatDate value = "${ freeBoardComment.regDate}" pattern = "yyyy-MM-dd HH:mm:ss" />)
				<br>
				${ freeBoardComment.commentContent }
				</td>
			</tr>
			</c:forEach>
			</table>

		</div>	
	</div>
</div>

<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>