<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>마이페이지 메인</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	 $('#submit-link').click(function(event) {
		$('#form_submit').submit();//<form 을 서버로 전송하는 명령
	});
	
	function readURL(input) {

 	    if (input.files && input.files[0]) {
 	        var reader = new FileReader();

 	        reader.onload = function (e) {
 	            $('#blah').attr('src', e.target.result);
 	        }

 	        reader.readAsDataURL(input.files[0]);
 	    }
 	}

 	$("#imgInp").change(function(){
 	    readURL(this);
 	});
});
</script>

</head>

<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />
	<c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />

	<%-- <c:forEach items="${p_list}" var="p_list"> --%>


	<div class="container">


		<div class="row">

			<div
				class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad">


				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">${p_list.nickname}님의프로필</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3 col-lg-3 " align="center">
								<br>
								<br> <img id="blah" src="#" alt="your image" style="width : 80px; height: 60px;" /><br>
								<br>


							</div>


							<div class=" col-md-9 col-lg-9 ">
								<form id = "form_submit" action="upload.action" method="post" enctype="multipart/form-data">
								<table class="table table-user-information">
									<tbody>
										<tr>
											<td>아이디</td>
											<td id="f_did">${p_list.id}</td>
										</tr>
										<tr>
											<td>이메일</td>
											<td>${p_list.email}</td>
										</tr>
										<tr>
											<td>전화번호</td>
											<td>${p_list.phonenumber}</td>
										</tr>
										<tr>
											<td>생년월일</td>
											<td>${p_list.birth}</td>
										</tr>
										<tr>
											<td>Gender</td>
											<td><c:choose>
													<c:when test='${p_list.gender eq "0"}'>
														남자
													</c:when>
													<c:when test='${p_list.gender eq "1"}'>
														여자
													</c:when>
												</c:choose></td>
										</tr>
										<tr>
											<td>자기소개</td>
											<td><textarea id="contenttext" name="contenttext"
													class="form-control" rows="5">
													${p_list.description}
												</textarea></td>
										</tr>
										 
										<input type="file" id = "imgInp" name="file" style="width: 580px; height: 25px" />
										 
									</tbody>
								</table>
								 <button id = "submit-link" class="btn btn-default">작성완료</button>
								</form>
							</div>
						</div>
					</div>



				</div>
			</div>
		</div>

	</div>
	<%-- 	</c:forEach> --%>
	<br>
	<br>
	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
