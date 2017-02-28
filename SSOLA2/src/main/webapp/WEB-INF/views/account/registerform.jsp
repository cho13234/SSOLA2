<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8" />
	<title>사용자등록</title>

	<style type="text/css">
	.error { color: red; font-size: 8pt; font-style: bold }
	</style>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/ssola2/resources/scripts/account_registerform.js"></script>
	
</head>
<body>

	<div id="pageContainer">

		<c:import url="/WEB-INF/views/include/header.jsp" />
		<br>

		<div id="inputcontent" class="form-group col-sm-12">
		    <div id="inputmain" style="text-align:center" class="col-sm-4 col-sm-offset-4">
		        <form:form id="submitForm" action="register.action" method="post" role="form" cssClass="form-horizontal" modelAttribute="customer"><!-- 상대경로표시 -->
					<h2>회원가입</h2>
					<br>
					<div class="form-group">
						<label for="id" class="control-label col-sm-3">ID</label>
						<div class="input-group">
							<form:input path="id" placeholder="영문자 + 숫자 4-20자리(대소문자 구분)" autocomplete="off" style="width:280px" maxlength="20" cssClass="form-control"/>
							<button type="button" id="idCheckButton" class="btn btn-secondary">중복확인</button>
	                    </div>
	                    <br>
						<div id="idMessage"></div>
	                    <form:errors path="id" cssClass="error"/>
					</div>
					<div class="form-group">
						<label for="password" class="control-label col-sm-3">PW</label>
						<div class="input-group">
							<form:password path="password" placeholder="영문자 + 숫자 8-16자리(대소문자 구분)" style="width:280px" maxlength="16" cssClass="form-control"/><br>
						</div>
						<br>
						<div id="passwordMessage"></div>
						<form:errors path="password" cssClass="error"/>
					</div>
					<div class="form-group">
						<label for="confirm" class="control-label col-sm-3">Confirm</label>
						<div class="input-group">
							<input type="password" id="confirm" name="confirm" placeholder="비밀번호와 동일하게" style="width:280px" maxlength="16" class="form-control"/>
						</div>
						<br>
						<div id="confirmMessage"></div>
					</div>
					<div class="form-group">
						<label for="nickname" class="control-label col-sm-3">Nickname</label>
						<div class="input-group">
							<form:input type="text" path="nickname" placeholder="2-15자리" autocomplete="off" style="width:280px" maxlength="15" cssClass="form-control"/>
							<button type="button" id="nicknameCheckButton" class="btn btn-secondary">중복확인</button>
						</div>
						<br>
						<div id="nicknameMessage"></div>
						<form:errors path="nickname" cssClass="error"/>
					</div>
					<div class="form-group">
						<label for="email" class="control-label col-sm-3">Email</label>
						<div class="input-group">
							<form:input type="text" path="email" placeholder="@사이트주소까지" autocomplete="off" style="width:280px" maxlength="56" cssClass="form-control"/><br>
						</div>
						<br>
						<div id="emailMessage"></div>
						<form:errors path="email" cssClass="error"/>
					</div>
					<div class="form-group">
						<label for="birth" class="control-label col-sm-3">Birth</label>
						<div class="input-group">
							<form:input type="text" path="birth" placeholder="ex/1990-01-01" autocomplete="off" style="width:280px" maxlength="10" cssClass="form-control"/><br>
						</div>
						<br>
						<div id="birthMessage"></div>
						<form:errors path="birth" cssClass="error"/>
					</div>
					<div class="form-group">
						<label for="gender" class="control-label col-sm-3">Gender</label>
						<div class="input-group">
							<label class="radio-inline">
								<form:radiobutton path="gender" value="true" checked="checked" />남자
							</label>
							<label class="radio-inline">
								<form:radiobutton path="gender" value="false" />여자
							</label>
						</div>
					</div>
		        
		        	<br>
					<div class="buttons">
						<a id="submitButton" class="btn btn-success">등록</a>
						&nbsp;&nbsp;
						<a href="/ssola2/home.action" class="btn btn-danger">취소</a>
					</div>
		        </form:form>
		        
		    </div>
		    
		</div>
		<br><br>
		<c:import url="/WEB-INF/views/include/footer.jsp" />
		
	</div>

</body>
</html>
