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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/ssola2/resources/scripts/main_jquery.min.js"></script>
<script src="/ssola2/resources/scripts/main_jquery.scrolly.min.js"></script>
<script src="/ssola2/resources/scripts/main_skel.min.js"></script>
<script src="/ssola2/resources/scripts/main_util.js"></script>
<script src="/ssola2/resources/scripts/main_main.js"></script>

<!-- <link rel="Stylesheet" href="/ssola2/styles/include_header.css" />
 -->
 <style type="text/css">
 @import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
 
.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 999;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidenav a {
   border-color:black;
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s
}

.sidenav a:hover, .offcanvas a:focus{
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
#header .maintitle{
line-height: 0;
margin: 20px auto;
padding: 0;
}
#header #menubar{
margin-left:1%;
}
#header #maintitleimage {
   background: none;  
    margin: -10px 0 0 -45px;
    position: absolute;
    left: 50%;
    opacity: 0.9;
}
#header .links {
font-family: 'Jeju Gothic', serif;
color: rgba(82,91,101,0.8);
float:right;
margin-right:1%;
padding: 0px 10px;
 cursor: pointer;
 display: block;
}

</style>
<script type="text/javascript">
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}
</script>
</head>
<body>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="/ssola2/main/main.action">Main</a>
  <a href="/ssola2/main/about.action">About</a>
  <a data-toggle="collapse" href="#collapse1" >Search</a>
  <!-- 검색창... 회원검색등... 구현안됨.. -->
  <div id="collapse1" class="panel-collapse collapse" style="margin-left:5%;width:80%;">
   <div class="input-group">
      <input type="text" class="form-control " placeholder="Search">
      <div class="input-group-btn">
        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
      </div>
    
    </div>
    </div>  
    <!-- 마이페이지 연결 로그인이 안되있을 경우 보이지 않음 -->
    <c:choose>
    	<c:when test="${loginuser.id != null }">
			<a href="/ssola2/mypage/mypage_main.action">My page</a>
		</c:when>
		<c:otherwise>
			<a href="/ssola2/account/login.action">My page</a>
		</c:otherwise>
	</c:choose>
	<!--  ADMIN계정만 접근가능한 에디터 회원가입창 -->
	<c:if test="${ loginuser.userType }">
		<c:if test="${ loginuser.authority }">
			<a href="/ssola2/account/adminregister.action">EditorRegister</a>
		</c:if>
	</c:if>
  
</div>

      <div id="header">
               <div class="maintitle">
               <img id="menubar" onclick="openNav()" src ="/ssola2/resources/images/menubar.png">    
               <a id="maintitleimage" href="/ssola2/main/main.action">
               <img src ="/ssola2/resources/images/ssolamaintitle.png">
                </a>   
            <div class="links">
            <c:choose>
               <%-- <c:when test="${ sessionScope.loginuser == null }"> --%>
               <c:when test="${ empty sessionScope.loginuser }">
               <a class="btn btn-default" href="/ssola2/account/login.action">Log in</a>&nbsp;&nbsp;
                <a class="btn btn-default" href="/ssola2/account/register.action">join</a>
               </c:when>
               <c:otherwise>
               ${ loginuser.id }, welcome to SSola!
               <a class="btn btn-default" href="/ssola2/account/logout.action">Log out</a>
               </c:otherwise>
            </c:choose>
            </div>
            </div>
        </div>        
       
        
</body> 
</html>   
        
        
        
        
        
        
        
        
        
        