<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>비밀번호 찾기</title>
	
</head>
<body>	
	<div id="pageContainer">
	
		<c:import url="/WEB-INF/views/include/header.jsp" />
		
		<div id="inputcontent">
			<br /><br />
		    <div id="inputmain" style="text-align:center">
		        <form id="submitForm" action="findpassword.action" method="post" role="form" class="form-horizontal">
					<h2>Login</h2>
						<div class="input-group col-sm-4 col-sm-offset-4">
							<span class="input-group-addon">아이디</span>
							<input type="text" name="id" class="form-control"/>
						</div>
						<br>
						<div class="input-group col-sm-4 col-sm-offset-4">
							<br>
							<span class="input-group-addon">이메일</span>
							<input type="text" name="email" class="form-control"/>
						</div>
					<br>
					<div class="buttons">
						<a id="submitButton" class="btn btn-primary">비밀번호 찾기</a>
					</div>
		        </form>
		        
		        <script type="text/javascript">
					$(function() {
						$("#submitButton").on("click", function(event) {
							$("#submitForm").submit();
						});
					});
				</script>
		    </div>
		</div>
		
		<c:import url="/WEB-INF/views/include/footer.jsp" />
	
	</div>

</body>
</html>