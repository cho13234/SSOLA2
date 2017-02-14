<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>SSOLA</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/ssola2/resources/styles/comments.css" />
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

a:link {text-decoration: none; color: #5A5A5A; font-weight:bold; }
a:visited {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:active {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:focus {text-decoration: none; color: #5A5A5A; font-weight:bold;}
a:hover {text-decoration: none; color: #5A5A5A; font-weight:bold;}

body, h1, h2, h3, h4, h5 {
	font-family: "Raleway", sans-serif
}

form{display:inline}
</style>

<script type="text/javascript">
$(document).ready(function(){
	   $("#search").on("keyup", function(event) {
		var searchSelect = $("#country").val();
		var search = $("#search").val();
		if($(this).val().length == 0) {
			$('.friend1').remove();
			return;
		}
	   $.ajax({
           type : "POST",
           url : "search.action",
           data : {
             "searchSelect" : searchSelect ,
             "search" : search
          },
          async : false,
           success : function(data) {
/*         	   $('.friend1').remove();
        	   for(var i =0; i < data.length; i++) {
        		   var a = data[i].id;
        		   
        		  /*  $('#friend_list').append('<p>'+ a +'</p>').attr('class' , 'friend1'); */
        		    $('#friend_list').append($('<div/>', {
        			   	class : 'friend1' ,
        		        text: a
        		        
        		    }).append()); 
        	   
        	   } */
           }
	   });
	 });
	   
	   
	   
});

</script>

</head>
<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />

검색 페이지
<div id="inputmain" style="text-align:center; width:30%; margin-left:35%"  >
		<select  id="country" name="searchSelect">
		  <option value="friend">친구검색</option>
		  <option value="gps">주변검색</option>
		  <option value="category">카테고리</option>
		  <option value="body">본문검색</option>
		</select>
		<input type="text" id="search" name="search" placeholder="검색" style="width : 60%">
		<a id="submitButton" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">검색</a>
		       
</div>


<div class="w3-content" style="max-width: 80%">
		<div class="container">
			<div class="w3-row">

				<!-- Blog entries -->
				<div class="w3-col l8 s12" style="margin-left:10%;">
					<!-- Blog entry -->
					<div class="w3-card-4 w3-margin w3-light-grey" style="width: 110%;">
						&nbsp;
					  <div id="friend_list">
					  	
					  </div>
					  
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
