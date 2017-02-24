<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="utf-8">
<title></title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">

/* 
	$(".btn_delScrap").on("click", function(event) {

		if (confirm("Are you sure to delete?")) {
			var scrapNo = $("#scrapNo").val();

			$.ajax({
				type : "GET",
				url : "/ssola2/mypage/deleteScrap.action",
				data : {
					scrapNo : $("#scrapNo").val()
				},
				success : function() {
					alert("success!");
				}
			});
		};
	}); */
	
/* 	$("a[id^=btn_delete_scrap]").click(function(event){
		event.preventDefault();
		
		var scrapNo = $(this).attr('data-scrapno');
		
		$.ajax({
			type :  "get",
			url : "/ssola2/mypage/deleteScrap.action",
			data : {
				"scrapNo" : scrapNo
			},
			sucess : function(){
				$("#scrapList" + scrapNo).remove();
			}
		});
	}) */
</script>

</head>

<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />
	

	<!-- <form:form id="list" action="scrapform.action" method="get" modelAttribute="scrap" style="width:70%; margin-left:20%">
		<article class="style1"> --> 
		<c:forEach items="${list}" var="rowList" >					
		<div id="scrapList">
			<div class="row-fluid top30 pagetitle">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h4>No.${rowList.scrapNo}</h4> 
							<a href="/ssola2/detail.action?articleNo=${rowList.articleNo}"><h4>${rowList.mainImage }</h4></a>
							
						</div>
					</div>
				</div>
			</div>
			<div class="container" style="text-align:center">
				<div class="row">
					<div class="col-sm-4">
						<div id="scrapList">
						
					</div>
					<div class="col-sm-8" >
						<h4 class="title" >${rowList.articleTitle}</h4>

					</div>
				</div>
			</div>

			<input id="scrapNo" type="hidden" value="${rowList.scrapNo}" />
						
			<a href="deleteScrap.action?scrapNo=${rowList.scrapNo}"
			 class="btn btn-default" role="button" style="text-align:center">Delete</a> 
			 
			<%--  <a href="#"
			 id="btn-delete_scrap_${rowlist.scrapNo}" 
			 data-scrapno="${rowlist.scrapNo }"
			 class="btn btn-default" role="button">Delete</a> --%>
			

			<!-- <div class="btn_delScrap">
				<button id="deleteScrap" type="button" class="[ btn btn-default ]"
                        data-loading-text="Loading..." >삭제</button>
             </div> -->

			<hr>
			</div>
		</c:forEach> 
	<!-- </article>

	</form:form> -->
	<br>
	<br>
	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>