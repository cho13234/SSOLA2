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

	$(".btn_addFriend").on("click", function(event) {

		if (confirm("친구 추가 하던지 말던지")) {
			/* var scrapNo = $("#scrapNo").val(); */

			$.ajax({
				type : "GET",
				url : "/ssola2/mypage/add_friend.action",
				data : {
					scrapNo : $("#scrapNo").val()
				},
				success : function() {
					alert("success!");
				}
			});
		};
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
							<h3 class="panel-title">${p_list.nickname }</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-3 col-lg-3 " align="center">
									<img alt="User Pic"
										src="http://babyinfoforyou.com/wp-content/uploads/2014/10/avatar-300x300.png"
										class="img-circle img-responsive">
								</div>

								<!--<div class="col-xs-10 col-sm-10 hidden-md hidden-lg"> <br>
                  <dl>
                    <dt>DEPARTMENT:</dt>
                    <dd>Administrator</dd>
                    <dt>HIRE DATE</dt>
                    <dd>11/12/2013</dd>
                    <dt>DATE OF BIRTH</dt>
                       <dd>11/12/2013</dd>
                    <dt>GENDER</dt>
                    <dd>Male</dd>
                  </dl>
                </div>-->
								<div class=" col-md-9 col-lg-9 ">
									<table class="table table-user-information">
										<tbody>
											<tr>
												<td>아이디</td>
												<td>${p_list.id}</td>
											</tr>
											<tr>
												<td>이메일</td>
												<td>${p_list.email}</td>
											</tr>
											<tr>
												<td>전화번호</td>
												<td>06/23/2013</td>
											</tr>
											<tr>
												<td>생년월일(성별)</td>
												<td>01/24/1988</td>
											</tr>
											<tr>
												<td>자기소개</td>
												<td>01/24/1988</td>
											</tr>

											<tr>
											<tr>
												<td>Gender</td>
												<td>Female</td>
											</tr>
											<tr>
												<td>Home Address</td>
												<td>Kathmandu,Nepal</td>
											</tr>
											<tr>
												<td>Email</td>
												<td><a href="mailto:info@support.com">info@support.com</a></td>
											</tr>
											<td>Phone Number</td>
											<td>123-4567-890(Landline)<br>
											<br>555-4567-890(Mobile)
											</td>

											</tr>

										</tbody>
									</table>
									<button id="btn_addFriend" type="button"
										class="btn btn-primary">친구 추가/삭제</button>

								</div>
							</div>
						</div>
						<div class="panel-footer">
							<a data-original-title="Broadcast Message" data-toggle="tooltip"
								type="button" class="btn btn-sm btn-primary"><i
								class="glyphicon glyphicon-envelope"></i></a> <span
								class="pull-right"> <a href="edit.html"
								data-original-title="Edit this user" data-toggle="tooltip"
								type="button" class="btn btn-sm btn-warning"><i
									class="glyphicon glyphicon-edit"></i></a> <a
								data-original-title="Remove this user" data-toggle="tooltip"
								type="button" class="btn btn-sm btn-danger"><i
									class="glyphicon glyphicon-remove"></i></a>
							</span>
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
</htm
										l>