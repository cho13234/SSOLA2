<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Main</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="/ssola2/resources/styles/main_about.css" />
<link rel="stylesheet" href="/ssola2/resources/styles/main_about_top.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm.js"></script>

<script src="/ssola2/resources/scripts/main_about.js"></script>
<script src="/ssola2/resources/scripts/jquery.poptrox.js"></script>
<script src="/ssola2/resources/scripts/skel.min.js"></script>
<script src="/ssola2/resources/scripts/main_jquery.min.js"></script>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
@import url(http://fonts.googleapis.com/earlyaccess/nanumbrushscript.css);
.contents {
font-family: 'Nanum Pen Script', serif;
text-decoration: none;
}

a:link {text-decoration: none; color: #B2AFAF;}
a:visited {text-decoration: none; color: #B2AFAF;}
a:active {text-decoration: none; color: #B2AFAF;}
a:focus {text-decoration: none; color: #B2AFAF;}
a:hover {text-decoration: none; color: #B2AFAF;}

</style>
<script type="text/javascript">

</script>
</head>
<body id="top">
<c:import url="/WEB-INF/views/include/header.jsp" />
	<br/><br/> <br/><br/><br/><br/>
   	<div id="pageContainer" >
      <!-- Wrapper -->
      <br/><br/><br/> <br/>
			<div id="wrapper">
	<!-- Main -->
			<section id="main1" >
				<div class="inner">
					<img class="image fit" src="/ssola2/resources/images/poo.png" alt="" />
				</div>
			</section>
			
			<section id="main">

				<!-- Thumbnails -->
					<section id ="thumbnails" class="thumbnails">
						<div>
							<a class="contents" href="/ssola2/resources/images/fulls/01.jpg" >
								<img src="/ssola2/resources/images/thumbs/01.jpg" alt="01" />
								<h3>맛있는 음식이 먹고싶을때</h3>
							</a>
							<a class="contents" href="/ssola2/resources/images/fulls/02.jpg">
								<img src="/ssola2/resources/images/thumbs/02.jpg" alt="02" />
								<h3>혼자서 갈 곳을 찾을 때</h3>
							</a>
						</div>
						<div>
							<a class="contents" href="/ssola2/resources/images/fulls/03.jpg">
								<img src="/ssola2/resources/images/thumbs/03.jpg" alt="03" />
								<h3>가끔은 혼자만의 여유가 필요한</h3>
							</a>
							<a class="contents" href="/ssola2/resources/images/fulls/04.jpg">
								<img src="/ssola2/resources/images/thumbs/04.jpg" alt="04" />
								<h3>사람들을 위한 공간</h3>
							</a>
							<a class="contents" href="/ssola2/resources/images/fulls/05.jpg">
								<img src="/ssola2/resources/images/thumbs/05.jpg" alt="05" />
								<h3>나에게 주는 자유</h3>
							</a>
						</div>
						<div>
							<a class="contents" href="/ssola2/resources/images/fulls/06.jpg">
								<img src="/ssola2/resources/images/thumbs/06.jpg" alt="06" />
								<h3>그 자유를 쏠라에서 만들어드립니다.</h3>
							</a>
							<a class="contents" href="/ssola2/resources/images/fulls/07.jpg">
								<img src="/ssola2/resources/images/thumbs/07.jpg" alt="07" />
								<h3>쏠라에 오신것을 환영합니다.</h3>
							</a>
						</div>
					</section>

			</section>

	</div>
     
     
   </div>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
   
   
</body>
</html>