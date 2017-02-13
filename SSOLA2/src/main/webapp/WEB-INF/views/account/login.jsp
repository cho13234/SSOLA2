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
<link rel="stylesheet" type="text/css" href="/ssola2/resources/styles/ssola_maintitle.css" />
<script src="/ssola2/resources/scripts/functions.js"></script> 
<script src="/ssola2/resources/scripts/particle.js"></script>

<script type="text/javascript">
$(function() {
	if ($("#pleaseLoginAgain").text()) {
		var offset = $("#submitButton").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
	}
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
 	
 	 <div class="hero">
      <h1 id="title-1"><em><span>S</span>SOLA</em>make your life better</h1>  
    </div>
    
     <div class="fixbottarro"> <a class="scroll" href="#submitButton">Scroll for more</a> </div>
    <!-- /.hero --> 
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		<div id="inputcontent">
			
		    <div id="inputmain" style="text-align:center; width:30%; margin-left:35%"  >
		        <form id="submitForm" action="login.action" method="post" role="form" class="form-horizontal">
					<h2 id="maintitle" style="font-family: 'Nanum Pen Script', serif; color:white;
						font-size:35pt; font-weight:bold;">Login</h2>
						<br/>
						<div class="input-group">
					    	<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					    	<input type="text" class="form-control" name="id" placeholder="id">
					 	</div>
					 	<br/><br/>
					  	 <div class="input-group">
					     	<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					    	<input id="password" type="password" class="form-control" name="password" placeholder="Password">
					    	<c:if test="${ loginfailed eq true }">
									<br>
									<div id="pleaseLoginAgain" style="color:red; font-size:8pt; font-style:bold">아이디나 비밀번호가 맞지 않습니다.</div>
								</c:if>
					 	</div>
					
					
					<br/><br/><br/><br/><br/><br/><br/><br/>
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
		</div>
	
	</div>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
</html>