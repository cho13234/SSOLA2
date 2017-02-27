<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>나를 추가한 사람(친구 추천)</title>

<!-- JavaScript Search Plugin -->
<script
	src="//rawgithub.com/stidges/jquery-searchable/master/dist/jquery.searchable-1.0.0.min.js"></script>
</head>

<body>
	<c:import url="/WEB-INF/views/include/header.jsp" />
	<c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />
	<a href="http://bootsnipp.com/mouse0270/snippets/4l0k2" class="btn btn-danger hide" id="back-to-bootsnipp">
		Back to Bootsnipp
	</a>

	<div class="container">

		<div class="row">
			<div class="col-xs-12 col-sm-offset-3 col-sm-6">
				<div class="panel panel-default">
					<div class="panel-heading c-list">
						<span class="title">나를 추가한 친구 목록</span>
						<ul class="pull-right c-controls">
							<li>
								<a href="/ssola2/search.action" class="hide-search" data-command="toggle-search" data-toggle="tooltip" data-placement="top" title="Toggle Search">
									<i class="fa fa-ellipsis-v"></i>
								</a>
							</li> 
						</ul>
					</div>

					<c:forEach items="${add_flist}" var="add_flist">
						<ul class="list-group" id="contact-list">
							<li class="list-group-item">
								<div class="col-xs-12 col-sm-3">
									<img src="/ssola2/resources/profileImages/${add_flist.image}"
										alt="No Image" class="img-responsive img-circle" />
								</div>
								<div class="col-xs-12 col-sm-9">
									<span class="name">
										<a href="/ssola2/mypage/mypage_friendmain.action?did=${add_flist.source_id}">${add_flist.source_id}
										</a>
									</span><br />

								</div>
								<div class="clearfix"></div>
							</li>

						</ul>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>