<%@page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/ssola2/resources/styles/header.css" />


<!-- commentList  -->
		<table class="table table-condensed" style=" margin:5% auto; width:80%">
			<c:forEach var="voccomment" items="${voccomments}">
			<tr id="commentRow_${voccomment.commentNo}">
				<td>
				<input type="hidden" id="commentNo_${voccomment.commentNo}" name="commentNo" value="${ voccomment.commentNo }"/>
				${ voccomment.id }
				( <fmt:formatDate value = "${ voccomment.regDate}" pattern = "yyyy-MM-dd HH:mm:ss" />)
				<br>
				${ voccomment.commentContent }
				</td>
				<td>
						<c:choose>
						<c:when test="${ loginuser.id eq voccomment.id }">
						<input type="button" value="Edit" id="commentEditViewButton_${voccomment.commentNo }" class="commentEditViewClass" />
						<input type="button" value="Delete" id="commentDeleteButton_${voccomment.commentNo }" 
						class="commentDeleteClass" />
						</c:when>
					<c:otherwise>
						<c:if test="${loginuser.userType }">
						<input type="button" value="Edit" id="commentEditViewButton_${freeboardcomment.commentNo }" class="commentEditViewClass" />
						<input type="button" value="Delete" id="commentDeleteButton_${voccomment.commentNo }" 
						class="commentDeleteClass" />
						</c:if>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<!-- COMMENT 수정 -->
					<tr id="commentEditRow_${voccomment.commentNo}" style='display: none'>
					<td>
						<input type="hidden" id="commentNo_${voccomment.commentNo}" name="commentNo" value="${ voccomment.commentNo }"/>
						<input type="hidden" id="commentId_${voccomment.id}" name="id" value="${ voccomment.id }"/>
						<span class="idandContent">Content:</span><br/>
						<textarea id="commentContent_${voccomment.commentNo}" name="commentContent" rows="3" cols="2" style="resize:none">${voccomment.commentContent}</textarea>
					</td>
					<td>
						<input type="button" value="Confirm"  id='commentEditConfirmButton_${voccomment.commentNo }' class="commentEditConfirmClass"/>
						<input type="button" value="Cancel" id='cancelContfirm_${voccomment.commentNo }' class='cancelContfirmClass' />
					</td>
					</tr>
			</c:forEach>
		</table>
		
