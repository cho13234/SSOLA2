<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>친구목록</title>

<!-- JavaScript Search Plugin -->
<script
	src="//rawgithub.com/stidges/jquery-searchable/master/dist/jquery.searchable-1.0.0.min.js"></script>
</head>

<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
	<c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />
	<a href="http://bootsnipp.com/mouse0270/snippets/4l0k2"
		class="btn btn-danger hide" id="back-to-bootsnipp">Back to
		Bootsnipp</a>

	<div class="container">

		<div class="row">
			<div class="col-xs-12 col-sm-offset-3 col-sm-6">
				<div class="panel panel-default">
					<div class="panel-heading c-list">
						<span class="title">내가 추가한 친구 목록</span>
						<ul class="pull-right c-controls">
							<li><a href="/ssola2/search.action" data-toggle="tooltip"
								data-placement="top" title="Add Contact"><i
									class="glyphicon glyphicon-plus"></i></a></li>
							<li><a href="#" class="hide-search"
								data-command="toggle-search" data-toggle="tooltip"
								data-placement="top" title="Toggle Search"><i
									class="fa fa-ellipsis-v"></i></a></li>
						</ul>
					</div>

					<!-- 나의 친구 리스트에서 검색 -->
					<!-- 나중에 지울수동,.... 아이디로..검색!! -->
					<div class="row" style="display: none;">
						<div class="col-xs-12">
							<div class="input-group c-search">
								<input type="text" class="form-control" id="contact-list-search">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button">
										<span class="glyphicon glyphicon-search text-muted"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<!-- 지우면 search 기능이 안됨 -->

					<ul class="list-group" id="contact-list">
						<li class="list-group-item">
							<div class="col-xs-12 col-sm-3">
								<img src="/ssola2/resources/profileImages/${my_flist.image}"
									alt="Scott Stevens" class="img-responsive img-circle" />
							</div>
							<div class="col-xs-12 col-sm-9">
								<span class="name">{my_flist.destination_id}</span><br />

							</div>
							<div class="clearfix"></div>
						</li>

					</ul>
				</div>
			</div>
		</div>

	</div>


</body>
</html>