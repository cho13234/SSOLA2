<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<title>글쓰기</title>
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


</style>
<script type="text/javascript">
	$(function() { 
	
//주소 찾기 
		//realurl server open시 변경하여야함.
		CKEDITOR
		.replace(
				'mainImage',
				{//해당 이름으로 된 textarea에 에디터를 적용
					width : '100%',
					height : '400px',
					'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
							+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
							+ '&realDir=/resources/uploadImages'
				/*  filebrowserUploadUrl: '${pageContext.request.contextPath}/file/ckeditorImageUpload.do'	 */
				/* filebrowserImageUploadUrl: '/resources/uploadImages' //여기 경로로 파일을 전달하여 업로드 시킨다. */
				});
		
		CKEDITOR
		.replace(
						'section1.mainTag',
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
									+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
									+ '&realDir=/resources/uploadImages'
						/*  filebrowserUploadUrl: '${pageContext.request.contextPath}/file/ckeditorImageUpload.do'	 */
						/* filebrowserImageUploadUrl: '/resources/uploadImages' //여기 경로로 파일을 전달하여 업로드 시킨다. */
						});

		CKEDITOR
		.replace(
						'section2.mainTag',
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
									+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
									+ '&realDir=/resources/uploadImages'//여기 경로로 파일을 전달하여 업로드 시킨다.
						});

		CKEDITOR
		.replace(
						'section3.mainTag',
		
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
									+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
									+ '&realDir=/resources/uploadImages' //여기 경로로 파일을 전달하여 업로드 시킨다.
						});

		CKEDITOR
		.replace(
						'section4.mainTag',
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
									+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
									+ '&realDir=/resources/uploadImages' //여기 경로로 파일을 전달하여 업로드 시킨다.
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
		
		
		/* $("#postcodify").postcodify({
	        insertPostcode5 : "#postcode",
	        insertAddress : "#address",
	        insertDetails : "#details",
	        hideOldAddresses : false
	 	}); 
	//주소 입력
	$("#addressInsert").on("click", function(event) {
		if($("#postcode").val().length > 0 && $("#address").val().length > 0 
				&& $("#details").val().length > 0) {
			var builder = $("#_postcode").val() + " " + $("#address").val() + ", " + $("#details").val();
			$("address").val(builder);
			$("#modalCloseBtn").click();
		}
	}); */
	
	});
	
	
	
</script>
<body>
	<%-- <c:import url="/WEB-INF/views/include/header.jsp" /> --%>
	<br />
	<br />
	<div id="pageContainer">
		<div id="inputcontent">
			<br /> <br />
			<div class="inputsubtitle">새로운 글 쓰기</div>
			<br /> <br />

			<form action="write.action" method="post">
			
				<!-- title -->
				<div class="input-group">
					<span class="input-group-addon">Title</span>
					 <input class="form-control" type="text" name="articleTitle" style="width: 100%;"
						placeholder="게시글의 제목을 입력하세요." />
				</div>
				<br />
				<!-- id -->
				<div class="input-group">
					<span class="input-group-addon"><i
						class="glyphicon glyphicon-user"></i></span>
					<input class="form-control" style="width: 100%;" name="id" 
					value='${ sessionScope.loginuser.id }' readonly />
				</div>
				<br />
				<!-- mainImage -->
				<span class="label label-default">Main Image</span>
				<br/>
				<div>
					<!-- textarea -->
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor" name="mainImage" cols="76" rows="15"></textarea>
				</div>
				<br/><br/><br/>
				
				<!-- section1 -->
				<div class="form-group">
					<label class="radio-inline">
						<input type="radio" name="section1.category" value="혼아">혼아</label>
					<label class="radio-inline">
						<input type="radio" name="section1.category" value="혼점">혼점</label>
					<label class="radio-inline">
						<input type="radio" name="section1.category" value="혼디">혼디</label>
					<label class="radio-inline">
						<input type="radio" name="section1.category" value="혼저">혼저</label>
					<label class="radio-inline">
						<input type="radio" name="section1.category" value="혼술">혼술</label>
				<br/><br/>
					<!-- address -->
					<div class="input-group">
						<span class="input-group-addon">Address</span>
						<input class="form-control" style="width: 100%;" id="address" name="section1.address" type="text"
						placeholder="section1의 주소을를입력하세요." />
					</div>
					<br/>
					<div class="input-group">
						<span class="input-group-addon">StoreName</span>
						<input class="form-control" style="width: 100%;" id="storeName" name="section1.storeName" type="text"
						placeholder="section1의 매장명을 입력하세요." />
					</div>
					
					<br/>
					<span class="label label-default">Section1</span>
					<br/>
					<!-- textarea -->
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor1" name="section1.mainTag" cols="76" rows="15"></textarea>
				</div>
				<br/><br/><br/>
				
				<!-- section2 -->
				<div class="form-group">
					<label class="radio-inline">
						<input type="radio" name="section2.category" value="혼아">혼아</label>
					<label class="radio-inline">
						<input type="radio" name="section2.category" value="혼점">혼점</label>
					<label class="radio-inline">
						<input type="radio" name="section2.category" value="혼디">혼디</label>
					<label class="radio-inline">
						<input type="radio" name="section2.category" value="혼저">혼저</label>
					<label class="radio-inline">
						<input type="radio" name="section2.category" value="혼술">혼술</label>
					<br/><br/>
					<!-- address -->
					<div class="input-group">
						<span class="input-group-addon">Address</span>
						<input class="form-control" style="width: 100%;" name="section2.address" 
						placeholder="section2의 주소을를입력하세요." />
					</div>
					<br/>
					<div class="input-group">
						<span class="input-group-addon">StoreName</span>
						<input class="form-control" style="width: 100%;" id="storeName" name="section2.storeName" type="text"
						placeholder="section2의 매장명을 입력하세요." />
					</div>
					<br/>
					<!-- textarea -->
					<span class="label label-default">Section2</span>
					<br/>
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor2" name="section2.mainTag" cols="76" rows="15"></textarea>
				</div>
				<br/><br/><br/>
			
				<!-- section3 -->
				<div class="form-group">
					<label class="radio-inline">
						<input type="radio" name="section3.category" value="혼아">혼아</label>
					<label class="radio-inline">
						<input type="radio" name="section3.category" value="혼점">혼점</label>
					<label class="radio-inline">
						<input type="radio" name="section3.category" value="혼디">혼디</label>
					<label class="radio-inline">
						<input type="radio"	name="section3.category" value="혼저">혼저</label>
					<label class="radio-inline">
						<input type="radio" name="section3.category" value="혼술">혼술</label>
					<br/><br/>
					<!-- address -->
					<div class="input-group">
						<span class="input-group-addon">Address</span>
						<input class="form-control" style="width: 100%;" name="section3.address"
						 placeholder="section3 주소을를입력하세요." />
					</div>
					<br/>
					<div class="input-group">
						<span class="input-group-addon">StoreName</span>
						<input class="form-control" style="width: 100%;" id="storeName" name="section3.storeName" type="text"
						placeholder="section3의 매장명을 입력하세요." />
					</div>
					<br/>
					<!-- textarea -->
					<span class="label label-default">Section3</span>
					<br/>
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor3" name="section3.mainTag" cols="76" rows="15"></textarea>
				</div>
				<br/><br/><br/>
			
				<!-- section4 -->
				<div class="form-group">
					<label class="radio-inline">
						<input type="radio" name="section4.category" value="혼아">혼아</label>
					<label class="radio-inline">
						<input type="radio" name="section4.category" value="혼점">혼점</label>
					<label class="radio-inline">
						<input type="radio" name="section4.category" value="혼디">혼디</label>
					<label class="radio-inline">
						<input type="radio" name="section4.category" value="혼저">혼저</label>
					<label class="radio-inline">
						<input type="radio" name="section4.category" value="혼술">혼술</label>
					<br/><br/>
					<!-- address -->
					<div class="input-group">
						<span class="input-group-addon">Address</span>
						<input class="form-control" style="width: 100%;" name="section4.address" 
					 placeholder="section4의 주소을를입력하세요." />
					</div>
					<br/>
					<div class="input-group">
						<span class="input-group-addon">StoreName</span>
						<input class="form-control" style="width: 100%;" id="storeName" name="section4.storeName" type="text"
						placeholder="section4의 매장명을 입력하세요." />
					</div>
					<br/>
					<!-- textarea -->
					<span class="label label-default">Section4</span>
					<br/>
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor4" name="section4.mainTag" cols="76" rows="15"></textarea>
				</div> 
				<br /> <br /> <br /><br/>
				<div class="buttons">
					<!-- 아래 a 링크는 input type='submit' 버튼을 누르는 효과 발생 -->
					<a class="btn btn-default"
						style="font-family: 'Jeju Gothic', serif;"
						href="javascript:document.forms[0].submit();">Submit</a>
					&nbsp;&nbsp; <a class="btn btn-default"
						style="font-family: 'Jeju Gothic', serif;"
						href="/ssola2/main/main.action">List</a>
				</div>
			</form>
		</div>
	</div>

	<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>