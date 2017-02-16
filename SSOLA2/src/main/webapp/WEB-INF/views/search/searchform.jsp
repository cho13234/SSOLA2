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
	
	   $("#search").on("keyup", function(event) { //친구 찾기 event
		var searchSelect = $("#country").val();
		var search = $("#search").val();
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
        		   var append1 = $('<tr class="tbody"><td>이미지</td><td>'+id+'</td><td>'+nickname+'</td><td>'+phone+'</td></a></tr>').attr('id' , id);
        		   $('#friend_table1').append(append1); 
        	   }
        	   $('.tbody').click(function() { //action 값을 넣어주기.
    			   location.href='/ssola2/mypage/mypage_friendmain.action?id='+$(this).attr('id');
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
			   $('#friend_table1').append($('<tr class="thead"><th>이미지</th><th>매장명</th><th>매장주소</th><th>전화번호</th></tr>'));
			   $('#map1').append($('<div id="map" style="width: 800px;height: 400px;"></div>'));
			   
			   ////////////////////////////////////////////////////////////////////////////
			   
			   var mapContainer = $('#map')[0];//document.getElementById('map'); //지도를 표시할 div
			   mapOption = {
				        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 4 // 지도의 확대 레벨
				    };  
			   
				// 지도를 생성합니다    
				var map = new daum.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				$("#search").on("keydown", function(event) {
				if(event.keyCode == 13) { //enter key
					
				var mapString = $('#search').val(); //검색한 주소
				geocoder.addr2coord(mapString, function(status, result) {

				    if (status === daum.maps.services.Status.OK) {// 정상적으로 검색이 완료됐으면 
				    	
				    	 $.ajax({
					           type : "POST",
					           url : "searchgps.action",
					           data : {
					             "searchSelect" : searchSelect ,
					             "search" : mapString
					          },
					          async : false,
					           success : function(data) {
					        	 alert(data);
					        	   
					        		//매장들 마커 표시 하는 배열
							    	var positions = [
							    	    {
							    	        title: '카카오', 
							    	        latlng: new daum.maps.LatLng(33.450705, 126.570677)
							    	    },
							    	    {
							    	        title: '생태연못', 
							    	        latlng: new daum.maps.LatLng(33.450936, 126.569477)
							    	    },
							    	    {
							    	        title: '텃밭', 
							    	        latlng: new daum.maps.LatLng(33.450879, 126.569940)
							    	    },
							    	    {
							    	        title: '근린공원',
							    	        latlng: new daum.maps.LatLng(33.451393, 126.570738)
							    	    }
							    	];
							    	
							    	//매장들의 위치
							    	// 마커 이미지의 이미지 주소입니다
							    	//var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
							    	var imageSrc = "http://www.reactiongifs.com/r/hsk.gif"; 
							    	    
							        for (var i = 0; i < positions.length; i ++) {
							            
							            // 마커 이미지의 이미지 크기 입니다
							            //var imageSize = new daum.maps.Size(24, 35); 
							            var imageSize = new daum.maps.Size(54, 65);
							            // 마커 이미지를 생성합니다    
							            var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
							            
							            // 마커를 생성합니다
							            var marker = new daum.maps.Marker({
							                map: map, // 마커를 표시할 지도
							                position: positions[i].latlng, // 마커를 표시할 위치
							                title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							                image : markerImage // 마커 이미지 
							            });
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
				    	
				    } else { //주소를 찾을 수 없을때
				    	alert('주소를 잘 입력해라!');
				    	return;
				    }
				}); 
				} //key 13 
			}); // key down event

			   
////////////////////////////////////////////////////////////////////////////
		   } else if(searchSelect == "friend") {
			   $('.tbody').remove();
			   $('#map').remove();
			  /*  $('#friend_table2').append($('<p class="thead"><span>이미지</span><span>아이디</span><span>닉네임</span><span>전화번호</span></p>')); */ 
			   $('#friend_table1').append($('<tr class="thead"><th>이미지</th><th>아이디</th><th>닉네임</th><th>전화번호</th></tr>'));
			   
		   }else if (searchSelect == "category") {
			   
		   }else if(searchSelect == "body") {
			   
		   }
	   
	   });
	   
	
}); // 스크립트 끝

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
					
						&nbsp;
					  <div id="friend_list">
						<table class="table table-hover" id="friend_table1" style="width:100%;">
							<thead class="thead">
     						  <tr>
						        <th>이미지</th>
						        <th>아이디</th>
						        <th>닉네임</th>
						        <th>전화번호</th>
						      </tr>
						    </thead>
						</table>
					  </div>
					  <div id="map1" style="width : 100%">
						<!-- <div id="map" style="width: 800px; display : none; height: 400px;"></div> -->
						
					 </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
