<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- commentList  -->
		<table class="table table-condensed" style="width:100%;">
			<c:forEach var="freeboardcomment" items="${freeboardcomments}">
			<tr id="commentRow_${freeboardcomment.commentNo}">
				<td>
				<input type="hidden" id="commentNo_${freeboardcomment.commentNo}" name="commentNo" value="${ freeboardcomment.commentNo }"/>
				${ freeboardcomment.id }
				( <fmt:formatDate value = "${ freeboardcomment.regDate}" pattern = "yyyy-MM-dd HH:mm:ss" />)
				<br>
				${ freeboardcomment.commentContent }
				</td>
				<td>
					<c:choose>
					<c:when test="${loginuser.userType }">
					<input type="button" value="Delete" id="commentDeleteButton_${freeboardcomment.commentNo }" 
					class="commentDeleteClass" />
					</c:when>
					<c:otherwise>
					<c:if test="${ loginuser.id eq freeBoard.id }">
					<input type="button" value="Edit" id="commentEditViewButton_${freeboardcomment.commentNo }" class="commentEditViewClass" />
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
		
		
	
