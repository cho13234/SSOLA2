<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
body {
	padding-top: 30px;
}

.widget .panel-body {
	padding: 0px;
}

.widget .list-group {
	margin-bottom: 0;
}

.widget .panel-title {
	display: inline
}

.widget .label-info {
	float: right;
}

.widget li.list-group-item {
	border-radius: 0;
	border: 0;
	border-top: 1px solid #ddd;
}

.widget li.list-group-item:hover {
	background-color: rgba(86, 61, 124, .1);
}

.widget .mic-info {
	color: #666666;
	font-size: 11px;
}

.widget .action {
	margin-top: 5px;
}

.widget .comment-text {
	font-size: 12px;
}

.widget .btn-block {
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
}

.ui-group-buttons .or {
	position: relative;
	float: left;
	width: .3em;
	height: 1.3em;
	z-index: 3;
	font-size: 12px
}

.ui-group-buttons .or:before {
	position: absolute;
	top: 50%;
	left: 50%;
	content: '';
	background-color: #5a5a5a;
	margin-top: -.1em;
	margin-left: -.9em;
	width: 1.8em;
	height: 1.8em;
	line-height: 1.55;
	color: #fff;
	font-style: normal;
	font-weight: 400;
	text-align: center;
	border-radius: 500px;
	-webkit-box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1);
	box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1);
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	-ms-box-sizing: border-box;
	box-sizing: border-box
}

.ui-group-buttons .or:after {
	position: absolute;
	top: 0;
	left: 0;
	content: ' ';
	width: .3em;
	height: 2.84em;
	background-color: rgba(0, 0, 0, 0);
	border-top: .6em solid #5a5a5a;
	border-bottom: .6em solid #5a5a5a
}

.ui-group-buttons .or.or-lg {
	height: 1.3em;
	font-size: 16px
}

.ui-group-buttons .or.or-lg:after {
	height: 2.85em
}

.ui-group-buttons .or.or-sm {
	height: 1em
}

.ui-group-buttons .or.or-sm:after {
	height: 2.5em
}

.ui-group-buttons .or.or-xs {
	height: .25em
}

.ui-group-buttons .or.or-xs:after {
	height: 1.84em;
	z-index: -1000
}

.ui-group-buttons {
	display: inline-block;
}

.ui-group-buttons:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden
}

.ui-group-buttons .btn {
	float: left;
	border-radius: 0
}

.ui-group-buttons .btn:first-child {
	margin-left: 0;
	border-top-left-radius: .25em;
	border-bottom-left-radius: .25em;
	padding-right: 15px
}

.ui-group-buttons .btn:last-child {
	border-top-right-radius: .25em;
	border-bottom-right-radius: .25em;
	padding-left: 15px
}
</style>

<meta charset="utf-8" />
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">

 	$(function() {
		
		$("#btnUpdate").on("click", function(event) {
			var commentContents = $("#updateCommentContents").val();
			var commentNo = $("#commentNo").val();
			/* var param = "commentContents=" + commentContents; */
			$.ajax({
				type : "post",
				url : "/ssola2/comment/update.action",
				data : {
					commentContents:$("#updateCommentContents").val(),
					commentNo:$("#commentNo").val()
					
				},
				success : function() {
					alert("success!");
				}
			});
		});
		
 
		$("#btnDelete").on("click", function(event) {
			
			if(confirm("Are you sure to delete?")){
				var commentNo = $("#commentNo").val();
				
				$.ajax({
					type : "GET",
					url : "/ssola2/comment/delete.action",
					data : {
						commentNo:$("#commentNo").val()
					},
					success : function() {
						alert("success!");
					}
				});
			};
		});
		
		
	});
	 

</script>

</head>
<body>

	<div class="container">



		<div class="panel panel-default widget">
			<div class="panel-heading">
				<span class="glyphicon glyphicon-comment"></span>
				<h3 class="panel-title">Reply</h3>


			</div>
			<div class="panel-body">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row">
							<div class="col-xs-2 col-md-1">
								<div class="col-xs-10 col-md-11"></div>
							</div>
					</li>
				</ul>
			</div>
			<div class="col">
        

				<div class="panel-body">
					<form role="form" method="post" >
						<fieldset>
							<div class="form-group">
							 <c:forEach var="row" items="${list}">
								<textarea id="updateCommentContents" class="form-control" rows="3"
									 autofocus="">${row.commentContents}</textarea>
									 
									 <input id="commentNo" type="hidden" value="${row.commentNo}" />
								
							</div>
							
							<button id="btnUpdate" type="button" class="[ btn btn-default ]"
								data-loading-text="Loading...">Update</button>
							<button id="btnDelete" type="button" class="[ btn btn-default ]"
								data-loading-text="Loading...">Delete</button>
								</c:forEach>
						</fieldset>
						</form>
				</div>
				
				<!-- <div id="listComments">
				</div> -->
			</div>

		</div>
	</div>


</body>