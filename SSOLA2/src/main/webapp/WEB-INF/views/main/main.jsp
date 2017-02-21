<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Main</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="/ssola2/resources/styles/main_main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- banner src -->
<script src="/ssola2/resources/scripts/main_jquery.scrolly.min.js"></script>
<script src="/ssola2/resources/scripts/main_skel.min.js"></script>
<script src="/ssola2/resources/scripts/main_util.js"></script>
<script src="/ssola2/resources/scripts/main_main.js"></script>
<!-- 눈내리는 효과 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Snowstorm/20131208/snowstorm.js"></script>

<style type="text/css">

#newcontent {
float:right;
margin-right:10%;
}

#contentContainer{
box-sizing: border-box;
width:40%;
margin:10%;
margin-left:30%;
text-align:center; 
position: relative;
flex-shrink: 0;
flex-direction: column;
display: flex;
}
/*uploadfeed*/
.uploadfeedcontainer{
    align-items: center;
    flex-direction: row;
}

.firstrow {   
width:100%;
font-family: 'Jeju Gothic', serif;
font-weight: bold;
font-size:10pt;
padding:2%;
}

.secondrow{
width:100%;
height:600px;
font-family: 'Jeju Gothic', serif;
font-size:13pt;
padding:5%;
}
.thirdrow{
padding:1%;

}
</style>
<script type="text/javascript">
$(document).ready(function(){
   
        var recent = $("#recent").val();
        var response;
        
       /*  $.ajax({
           type : "GET",
           url : "uploadfeed.action",
           data : {
              "recent" : recent
           },
           async : false,
           success : function(text) {
              response = text;
           }
        });
        $("#contentContainer").append(response);
        $("#contentContainer p img").css("width", "256px").css("height", "256px"); */
        
        $(window).scroll(function() {
            if (Math.ceil($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
              /* console.log(++page); */
              recent = $(".uploadfeedcontainer:last > #recent").val();

             $.ajax({
                 type : "GET",
                 url : "uploadfeed.action",
                 data : {
                    "recent" : recent
                 },
                 async : false,
                 success : function(text) {
                    response = text;
                    
                    $(".uploadfeedcontainer:last").after('<br/><br/>'+response+'<br/><br/><br/><br/><br/><br/>');
                    $(".uploadfeedcontainer p img").css("width", "520px").css("height", "520px");
                    $(".uploadfeedcontainer p iframe").css("width", "520px").css("height", "520px");
                 }
              });
            }
        });
        
        
        /* $("#newContent").on("click", function(event) {
           recent = $(".uploadfeedcontainer:last > #recent").val();
           $.ajax({
               type : "GET",
               url : "uploadfeed.action",
               data : {
                  "recent" : recent
               },
               async : false,
               success : function(text) {
                  response = text;
                  
                  $(".uploadfeedcontainer:last").append(response);
                  $(".uploadfeedcontainer p img").css("width", "256px").css("height", "256px");
                  $(".uploadfeedcontainer p iframe").css("width", "256px").css("height", "256px");
               }
            });
        }); */
       /*  $("#refreshContent").click(function(event){
           $("#contentContainer").load("uploadfeed.action");
           
           var h = $('<div id="uploadfeedcontainer"></div>');
           h.append($('<table></table>'))
           $("#contentContainer").append(h);
           
           event.preventDefault();
        }); */
        
               //var articleNo = $("#recent").val();
              //$("a[id^=recommendButton1]").on("click", function(event) {
            $("#contentContainer").on("click", "a[id^=recommendButton1]", function(event) {    
                 
                 var id = $(event.currentTarget).attr("id");
                 var articleNo = id.split("_")[1];
                 articleNo = $(event.currentTarget).attr('data-articleno');
                 /* var count = $(event.currentTarget.childNodes[5]); */
                 /* var zz = $('.count'); */
                  var count = $(event.currentTarget).children().eq(1).attr("id");
                  var a = $(event.currentTarget).children().eq(0).attr("class");

                    var b = $('.'+a).attr('src');
                 if(b == '/ssola2/resources/images/fullheart.png')  {
                       $('.'+a).attr('src','/ssola2/resources/images/emptyheart.png');
                    } else {
                       $('.'+a).attr('src','/ssola2/resources/images/fullheart.png');
                    }
                 $.ajax({
                    type : "GET",
                    url : "recommend.action",
                    data : {
                      "articleNo" : articleNo
                   },
                   async : false,
                    success : function(data) {
                       $('#'+count).text(data*1);
                       /* $('.heart1').attr('src','/ssola2/resources/images/fullheart.png'); */
                    }
                 });
              });
              
              
          /*     $("#recommendButton2").on("click", function(event) {
                  $.ajax({
                     type : "GET",
                     url : "recommendDelete.action",
                     data : {
                       "articleNo" : articleNo
                    },
                     success : function(data) {
                         $('#count').text(data*1 - 1);
                         $('.heart').attr('src','/ssola2/resources/images/emptyheart.png');
                         $('#recommendButton2').attr('href','recommendDelete.action?articleNo='+ articleNo);
                     }
                  });
               }); */
      
            
         
    });

</script>
</head>
<body id="top">
   <div id="pageContainer">
      <c:import url="/WEB-INF/views/include/header.jsp" />
      <!-- Banner -->
      <!--
            To use a video as your background, set data-video to the name of your video without
            its extension (eg. images/banner). Your video must be available in both .mp4 and .webm
            formats to work correctly.
         -->
      <section id="banner" data-video="/ssola2/resources/images/banner">
         <div class="inner">
            <header>
               <h1>Welcome to Ssola</h1>
               <p>쏠로들을 위한 라이프스타일을 소개합니다!</p>
            </header>
            <a href="#main" class="more">Learn More</a>
         </div>
      </section>
	<c:if test="${ loginuser.userType }">
      	<c:if test="${ loginuser.authority eq false }">
      		<div id="main" style="float:right; margin-right:10%" >
				<a id="writeContent" data-toggle="tooltip" title="글 작성 클릭!" class="btn btn-default" href="write.action">새로운 글작성</a>
				<!-- <a id="newContent" class="btn btn-default">이전 글 불러오기</a> -->
				<!--  <a id="refreshContent" class="btn btn-default" href="uploadfeed.action">새로운 글보기</a> -->
			</div>
		</c:if>
      
	</c:if>
      <!-- feed update -->
      <div id="contentContainer" >
         <div class="uploadfeedcontainer">
            <input id="recent" type="hidden" value="${recentArticle}">
         </div>
         
         
         </div>
      
   </div>
   
   
   <c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>