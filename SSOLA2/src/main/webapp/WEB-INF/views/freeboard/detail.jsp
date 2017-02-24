<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<title>freeBoard상세보기</title>
</head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.postcodify/3.4.1/search.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="//cdn.ckeditor.com/4.6.1/full/ckeditor.js"></script> -->
<script src="/ssola2/resources/ckeditor/ckeditor.js"></script>


<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/kopubbatang.css);

@import url(http://fonts.googleapis.com/earlyaccess/hanna.css);

@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);

@importurl('https://fonts.googleapis.com/css?family=Annie+Use+Your+Telescope');

@import url('https://fonts.googleapis.com/css?family=Inconsolata');

@import url('https://fonts.googleapis.com/css?family=Nunito');

#inputcontent {
	margin-left: 10%;
	width: 80%;
}

.inputsubtitle {
	font-family: 'Annie Use Your Telescope', cursive;
	font-size: 25pt;
	font-weight: bold;
	color: #4d4d4d;
	margin: auto;
}

.buttons {
	text-align: center;
}

#articleContent {
	margin: 1px auto;
	/* width: 1000px; */
	height: 100%;
	/* resize: none; */
	padding: 10px 10px 10px 10px;
}

#contentGroup {
	border: 1px solid #bdbcbc;
	border-radius: 5px;
	padding: 5% 5% 5% 5%;
}

#contentTitle {
	border-bottom: 1px solid #bdbcbc;
	padding: 1% 1% 1% 1%;
	font-family: 'Jeju Gothic', serif;
	font-size: 20pt;
}

#contentSubtitle {
	padding: 1% 1% 1% 1%;
}

#writer {
	font-weight: bold;
	font-size: 10pt;
	margin: auto;
	font-color: #404040;
}

#regDate {
	margin: auto;
	font-size: 10pt;
	margin: auto;
	font-color: #606060;
	float: right;
}

.secureImage {
	width: 1%;
	margin: auto;
}

.idandregDate{
font-family: 'Inconsolata', monospace;

}
.idandContent{
font-family: 'Inconsolata', monospace;
}
</style>
<script type="text/javascript">

function addComment(){
	//textarea에 content없을 경우... 글쓰라고 alert...
	if($('#commentContent').val() == '') 
		{
        alert("한줄 댓글의 내용은 필수 입력입니다.");
        $('#commentContent').focus();
  		}else{
  		 $('#commentAddButton').attr('disabled', 'disabled');
	 $.ajax({
			type : "post",
			url : "commentWrite.action",
			data : {
				commentId: $('#commentId').val(),
				articleNo: $('#articleNo').val(),
				commentContent : $('#commentContent').val()
					},
			success: function(result){
				$('#commentContent').val(''); // 내용 비우기
                // 다시 클릭이 가능하게끔
                $('#commentAddButton').attr("disabled", false);
				$("#commentList").html(result);
				
					}
		});  
	}
};

function deleteComment(commentNo){
	
	  if (!confirm("삭제하시겠습니까?")) {
	       
	  } 
	 $.ajax({
			type : "get",
			url : "commentDelete.action",
			data : {
				"commentNo" : commentNo
			},
			error: function(error) {
              //Ajax not successful: show an error
              alert('An error occured while deleting the comment!');
          },
			success: function(result){
				
				$("#commentRow_"+commentNo).remove();
				
			},
			complete: function(){
				alert('댓글이 삭제되었습니다.');
			}
			
		});  
	}

$(function() {
	
	$('#commentAddButton').click(function (event) {
	addComment();
	});

	$('.commentEditViewClass').click(function(event){
		event.preventDefault();
		var $target = event.target;
		var commentNo = event.target.id.split("_")[1];
		$('#commentEditRow_'+ commentNo).toggle('swing');
	});
	
	$('.commentEditConfirmClass').click(function (event) {
		event.preventDefault();
		var $target = event.target;
		var commentNo = event.target.id.split("_")[1];
		editComment(commentNo);
	});
	
	$('.commentDeleteClass').click(function (event) {
		event.preventDefault();
		var $target = event.target;
		var commentNo = event.target.id.split("_")[1];
		deleteComment(commentNo);
	});
	
	$('.cancelContfirmClass').click(function (event) {
		event.preventDefault();
		var $target = event.target;
		var commentNo = event.target.id.split("_")[1];
		$('#commentEditRow_'+ commentNo).hide();
	});
});
	
function editComment(){
	
	//textarea에 content없을 경우... 글쓰라고 alert...
	
	 $.ajax({
			type : "post",
			url : "commentEdit.action",
			data : {
				
				"commentContents" : contents,
				"commentNo" : commentNo
			},
			success: function(result){
				$("#commentList").html(result);
				
			},
			complete: function(){
				alert('댓글이 수정되었습니다..');
			}
		});  
	}
	




</script>
<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
	<br />
	<br />
	<div id="pageContainer">
		<div id="inputcontent">
			<br /> <br />
			<div class="inputsubtitle">상세보기</div>
			<br /> <br />
			<br /> <br />
			<!-- Content -->
			<div id="contentGroup">
				<div id="contentTitle">
					<%-- <span class="input-group-addon">Title</span>
				<input class="form-control" type="text" name="articleTitle" style="width: 100%; font-family: 'Jeju Gothic', serif;"
				value='${ voc.articleTitle }' readonly /> --%>
					<span style="width: 100%;">${ freeBoard.articleTitle }</span>
				</div>
				<br />


				<div id="contentSubtitle">
					<span id="writer">[ ${freeBoard.id } ]</span>&nbsp;&nbsp; <strong
						id="regDate">registered Date: <fmt:formatDate
							var="dateString" value="${ freeBoard.regDate }" type="date"
							pattern="yyyy년MM월dd일  HH:mm:ss" /> ${dateString}
					</strong>
				</div>

				<br />
				<br />
				<br />
				<div id="articleContent" style="width: 100%; height: 100%;">
					${ freeBoard.articleContent}</div>
			</div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<br />
			<!-- END GRID 관리자 수정 , 삭제 버튼 -->



			<div class="buttons">
				<c:choose>
					<c:when test="${loginuser.userType }">
						<!-- 관리자일 경우 -->
						<a class="btn btn-default"
							style="font-family: 'Jeju Gothic', serif;"
							href="/ssola2/freeboard/delete.action?articleNo=${freeBoard.articleNo}">delete</a>
					</c:when>
					<c:otherwise>
						<c:if test="${ loginuser.id eq freeBoard.id }">
							<!-- 작성자 일 경우 -->
							<a class="btn btn-default"
								style="font-family: 'Jeju Gothic', serif;"
								href="/ssola2/freeboard/edit.action?articleNo=${freeBoard.articleNo}">Update</a>
		
					&nbsp;&nbsp; <a class="btn btn-default"
								style="font-family: 'Jeju Gothic', serif;"
								href="/ssola2/freeboard/delete.action?articleNo=${freeBoard.articleNo}">delete</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp; <a class="btn btn-default"
					style="font-family: 'Jeju Gothic', serif;"
					href="/ssola2/freeboard/list.action">List</a>
			</div>
			
			<br/>

			<!-- 여기서 부터 코맨트 입니당 ㅎㅎ -->
			<!-- 댓글 목록이 출력될 영역 -->
			<div id="commentList">
				<!-- 여기에 뿌려줌 ㅋㅋ -->
				<table class="table table-condensed" style=" margin:5% auto; width:80%">
					<c:forEach var="freeboardcomment" items="${freeboardcomments}">
					<tr id="commentRow_${freeboardcomment.commentNo}">
						<td>
						<input type="hidden" id="commentNo_${freeboardcomment.commentNo}" name="commentNo" value="${ freeboardcomment.commentNo }"/>
						<span class="idandregDate">${ freeboardcomment.id }</span>
						<span class="idandregDate">( <fmt:formatDate value = "${ freeboardcomment.regDate}" pattern = "yyyy-MM-dd HH:mm:ss" />)
						</span>
						<br/>
						<span style="font-family: 'Nunito', sans-serif;">
						${ freeboardcomment.commentContent }</span>
						</td>
						<td>
						<c:choose>
						<c:when test="${loginuser.userType }">
						<input type="button" value="Delete" id="commentDeleteButton_${freeboardcomment.commentNo }" 
						class="commentDeleteClass" />
						</c:when>
						<c:otherwise>
						<c:if test="${ loginuser.id eq freeBoard.id }">
						<input type="button" value="Edit" id="commentEditViewButton_${freeboardcomment.commentNo }" class="commentEditViewClass"/>
						<input type="button" value="Delete" id="commentDeleteButton_${freeboardcomment.commentNo }" 
						class="commentDeleteClass" />
						</c:if>
						</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<!-- COMMENT 수정 -->
					<tr id="commentEditRow_${freeboardcomment.commentNo}" style='display: none'>
					<td>
						<input type="hidden" id="commentNo_${freeboardcomment.commentNo}" name="commentNo" value="${ freeboardcomment.commentNo }"/>
						<input type="hidden" id="commentId_${freeboardcomment.id}" name="id" value="${ freeboardcomment.id }"/>
						<span class="idandContent">Content:</span><br/>
						<textarea id="commentContent_${freeboardcomment.commentContent}" rows="3" cols="2" style="resize:none"></textarea>
					</td>
					<td>
						<input type="button" value="Confirm"  id='commentEditConfirmButton_${freeboardcomment.commentNo }' class="commentEditConfirmClass"/>
						<input type="button" value="cancel" id='cancelContfirm_${freeboardcomment.commentNo }' class='cancelContfirmClass' />
					</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<br />
			
			<!-- 댓글 입력폼 -->
			<div id="commentAdd">
				<form action="commentWrite.action" method="post" name="addForm">
					<span class="idandContent">ID:</span> <input readonly type="text" id="commentId" name="commentId"
						value='${ sessionScope.loginuser.id }' /><br />
					<span class="idandContent">Content:</span>
					<textarea id="commentContent" name="commentContent" rows="3" cols="2" style="resize:none"></textarea>
					<br />
					 <input type='hidden' id="articleNo" name="articleNo" value="${freeBoard.articleNo }" />
				</form>
				<input type="button" value="등록" id="commentAddButton" />
			</div>

			<%-- <!-- 댓글 수정 폼 -->
			<div id="commentEdit_${ freeboardcomment.commentNo }" style="display:none">
				<form action="commentEdit.aciton" method="post" name="editForm">
					<input type="hidden" id="commentEditConfirmNo" >
					<input type="hidden" name="id" id="id" value='' />
					 <span class="idandContent">Content:</span>
					<textarea id="commentContnet" rows="3"
						cols="2" style="resize:none"></textarea>
				</form>
				<input type="button" value="수정" onclick="editComment();" id='commentEditConfirmButton' class="commentEditConfirmClass"/>
				 <input type="button" value="취소" onclick="cancelUpdate();" />
			</div> --%>
		</div>
	</div>
	<c:import url="/WEB-INF/views/include/footer.jsp" />

</body>
</html>