<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>로그인</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
@import url(http://fonts.googleapis.com/earlyaccess/kopubbatang.css);
@import url('https://fonts.googleapis.com/css?family=Indie+Flower|Raleway');
@import url('https://fonts.googleapis.com/css?family=Amatic+SC');


body {
  margin: 0;
  padding: 0;
/*  Background fallback in case of IE8 & down, or in case video doens't load, such as with slower connections  */
  background: #333;
  background-attachment: fixed;
  background-size: cover;
}

/* The only rule that matters */
#video-background {
/*  making the video fullscreen  */
  position: fixed;
  right: 0; 
  bottom: 0;
  min-width: 100%; 
  min-height: 100%;
  width: auto; 
  height: auto;
  z-index: -100;
}

#mainTitle{
font-family: 'Indie Flower', cursive;
}

#mainPara{
font-family: 'Amatic SC', cursive;

}

</style>
<link href="//vjs.zencdn.net/5.11/video-js.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="//vjs.zencdn.net/5.11/video.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/ssola2/resources/scripts/videojs-Background.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm.js"></script>


<!-- Ssola title -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.1/animate.min.css">
<link rel="stylesheet" type="text/css" href="/ssola2/resources/styles/login.css" />
<link rel="stylesheet" type="text/css" href="/ssola2/resources/styles/animate.css" />


<script type="text/javascript">
$(function() {
	if ($("#pleaseLoginAgain").text()) {
		var offset = $("#submitButton").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
	}
	
	$(".loginBox").on("keydown", function(event) {
		if (event.keyCode != 13)
			return;
		$("#submitForm").submit();
	});
})
</script>

</head>
<body>	
<div id="pageContainer">
		
		<%-- <c:import url="/WEB-INF/views/include/header.jsp" /> --%>
	<video autoplay loop id="video-background">
		<!-- <source src ="/ssola2/resources/images/diagonal.mp4" type="video/mp4"> -->
		<source src ="${pageContext.request.contextPath}/resources/images/login_movie.mp4" type="video/mp4">
<!--  	 <source src="https://player.vimeo.com/external/158148793.hd.mp4?s=8e8741dbee251d5c35a759718d4b0976fbf38b6f&profile_id=119&oauth2_token_id=57447761" type="video/mp4">
 -->	
 	</video>
	<!-- Wrapper-->
	<div id="wrapper">
		<!-- Nav -->
				<nav id="nav">
					<a href="#me" class="icon fa-home active"><span>Home</span></a>
					<a href="#contact" class="icon fa-envelope"><span>Login</span></a>
				</nav>

		<!-- Main -->
		<div id="main">
		<!-- Me -->
			<article id="me" class="panel">
				<header>
					<h1 id="mainTitle" class="animated infinite bounce">Welcome to SSOLA</h1>
					<p id="mainPara">We always aim to make your life better</p>
				</header>
				<a href="#contact" class="jumplink pic">
					<span class="arrow icon fa-chevron-right"><span>See my work</span></span>
					<img src="/ssola2/resources/images/thumbs/07.jpg" alt="login" />
				</a>
			</article>

		<!-- Work -->
			<article id="contact" class="panel">
			
			    <div id="inputmain" style="text-align:center; width:70%; margin-left:15%"  >
			        <form id="submitForm" action="login.action" method="post" role="form" class="form-horizontal">
						<h2 id="maintitle" style="font-family: 'Nanum Pen Script', serif; color:#777;
							font-size:35pt; font-weight:bold;">Login</h2>
							<br/>
							<div class="input-group">
						    	<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
						    	<input type="text" class="form-control loginBox" name="id" placeholder="id">
						 	</div>
						 	<br/><br/>
						  	 <div class="input-group">
						     	<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
						    	<input id="password" type="password" class="form-control loginBox" name="password" placeholder="Password">
						    	<c:if test="${ loginfailed eq true }">
										<br>
										<div id="pleaseLoginAgain" style="color:red; font-size:8pt; font-style:bold">아이디나 비밀번호가 맞지 않습니다.</div>
									</c:if>
						 	</div>
						
						
						<br/><br/>
						<div class="buttons">
							<a href="/ssola2/account/register.action" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">JoIN</a>&nbsp;&nbsp;&nbsp;
							<a id="submitButton" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">Login</a>&nbsp;&nbsp;&nbsp;
							<a href="findpassword.action" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">비밀번호 찾기</a>
						</div>
			        </form>
			        
			        <script type="text/javascript">
						$(function() {
							$("#submitButton").on("click", function(event) {
								$("#submitForm").submit();
							});
						});
					</script>
			    </div>
			</article>
		</div>
	</div>
</div>
<br/><br/><br/><br/>
		<!-- Scripts -->
			<script src="/ssola2/resources/scripts/main_skel.min.js"></script>
			<script src="/ssola2/resources/scripts/login_skel-viewport.min.js"></script>
			<script src="/ssola2/resources/scripts/main_util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="/ssola2/resources/scripts/login_main.js"></script>
			
</body>
</html>