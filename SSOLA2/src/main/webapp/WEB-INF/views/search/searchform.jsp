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

span {
	padding : 80px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	   $("#search").on("keyup", function(event) {
		 var searchSelect = $("#country").val();
		var search = $("#search").val();
		if($(this).val().length == 0) {
			 $('#thead').remove();
      	   $('.tbody').remove();
			return;
		}
		
		if(searchSelect == "friend") { /* 셀렉트 한것만  */
	   $.ajax({
           type : "POST",
           url : "search.action",
           data : {
             "searchSelect" : searchSelect ,
             "search" : search
          },
          async : false,
           success : function(data) {
        	   $('.tbody').remove();
        	   
        	   /* $('#friend_table2').append($('<p class="thead"><span>아이디</span><span>닉네임</span><span>전화번호</span></p>'));  */
        	   for(var i =0; i < data.length; i++) {
        		   var id = data[i].id;
        		   var nickname = data[i].nickname;
        		   var phone = data[i].phone;
        		   
        		   $('#friend_table1').append($('<tr class="tbody"><td style="padding :20 80 80 80px;">이미지</td><td style="padding-left : 11%;">'+id+'</td><td style="padding-left : 20%;">'+nickname+'</td><td style="padding-left : 22%;">'+phone+'</td></tr>')); 
    	   
        	   }
           }
	   });
	} else if(searchSelect == "gps") {
		 $.ajax({
	           type : "POST",
	           url : "searchgps.action",
	           data : {
	             "searchSelect" : searchSelect ,
	             "search" : search
	          },
	          async : false,
	           success : function(data) {
	        	   $('.tbody').remove();
	        	   
	        	   /* $('#friend_table2').append($('<p class="thead"><span>아이디</span><span>닉네임</span><span>전화번호</span></p>'));  */
	        	   for(var i =0; i < data.length; i++) {
	        		   var id = data[i].id;
	        		   var nickname = data[i].nickname;
	        		   var phone = data[i].phone;
	        		   
	        		   $('#friend_table1').append($('<tr class="tbody"><td style="padding :20 80 80 80px;">이미지</td><td style="padding-left : 11%;">'+id+'</td><td style="padding-left : 20%;">'+nickname+'</td><td style="padding-left : 22%;">'+phone+'</td></tr>')); 
	    	   
	        	   }
	           }
		   });
		
	}
	 
	   
	   }); /* 키업 이벤트 */
	  
	   
	   
	   $("#country").on("change", function(event) {
		   var searchSelect = $("#country").val();
		   $('.thead').remove();
		  
		   if(searchSelect == "gps") {
			   $('#friend_table2').append($('<p class="thead"><span>매장명</span><span>매장주소</span><span>전화번호</span></p>')); 
		   } else if(searchSelect == "friend") {
			   $('#friend_table2').append($('<p class="thead"><span>이미지</span><span>아이디</span><span>닉네임</span><span>전화번호</span></p>')); 
			   
		   }
	   });
	   
	   
});

</script>

</head>
<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />
	
	<br/><br/>

<div id="inputmain" style="text-align:center; width:30%; margin-left:35%"  >
		<select  id="country" name="searchSelect">
		  <option value="friend">친구검색</option>
		  <option value="gps">주변검색</option>
		  <option value="category">카테고리</option>
		  <option value="body">본문검색</option>
		</select>
		<input type="text" id="search" name="search" placeholder="검색" style="width : 60%">
		<!-- <a id="submitButton" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">검색</a> -->
</div>

<div class="w3-content" style="max-width: 80%">
		<div class="container">
			<div class="w3-row">

				<!-- Blog entries -->
				<div class="w3-col l8 s12" style="margin-left:10%;">
					<!-- Blog entry -->
					<div class="w3-card-4 w3-margin w3-light-grey" style="width: 110%;">
					<div id="friend_table2" style="width : 100%">
					  	<p class="thead"><span>이미지</span><span>아이디</span><span>닉네임</span><span>전화번호</span></p>
					 </div>
						&nbsp;
					  <div id="friend_list">
						<table id="friend_table1" style="width:80%; height : 20%;">
						</table>
						

					  </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
