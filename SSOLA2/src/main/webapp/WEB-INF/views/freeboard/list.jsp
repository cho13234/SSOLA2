<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>freeboard</title>
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
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
@import url('https://fonts.googleapis.com/css?family=Just+Me+Again+Down+Here');
@import url('https://fonts.googleapis.com/css?family=Pangolin');
@import url('https://fonts.googleapis.com/css?family=Amiko');

	#titleOfthepage{
	font-family: 'Just Me Again Down Here', cursive;
	margin-left:20%;
	}
	
	.titlePara {
	font-family: 'Pangolin', cursive;
	
	font-size:15px;
	}
	
	.tablerow{
	  text-align:center;
	  font-family: 'Jeju Gothic', serif;
	}
	
	.tableList{
	font-family: 'Amiko', sans-serif;
	
	
	}
  
	.clickable-row{
		cursor: pointer; 
		/* list에 마우스 가져갔을 때 click 가능 표시 */
	}
	
	#writeButtonDiv{
 		margin-right:10%;
 		float:right;
 	}

	.pagerGroup{
	font-family: 'Jeju Gothic', serif;
	size: 20%;
	
	}
	
	.pagerGroup a:link { color: black; text-decoration: none;}
 	.pagerGroup a:visited { color: black; text-decoration: none;}
 	.pagerGroup a:hover { color: black; text-decoration: none;}
 	.pagerGroup a:active {
	    background-color: #4CAF50;
	    color: white;
	    border-radius: 5px;
	}
	.pagerGroup a:hover:not(.active) {
	    background-color: #ddd;
	    border-radius: 5px;
	}
  
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
		<h1>[ Free Board ]</h1>
		<p class="titlePara">&nbsp;&nbsp;YOLO! You Only Live Once! Enjoy your life!</p>
		<p class="titlePara">&nbsp;&nbsp;You guys can talk freely in this place!</p>
	</div>
	<div>
		<!--freeBoard list-->
		<div style= "margin-right:30%; float:right;"  >
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
					        <th class="tablerow">제목</th>
					        <th class="tablerow">작성자</th>
					        <th class="tablerow">작성일</th>
					        <th class="tablerow">조회수</th>
				      	</tr>
				    </thead>
				    <tbody>
				    	
				    <c:forEach var="freeboard" items="${freeboards}">
			    		<c:if test="${freeboard.deleted eq false }">
					    	<tr class="clickable-row" data-href="detail.action?articleNo=${ freeboard.articleNo }&pageno=${ pageno }">
						        <td class="tableList">${ freeboard.articleNo }</td>
								<td class="tableList" style="width:60%">${ freeboard.articleTitle }</td>
								<td class="tableList">${ freeboard.id }</td>
						        <td class="tableList">
						        <div>
						        <fmt:formatDate var="dateString" value="${ freeboard.regDate }" type="date" pattern="yyyy년MM월dd일 HH:mm:ss" />
						        ${dateString}
         						</div></td>
						        <td class="tableList">
							      <span style="color:#006666;">[${ freeboard.readCount }]</span>
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