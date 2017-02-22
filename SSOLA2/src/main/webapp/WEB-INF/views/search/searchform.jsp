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
<script src="//apis.daum.net/maps/maps3.js?apikey=269cb27c144b1d1c288d2ca0ecb50a8b&libraries=services"></script>
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

/* span {
	padding : 80px;
} */
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	   $("#search1").on("keyup", function(event) { //친구 찾기 event
		var searchSelect = $("#country").val();
		var search1 = $("#search1").val();
		if($(this).val().length == 0) {
			 $('#thead').remove();
      	   $('.tbody').remove();
			return;
		}
		//맨처음 보여질 option 이 friend 라서  이 option ajax 는 여기서 사용
		if(searchSelect == "friend") { /* 셀렉트 한것만  */
	   $.ajax({
           type : "POST",
           url : "search.action",
           data : {
             "searchSelect" : searchSelect ,
             "search" : search1
          },
          async : false,
           success : function(data) {
        	   $('.tbody').remove();
//        	   alert(data[0].id);
        	   for(var i =0; i < data.length; i++) {
        		   var id = data[i].id;
        		   var nickname = data[i].nickname;
        		   var phone = data[i].phone;
        		   var image = data[i].image;
        		   var append1 = $('<tr class="tbody"><td><img class="img-circle" alt="프로필이 없습니다." style="width : 80px; height : 80px;" src="/ssola2/resources/profileImages/'+image+'"></td><td>'+id+'</td><td>'+nickname+'</td><td>'+phone+'</td></a></tr>').attr('id' , id);
        		   $('#friend_table1').append(append1); 
        	   }
        	   $('.tbody').click(function() { //action 값을 넣어주기.
    			   location.href='/ssola2/mypage/mypage_friendmain.action?did='+$(this).attr('id');
    		   });
           }
	   });
	} 
	   
}); /* 키업 이벤트 */
	  
	   
	   $("#country").on("change", function(event) { //select option 바꿀때 이벤트 처음 보여지는것은 friend 지만 두번째부턴 change 되는 부분이라 ajax도 여기서 써줌
		   var searchSelect = $("#country").val();
		   $('.thead').remove();
		  
		   if(searchSelect == "gps") {
			   $('.tbody').remove();
			   $('#map').remove();
			   $('#friend_table1').append($('<tr class="thead"><th>이미지</th><th>카테고리</th><th>매장명</th><th>주소</th></tr>'));
			   $('#map1').append($('<div id="map" style="width: 830px;height: 400px;"></div>'));
			   
			   ////////////////////////////////////////////////////////////////////////////
			   
			   var mapContainer = $('#map')[0];//document.getElementById('map'); //지도를 표시할 div
			   mapOption = {
				        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 5 // 지도의 확대 레벨
				    };  
			   
				// 지도를 생성합니다    
				var map = new daum.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				$("#search1").on("keydown", function(event) {
				if(event.keyCode == 13) { //enter key
					if(searchSelect == "gps") {
				$('.tbody').remove(); //리스트 제거
				var mapString = $('#search1').val(); //검색한 주소
				geocoder.addr2coord(mapString, function(status, result) {

				    if (status === daum.maps.services.Status.OK) {// 정상적으로 검색이 완료됐으면 
				    	//내가 검색한 위치
				    	var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);	
				    	 $.ajax({
					           type : "POST",
					           url : "searchgps.action",
					           data : {
					             "searchSelect" : searchSelect ,
					             "search" : mapString ,
					             "LAT" : result.addr[0].lat ,
					             "LNG" : result.addr[0].lng
					          },
					          async : false,
					           success : function(data) {
					        	   
					        	   for(var i =0; i < data.length; i++) {
					        		   var section_no = data[i].sectionNo;
					        		   var category = data[i].category;
					        		   var address = data[i].address;
					        		   var maintag = data[i].mainTag;
					        		   var storeName = data[i].storeName;
					        		   var distance = data[i].distance;
					        		   var append1 = $('<tr class="tbody"><td>'+maintag+'</td><td>'+category+'</td><td>'+storeName+'</td><td>'+address+'</td></a></tr>').attr('id' , section_no);
					        		   $('#friend_table1').append(append1); 
					        	   }
					        	   
					        	   if(data != "" ) {
					        	 	//매장들의 위치
							    	// 마커 이미지의 이미지 주소입니다
							    	//var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
					        	   var imageSrc = "http://www.freeiconspng.com/uploads/retail-store-icon-15.png"; 
					        	   for(var i = 0; i <data.length; i++) {
					        		  
					        		   var imageSize = new daum.maps.Size(30, 30);
					        		   var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
					        		  	var positions = [
					        		  		{
					        		  			latlng : new daum.maps.LatLng(parseFloat(data[i].lat), parseFloat(data[i].lng))
					        		  		}
					        		  	];
					        		  	// alert(positions[0].latlng);
					        		  	 
					        		  	var marker = new daum.maps.Marker({
							                map: map, // 마커를 표시할 지도
							                position: positions[0].latlng, // 마커를 표시할 위치
							                title : positions[0].latlng, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							                image : markerImage // 마커 이미지 
							            });
					        		   
					        	   }//for문
					        	   } else {// if(data != "") 
					        		   alert('주변에 맛집이 없습니다.');
					        	   }
							        
							        //내가 검색한 위치
							        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

							        // 인포윈도우로 장소에 대한 설명을 표시합니다
							       /*  var infowindow = new daum.maps.InfoWindow({	
							            content: '<div style="width:150px;text-align:center;padding:6px 0; background-color:#BA3A3A;">fuck</div>'
							        });
							        infowindow.open(map, marker); */

							        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							        map.setCenter(coords);
					        	   
					           } //success end
						   });
				    	////////////////////////////////// ajax end
				    	
				    } // if 문
				}); 
				} //searchselect == "gps"
				} //key 13 
			}); // key down event

			   
////////////////////////////////////////////////////////////////////////////
		   } else if(searchSelect == "friend") {
			   $('.tbody').remove();
			   $('#map').remove();
			   $('#friend_table1').append($('<tr class="thead"><th style="padding-left : 45px;">프사</th><th style="padding-left : 25px;">아이디</th><th style="padding-left : 25px;">닉네임</th><th>전화번호</th></tr>'));
			   
		   }
	   
	   });
	   
	
}); // 스크립트 끝

</script>

</head>
<body>

	<c:import url="/WEB-INF/views/include/header.jsp" />
	
	<br/><br/>

<div id="inputmain" style="text-align:center; width:30%; margin-left:35%" >
		<select  id="country" name="searchSelect">
		  <option value="friend">친구검색</option>
		  <option value="gps">주변검색</option>
		</select>
		<input type="text" id="search1" name="search" placeholder="검색">
		<!-- <a id="submitButton" class="btn btn-default" style="font-family: 'Nanum Pen Script', serif; font-size:15pt;">검색</a> -->
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
						<table class="table table-hover" id="friend_table1" style="width:100%;">
							<thead class="thead">
     						  <tr>
						        <th style="padding-left : 45px;">프사</th>
						        <th style="padding-left : 25px;">아이디</th>
						        <th style="padding-left : 25px;">닉네임</th>
						        <th>전화번호</th>
						      </tr>
						    </thead>
						</table>
					  </div>
					  <div id="map1" style="width : 100%"> <!--map 이 표시되어질 공간 -->
						<!-- <div id="map" style="width: 800px; display : none; height: 400px;"></div> --> 
						
					 </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
