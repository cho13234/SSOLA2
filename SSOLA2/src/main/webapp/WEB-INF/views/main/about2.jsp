<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Main</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm.js"></script>
<!-- about css -->
<link rel="stylesheet" href="/ssola2/resources/styles/header.css" />

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
<body>
<c:import url="/WEB-INF/views/include/header.jsp" />
	
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">

						<!-- Post -->
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="#">Ssola는 언제나 쏠로들의 편에서 쏠로들을 위해 존재합니다.</a></h2>
										<p style="color:#404040">We always try to make your life better!</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2017-02-25">Feb 25, 2017</time>
										<a href="#" class="author"><span class="name">Ms. Kim</span><img src="/ssola2/resources/images/avatar.jpg" alt="main" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="/ssola2/resources/images/about.jpg"alt="ssola" /></a>
								<footer>
									<ul class="stats">
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article>

						<!-- Post -->
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="#">쏠라는 누구든 혼자라서 외롭다고 느낄땐..</a></h2>
										<p style="color:#404040">We are willing to give our time for you.</p>
									</div>
									<div class="meta">
										<time class="published" datetime="datetime="2017-02-24">Feb 24, 2017</time>
										<a href="#" class="author"><span class="name">Ms. Kim</span><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="/ssola2/resources/images/tokyo.jpg" alt="" /></a>
								<footer>
									<ul class="stats">
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article>

						<!-- Post -->
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="#">쏠라는 누구든 혼자만의 시간이 필요할 땐..</a></h2>
										<p style="color:#404040">We will give you a shelter to hide from the outside</p>
									</div>
									<div class="meta">
										<time class="published" datetime="datetime="2017-02-23">Feb 23, 2017</time>
										<a href="#" class="author"><span class="name">Ms. Kim</span><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="/ssola2/resources/images/hand.jpg" alt="" /></a>
								<footer>
									<ul class="stats">
										<li><a href="#" class="icon fa-heart">28</a></li>
										<li><a href="#" class="icon fa-comment">128</a></li>
									</ul>
								</footer>
							</article>
					</div>

				<!-- Sidebar -->
					<section id="sidebar">

						<!-- Intro -->
							<section id="intro">
								<header>
									<h2>SSola</h2>
									<p style="color:gray;">make your life better</p>
								</header>
							</section>

						<!-- Mini Posts -->
							<section>
								<div class="mini-posts">

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Vitae sed condimentum</a></h3>
												<time class="published" datetime=datetime="2017-02-25">Feb 25, 2017</time>
												<a href="#" class="author"><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/news1.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Rutrum neque accumsan</a></h3>
												<time class="published" datetime="2017-02-24">Feb 24, 2017</time>
												<a href="#" class="author"><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/news2.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Odio congue mattis</a></h3>
												<time class="published" datetime="2017-02-23">Feb 23, 2017</time>
												<a href="#" class="author"><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/news3.jpg" alt="" /></a>
										</article>

									<!-- Mini Post -->
										<article class="mini-post">
											<header>
												<h3><a href="#">Enim nisl veroeros</a></h3>
												<time class="published" datetime="2017-02-23">Feb 23, 2017</time>
												<a href="#" class="author"><img src="/ssola2/resources/images/avatar.jpg" alt="" /></a>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/news4.jpg" alt="" /></a>
										</article>

								</div>
							</section>

						<!-- Posts List -->
							<section>
								<ul class="posts">
									<li>
										<article>
											<header>
												<h3><a href="#">김주혜님 후기: 쏠로들은 위한 그 곳 쏠라!</a></h3>
												<time class="published" datetime="2017-01-25">Jan 25, 2017</time>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/pic08.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">조준형님 후기: 쏠라를 알고 난 후 세상이 바꼈어요! 감사합니다!</a></h3>
												<time class="published" datetime=datetime="2017-01-24">Jan 24, 2017</time>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/pic09.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">이준섭님 후기: 쏠라 사랑합니다. 시노자키 아이도..</a></h3>
												<time class="published" datetime="2017-01-22">Jan 22, 2017</time>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/pic10.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">권규민님 후기: 쏠라는 쏠라처럼...</a></h3>
												<time class="published" datetime="2017-01-21">Jan 21, 2017</time>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/pic11.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="#">안선민님 후기: 혼자서도 외롭지 않아요!</a></h3>
												<time class="published" datetime="2017-01-20">Jan 20, 2017</time>
											</header>
											<a href="#" class="image"><img src="/ssola2/resources/images/pic12.jpg" alt="" /></a>
										</article>
									</li>
								</ul>
							</section>

						<!-- About -->
							<section class="blurb">
								<h2>About</h2>
								<p style="color:#404040; padding:2%">
								쏠로들은 왜 외로워야하는가…<br/><br/>
								 쏠로들도 즐길 권리 누릴 권리가 있다라는 생각을<br/><br/>
								 기반으로  쏠로들을 위한 <br/><br/>
								 쏠로들을 생각한 쏠로들이 더 이상 외롭지 않게끔..<br/><br/>
								 쏠로들의 웃음을 지켜주는 <br/><br/>
								 그런 유토피아 쏠로들의 세상을 만들어보자는 <br/><br/>
								 취지에서 시작하여 <br/><br/>
								 쏠로들의 라이프 스타일을 추천하는 쏠라를 .....<br/><br/>
								</p>
								<ul class="actions">
									<li><a href="#" class="button">Learn More</a></li>
								</ul>
							</section>

						

					</section>

			</div>

		<!-- Scripts -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
			<script src="/ssola2/resources/scripts/main_skel.min.js"></script>
			<script src="/ssola2/resources/scripts/main_util.js"></script>
			<script src="/ssola2/resources/scripts/header.js"></script>
							
    <c:import url="/WEB-INF/views/include/footer.jsp" />
   
   
</body>
</html>