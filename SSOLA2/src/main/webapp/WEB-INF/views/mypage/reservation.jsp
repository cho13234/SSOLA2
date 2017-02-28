<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title> Hotel Reservation Form </title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!-- <link href="custom.css" rel="stylesheet" type="text/css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  
    <script type="text/javascript">
    $(document).ready(function(){
    	
    	 $('#submit-link').click(function(event) {
    		$('#form_submit').submit();
    	});    	 
    	
    });
    </script>


</head>
<body>
     <div class="hotel_reserve_box">
         <h3>${loginuser.id}님이 ${store_id}에 예약 하는 중...</h3><br>
         <form id = "form_submit" action="/ssola2/mypage/insert_reservation.action" method="post">
         	<input type="hidden" id="booker" name="booker" value="${loginuser.id}"/>
         	<input type="hidden" id="store_id" name="store_id" value="${store_id}"/>
         
             <div class="form-group" >
    			<label for="open-date" class="col-sm-3 control-label">예약 날짜</label>
    				<input type="date" id="book_date" name="book_date" placeholder="예)1999-04-04" class="form-control">
  			 </div>
  			   			  
             <div class="form-group">
                 <label>예약 시간</label>
                 <select class="form-control" id="book_time" name="book_time">
                     <option value="0" selected>예약 시간 선택 </option>
                     <option value="9"> 09:00 ~ 10:00 </option>
                     <option value="10"> 10:00 ~ 11:00 </option>
                     <option value="11"> 11:00 ~ 12:00 </option>
                     <option value="12"> 12:00 ~ 13:00  </option>
                     <option value="13"> 13:00 ~ 14:00 </option>
                     <option value="14"> 14:00 ~ 15:00 </option>
                     <option value="15"> 15:00 ~ 16:00 </option>
                     <option value="16"> 16:00 ~ 17:00 </option>
                     <option value="17"> 17:00 ~ 18:00 </option>
                     <option value="18"> 18:00 ~ 19:00 </option>
                     <option value="19"> 19:00 ~ 20:00 </option>
                     <option value="20"> 20:00 ~ 21:00 </option>
                     <option value="21"> 21:00 ~ 22:00 </option>
                 </select>
             </div>
             <div class="form-group">
                 <label>예약 인원</label>
                 <select class="form-control" id="book_size" name="book_size">
                     <option value=0 selected>예약 인원 선택 </option>
                     <option value=1> 1명 </option>
                     <option value=2> 2명 </option>
                     <option value=3> 3명 </option>
                     <option value=4> 4명 이상</option>                     
                 </select>
             </div>
             <br>
             
         </form>
          <center><button id = "submit-link" class="btn btn-default" >예약 완료</button></center>
     </div>

</body>
</html>