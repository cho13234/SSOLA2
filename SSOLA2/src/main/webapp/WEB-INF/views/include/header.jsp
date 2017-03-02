<%@ page import="com.ssola2.model.dto.Member"%>
<%@ page language="java" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/ssola2/resources/styles/header.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
 @import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
 .notification {
 	font-family: 'Jeju Gothic', serif;
 	font-weight:10;
 	margin: 20% auto;
 }
</style>

</head>
<body>

<!-- Header -->
<div id="wrapper">
	<header id="header">
		<h1><a id="maintitleimage" href="/ssola2/main/main.action">
          	<img style=" height: 49px; margin-top:2%;" 
           		src ="/ssola2/resources/images/ssolamaintitle.png"></a>
       	</h1>
       	
		
		<nav class="main">
			<ul>
				<li>
				<c:choose>
              		 <c:when test="${ empty sessionScope.loginuser }">
              		 <h5 class="notification">Need to log in</h5>
              		 </c:when>
              		<c:otherwise>
              		 <h5 class="notification">${ loginuser.id }, welcome to SSola!<br/></h5>
              		</c:otherwise>
              	</c:choose>
              	</li>
				<li class="search">
					<a class="fa-search" href="#search">Search</a>
					<form id="search" method="get" action="http://www.google.co.kr/search" target="_blank" >
						<input type="text" name="query" placeholder="Search" />
					</form>
				</li>
				<li class="menu">
					<a class="fa-bars" href="#menu">Menu</a>
				</li>
			</ul>
		</nav>
	</header>
	
<!-- Menu -->
	<section id="menu">

		<!-- Search -->
			<section>
				<form class="search" method="get" action="http://www.google.co.kr/search" target="_blank" >
					<input type="text" name="query" placeholder="Search" />
				</form>
			</section>
  
		<!-- Links -->
			<section>
				<ul class="links">
					<li>
						<a href="/ssola2/main/main.action">
							<h3>Main</h3>
							<p>메인페이지로 이동합니다.</p>
						</a>
					</li>
					<li>
						<a href="/ssola2/main/about.action">
							<h3>About</h3>
							<p>회사에 대한 소개입니다.</p>
						</a>
					</li>
					<li>
						<a href="/ssola2/freeboard/list.action">
							<h3>FreeBoard</h3>
							<p>자유롭게 말해주세요!</p>
						</a>
					</li>
					<li>
						<a href="/ssola2/voc/list.action">
							<h3>VOC</h3>
							<p>쏠라는 여러분의 의견을 듣길 원합니다.</p>
						</a>
					</li>
					
					<li>
						 <!-- 마이페이지 연결 로그인이 안되있을 경우 보이지 않음 -->
					    <c:choose>
					    	<c:when test="${loginuser.id != null && loginuser.userType eq '0'}">					    	
								<a href="/ssola2/mypage/mypage_main.action"><h3>My page</h3>								
								<p>마이페이지로 이동합니다.</p>
								</a>
							</c:when>
							<c:otherwise>
								<a href="/ssola2/account/login.action"><h3>My page</h3>
								<p>마이페이지로 이동합니다.</p>
								</a>
							</c:otherwise>
						</c:choose>

						<!--  ADMIN계정만 접근가능한 에디터 회원가입창 -->
						<c:if test="${ loginuser.userType }">
							<c:if test="${ loginuser.authority }">
								<a href="/ssola2/account/adminregister.action"><h3>EditorRegister</h3>
								<p>에디터 계정 개설페이지로 이동합니다.</p>
								</a>
							</c:if>
						</c:if>
						</li>
						
						<li>
						<!--  editor계정과 admin만 접근가능한 메인게시글 작성창 -->
						<c:if test="${ loginuser.userType }">
								<a href="/ssola2/main/write.action"><h3>MainWriteForm</h3>
								<p>메인 게시글 작성페이지로 이동합니다.</p>
								</a>
						</c:if>
						</li>
						
						<li>
						 <c:choose>
						 	<c:when test="${loginuser.id == null }">
						 		<a href="/ssola2/account/login.action"><h3>Search</h3>
						 			
						 		</a>
						 	</c:when>
					    	<c:when test="${loginuser.id != null}">						
								<a href="/ssola2/search.action"><h3>Search</h3>
									<p>친구와 주변 음식점 검색 합니다.</p>
								</a>
							</c:when>
						</c:choose>
				</ul>
			</section>
			
			

		<!-- Actions -->
			<section>
				<ul class="actions vertical" style="font-family: 'Jeju Gothic', serif;">
					<li>
					 <c:choose>
              		 	<c:when test="${ empty sessionScope.loginuser }">
							<a href="/ssola2/account/login.action" class="button big fit">Log In</a><br/>
							<a href="/ssola2/account/register.action" class="button big fit">join</a>
               			</c:when>
               			<c:otherwise>
              			 ${ loginuser.id }, welcome to SSola!<br/><br/>
              				 <a  href="/ssola2/account/logout.action" class="button big fit">Log out</a>
               			</c:otherwise>	
               		</c:choose>
					</li>
				</ul>
			</section>
	</section>
</div>

<!-- Scripts -->
<script src="/ssola2/resources/scripts/main_skel.min.js"></script>
<script src="/ssola2/resources/scripts/main_util.js"></script>
<script src="/ssola2/resources/scripts/header.js"></script>
   
</body> 
</html>   
        
        
        
        
        
        
        
        
        
        