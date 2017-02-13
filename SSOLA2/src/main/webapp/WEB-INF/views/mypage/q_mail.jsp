<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 - 에디터 메일</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript"
	src="/ssola2/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {

		CKEDITOR
				.replace(
						'mailEditor',
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
									+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
									+ '&realDir=/resources/uploadImages'
	
						});

	
		CKEDITOR.on('dialogDefinition', function(ev) {
			var dialogName = ev.data.name;
			var dialogDefinition = ev.data.definition;

			switch (dialogName) {
			case 'image': //Image Properties dialog
				//dialogDefinition.removeContents('info');
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				break;
			}
		});

	});	
</script>
<script type="text/javascript">


	/* $(function() {
		$("#complete_sendEmail").on("click", function(event) {

			if (confirm("전송하시겠습니까?")) {

				var tabledelete = $("#tabledelete").val();

				$.ajax({
					type : "post",
					url : "/ssola2/mypage/complete_sendEditor.action",
					data : {
						tabledelete : $("#tabledelete").val()
					},
					success : function() {
						alert("이메일 전송 완료");
					}
				});
			}
			;
		});
	});  */
	$(function() {
		$("#complete_sendEmail").on("click", function(event) {
			$("#complete_sendEmailForm").submit();
		});
	});
	
</script>

</head>
<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
	<c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />
<div id ="scrap_container" style="margin-left: 20%; margin-right:20%; width: 50%;">
	<form action="complete_sendEditor.action" method="post" id="complete_sendEmailForm">
	
		<div class="input-group" >
			<span class="input-group-addon">Title</span> 
				<input class="form-control" type="text" name="articleTitle" style="width: 100%;" placeholder="이메일 제목을 입력하세요." />
		</div>
		<br />

		<div class="input-group">
			<span class="input-group-addon">
				<i class="glyphicon glyphicon-user"></i>
			</span> 
			<input class="form-control" style="width: 100%;" name="email" value='${ sessionScope.loginuser.email }'readonly="true"/>
		</div>
		<br />
		
		<!-- <div class="input-group">
			<span class="input-group-addon">
				<i class="glyphicon glyphicon-user"></i>
			</span> 
			<input class="form-control" style="width: 100%;" name="id" />
		</div> -->
		<br/>
		<div class="form-group">			
			<textarea class="form-control" style="width: 100%; resize: none" id="editor1" name="mailEditor" cols="76" rows="15" placeholder="내용을 입력하세요."></textarea>
		</div>
		<br /> <br /> <br />

			<div class="buttons">
				<a class="btn btn-default" id="complete_sendEmail">전송</a>
				&nbsp;&nbsp; 				
				
				<a class="btn btn-default" href="ssola2/mypage/mypage_main.action">취소</a>
			</div>


			<!-- <div class="buttons" style="margin-left:20%">
			아래 a 링크는 input type='submit' 버튼을 누르는 효과 발생
			<a class="btn btn-default" id="complete_sendEmail">전송</a>
			<input type="button" id="complete_sendEmail"  value="전송"/> -->
			
		</form>	
		</div>
	


	<br>
	<br>
	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>