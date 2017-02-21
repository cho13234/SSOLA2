<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- comment -->
		<table class="table table-condensed" style="border:1; width:70%">
			<c:forEach var="item" items="${freeBoardComment}">
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
</body>
</html>