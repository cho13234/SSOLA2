<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원정보 수정</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/ssola2/resources/scripts/mypage_edit.js"></script>

<style type="text/css">
.error {
	color: red;
	font-size: 8pt;
	font-style: bold
}
</style>


</head>


<body>


<div id="pageContainer">
	
		<c:import url="/WEB-INF/views/include/header.jsp" />
		<c:import url="/WEB-INF/views/mypage/mypage_header.jsp"/>
		<br>
		<div id="inputcontent" class="form-group col-sm-12">
			<br /><br />
		    <div id="inputmain" style="text-align:center" class="col-sm-4 col-sm-offset-4">
		        <div class="inputsubtitle"></div>
		        
		        <form:form id="edit" action="update_loginedit.action" method="post" cssClass="form-horizontal" modelAttribute="customer"><!-- 상대경로표시 -->
		       	<div class="form-group">
						<label for="id" class="control-label col-sm-3">ID</label>
						<div class="input-group">
							<form:input path="id" style="width:280px" maxlength="20" cssClass="form-control" readonly="true" value="${loginuser.id}"/>							
	                    </div>
	                    <br>
						               
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
					
					<!-- <div class="form-group">
						<label for="confirm" class="control-label col-sm-3">Confirm</label>
						<div class="input-group">
							<input type="password" id="confirm" name="confirm" placeholder="비밀번호와 동일하게" style="width:280px" maxlength="16" class="form-control"/>
						</div>
						<br>
						<div id="confirmMessage"></div>
					</div> -->
					
					<div class="form-group">
						<label for="nickname" class="control-label col-sm-3">Nickname</label>
						<div class="input-group">
							<form:input type="text" path="nickname" placeholder="2-15자리" style="width:280px" maxlength="15" cssClass="form-control" value="${loginuser.nickname}"/>
							<button type="button" id="nicknameCheckButton" class="btn btn-secondary">중복확인</button>
						</div>
						<br>
						<div id="nicknameMessage"></div>
						<form:errors path="nickname" cssClass="error"/>
					</div>
					
					<div class="form-group">
						<label for="email" class="control-label col-sm-3">Email</label>
						<div class="input-group">
							<form:input type="text" path="email" placeholder="@사이트주소까지" style="width:280px" maxlength="56" cssClass="form-control" value="${loginuser.email}"/><br>
						</div>
						<br>
						<div id="emailMessage"></div>
						<form:errors path="email" cssClass="error"/>
					</div>
					
					<div class="form-group">
						<label for="birth" class="control-label col-sm-3">Birth</label>
						<div class="input-group">
						
							<form:input type="text" path="birth" style="width:280px" cssClass="form-control" value="${loginuser.birth}" readonly="true" /><br>				
						
						
						</div>
						<br>						
					</div>
					
					<div class="form-group">
						<label for="gender" class="control-label col-sm-3">Gender</label>
						<div class="input-group">
							<c:choose>
								<c:when test= '${loginuser.gender eq "0" }'>
									<form:input type="Text" path="gender" value="남자" style="width:280px" cssClass="form-control" readonly="true"/>
								</c:when>
								<c:when test = '${loginuser.gender eq "1"}'>
									<form:input type="text" path="gender" value="여자" style="width:280px" cssClass="form-control" readonly="true"/>
								</c:when>
							</c:choose>
						</div>
					</div>
					
					
			        <div class="buttons">
			        	<a id="submitButton">
			        	<input type="submit" value="수정" style="height:25px"/>
			        						        		        		
						</a>
			        	<input type="button" value="취소" style="height:25px"
			        		onclick="location.href='mypage_main.action';" />			        	
			        </div>
		        </form:form>
		    </div>
		</div>
		<br><br>
		<c:import url="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>