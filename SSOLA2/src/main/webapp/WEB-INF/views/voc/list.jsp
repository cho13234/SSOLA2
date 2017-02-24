<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>voc</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />

<style type="text/css">
/*font source*/
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
@import url('https://fonts.googleapis.com/css?family=Just+Me+Again+Down+Here');
@import url('https://fonts.googleapis.com/css?family=Pangolin');
@import url('https://fonts.googleapis.com/css?family=Amiko');

	.tablerow{
	  text-align:center;
	  font-family: 'Jeju Gothic', serif;
	}
  
	.clickable-row{
		cursor: pointer; 
		/* list에 마우스 가져갔을 때 click 가능 표시 */
	}
	
	#writeButtonDiv{
 		margin-right:10%;
 		float:right;
 	}

	#pageBlock{
		padding: 3%,3%,3%,3%;
	}
	
	.pagerGroup{
	font-family: 'Jeju Gothic', serif;
	size: 20%;
	
	}
	
	a:link { color: black; text-decoration: none;}
 	a:visited { color: black; text-decoration: none;}
 	a:hover { color: black; text-decoration: none;}
 	
 	#titleOfthepage{
	font-family: 'Just Me Again Down Here', cursive;
	margin-left:20%;
	}
	
	.titlePara {
	font-family: 'Pangolin', cursive;
	
</style>
<script type="text/javascript">
$(function() {
	$(".clickable-row").on("click", function(event) {
		$(location).attr("href", $(this).data("href"));
	});	
});

</script>

</head>
<body>
<c:import url="/WEB-INF/views/include/header.jsp" />
<div id="pageContainer">
	
	<div id="titleOfthepage">
		<h1>[ Voice of Customer]</h1>
		<p class="titlePara">Ssola wants to hear everything from you.</p>
		<p class="titlePara">You guys can talk freely in this place!</p>
	</div>
	
	<div >
		<!--voc list-->
		<div style="margin-right:30%; float:right;" >
		<c:if test="${!empty loginuser }">
		<a id="writeContent" data-toggle="tooltip" title="글 작성 클릭!" class="btn btn-default" href="write.action">새로운 글작성</a>
		</c:if>
		</div>
   	<br/><br/><br/><br/><br/><br/>
	<div class="container">
        <div class="col-sm-12">
	    </div>    		
        	<div class="hidden-xs">
				<table class="table table-hover boardList" style="text-align:center;">
					<thead>
				    	<tr>
					        <th class="tablerow">번호</th>
					        <th class="tablerow">카테고리</th>
					        <th class="tablerow">제목</th>
					        <th class="tablerow">작성자</th>
					        <th class="tablerow">등록일</th>
					        <th class="tablerow">비밀글</th>
					        <th class="tablerow">조회수</th>
				      	</tr>
				    </thead>
				    <tbody>
				    	
				    <c:forEach var="voc" items="${vocs}">
			    		<c:if test="${voc.deleted eq false }">
					    	<tr class="clickable-row" data-href="detail.action?articleNo=${ voc.articleNo }&pageno=${ pageno }">
						        <td>${ voc.articleNo }</td>
						        <td><font color="#29c7a4">${ voc.category }</font></td>
								<td>${ voc.articleTitle }</td>
								<td id="writer">${ voc.id }</td>
						        <td>
						        <div>
						        <fmt:formatDate var="dateString" value="${ voc.regDate }" type="date" pattern="yyyy년MM월dd일 HH:mm:ss" />
						        ${dateString}
         						</div></td>
						        
						        <!-- 비밀글  -->
						        <td>
						        <c:choose>
						        	<c:when test="${voc.secure}">
						        	<img src ="/ssola2/resources/images/lock.png">
						        	</c:when>
						        	<c:otherwise>
						        	<img src ="/ssola2/resources/images/unlock.png">
						        	</c:otherwise>
						        </c:choose>
						        </td>
						        
						        <td>
							      <span class="label label-primary">${ voc.readCount }</span>
						        </td>
					        </tr>
					        </c:if>
				        </c:forEach>
				        
				        
				    </tbody>
				</table>
			</div>
			
			<br /><br />
		</div>
	</div>
	
		<!-- pager 구현 -->
		
        <div style="text-align:center" class="pagerGroup">
        	${ pager }
		</div>
		<!-- ends of pager -->

</div>
	
	
       
			
		
 <c:import url="/WEB-INF/views/include/footer.jsp" />
 
</body>
</html>