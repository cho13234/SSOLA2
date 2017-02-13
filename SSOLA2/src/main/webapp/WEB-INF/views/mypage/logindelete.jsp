<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원탈퇴</title>

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

비밀번호 한 번 더 입력하게 하고 탈퇴로 할까...
<c:import url="/WEB-INF/views/include/header.jsp" />
<c:import url="/WEB-INF/views/mypage/mypage_header.jsp"/>
		<br>

<input type="button" id="loingdelete" style="width:200px;" value="${loginuser.id }"/>



<br><br>
		<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>