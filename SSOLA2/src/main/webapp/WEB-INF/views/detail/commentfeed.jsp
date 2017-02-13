<%@page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>

<div id='commentDiv${ comment.commentNo }' class='row_${comment.sectionNo}'>
	<span class='sub-text'>${comment.id}</span> 
	<span class='date sub-text'>${comment.regDate}</span>
		<div class='panel-body' id='updateCommentContents' style='background-color: white'>
			${comment.commentContents}
		</div>
		<a href='javascript:toggleCommentStatus(${comment.commentNo},true)'	role='button' class='btn btn-default'
			>Update</a>
		<a href='javascript:deleteComment(${comment.commentNo})' class='btn btn-default' role='button'>Delete</a>
		<br>
</div>
<div id='commentEditDiv${ comment.commentNo }' class='row_${comment.sectionNo}' 
	class='panel panel-default' style='display: none'>
	<div class='panel-body'>
		<form id='formCommentUpdate${comment.commentNo}' action='/ssola2/comment/update.action' method='post'>
			<input type='hidden' name='commentNo' value='${ comment.commentNo  }' />
			<input type='text' class='form-control' id='updateCommentContents' name='commentContents'
				style='resize: none;' value='${comment.commentContents}' />
			<div class='rightBtn'>
				<a href='javascript:submitComment(${comment.commentNo})' class='btn btn-default'
				 role='button'>Update</a>
				<a href='javascript:toggleCommentStatus(${comment.commentNo  }, false)'
					class='btn btn-default' role='button'>Cancel</a>
			</div>
		</form>
	</div>
</div>