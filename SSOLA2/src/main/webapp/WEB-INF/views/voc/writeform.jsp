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
				'articleContent',
				{//해당 이름으로 된 textarea에 에디터를 적용
					width : '100%',
					height : '400px',
					'filebrowserUploadUrl' : '/ssola2/resources/ckeditor/upload.jsp?'
							+ 'realUrl=http://localhost:8888/ssola2/resources/uploadImages/'
							+ '&realDir=/resources/uploadImages'
				/*  filebrowserUploadUrl: '${pageContext.request.contextPath}/file/ckeditorImageUpload.do'	 */
				/* filebrowserImageUploadUrl: '/resources/uploadImages' //여기 경로로 파일을 전달하여 업로드 시킨다. */
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
<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
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
					 <input class="form-control" type="text" name="articleTitle" style="width: 100%; font-family: 'Jeju Gothic', serif;"
						placeholder="게시글의 제목을 입력하세요." />
				</div>
				<br />
				<!-- id -->
				<div class="input-group">
					<span class="input-group-addon"><i
						class="glyphicon glyphicon-user"></i></span>
					<input class="form-control" style="width: 100%; font-family: 'Jeju Gothic', serif;" name="id" 
					value='${ sessionScope.loginuser.id }' readonly />
				</div>
				<br />
				<!-- 비밀글 여부 -->
				<div id ="securebox" style= "font-family: 'Jeju Gothic', serif;">
				<label class="checkbox-inline">
     			 <input type="checkbox" id="secure" name="secure" checked ="checked" >★비밀글 등록 여부
    			</label>
				</div>
				<br/>
				<label for="sel1">Category:</label>
     				 <select class="form-control" id="sel1" name="category" style="font-family: 'Jeju Gothic', serif;">
				        <option value="Q&A">Q&A</option>
				        <option value="건의사항">건의사항</option>
				        <option value="고객의 소리">고객의 소리</option>
				      </select>
				<br/>
				      
				<!-- articleContent -->
				<span class="label label-default">Content</span>
				<br/>
				<div>
					<!-- textarea -->
					<textarea class="form-control" style='width: 100%; resize: none'
						id="editor" name="articleContent" cols="76" rows="15"></textarea>
				</div>
				<br/><br/><br/>
				
				
				<br /> <br /> <br /><br/>
				<div class="buttons">
					<!-- 아래 a 링크는 input type='submit' 버튼을 누르는 효과 발생 -->
					<a class="btn btn-default"
						style="font-family: 'Jeju Gothic', serif;"
						href="javascript:document.forms[0].submit();">Submit</a>
					&nbsp;&nbsp; <a class="btn btn-default"
						style="font-family: 'Jeju Gothic', serif;"
						href="/ssola2/voc/list.action">List</a>
				</div>
			</form>
		</div>
	</div>

	<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>