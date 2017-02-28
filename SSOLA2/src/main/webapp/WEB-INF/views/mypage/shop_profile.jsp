<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>마이페이지 메인</title>

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   $("button[id^=btn_addFriend]").on("click", function(event) {
       var id = $(event.currentTarget).attr("id");
       var id0 = id.split("_")[0]; //btn
       var id1 = id.split("_")[1]; //addfriend
       var id2 = id.split("_")[2]; //real id
         var status = id.split("_")[3]; // status

			$.ajax({
				type : "GET",
				url : "add_friend.action",
				data : {
					'did' : id2 ,
					'status' : status
				},
				success : function(status) {
					
					if(status == "delete") {
						$(event.currentTarget).attr("id", id0 + "_" + id1 + "_" + id2 + "_delete");
						
						$(event.currentTarget).text("플러스 친구 삭제");
					} else if(status == "update") {
						$(event.currentTarget).attr("id", id0 + "_" + id1 + "_" + id2 + "_update");
						
						$(event.currentTarget).text("플러스 친구 추가");
					}
					
					/* else if(status == "insert") {
						var cc = $(event.currentTarget).attr("id", id0 + "_" + id1 + "_" + id2 + "_insert");
						$(event.currentTarget).text("친구 삭제");
					} */
					
				}
			});		
	});

   $("#btn_reservation").on("click", function(event){
	   window.open('/ssola2/mypage/reservation.action?store_id=${p_list.id}', 'popup', 'width=600, height=620, left=0, top=0, toolbar=no, location=no, directories=no, status=no, menubar=no, resizable=no, scrollbars=no, copyhistory=no');
   });
   
});



</script>

</head>

<body>

   <c:import url="/WEB-INF/views/include/header.jsp" />
   <c:import url="/WEB-INF/views/mypage/mypage_header.jsp" />

   <%-- <c:forEach items="${p_list}" var="p_list"> --%>


      <div class="container">


         <div class="row">

            <div
               class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad">


               <div class="panel panel-info">
                  <div class="panel-heading">
                     <h3 class="panel-title">${p_list.nickname}님의 프로필</h3>
                  </div>
                  <div class="panel-body">
                     <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center">
                           <img alt="User Pic"
                              src="/ssola2/resources/profileImages/${p_list.image}"
                              class="img-circle img-responsive">
                        </div>

                        <!--<div class="col-xs-10 col-sm-10 hidden-md hidden-lg"> <br>
                  <dl>
                    <dt>DEPARTMENT:</dt>
                    <dd>Administrator</dd>
                    <dt>HIRE DATE</dt>
                    <dd>11/12/2013</dd>
                    <dt>DATE OF BIRTH</dt>
                       <dd>11/12/2013</dd>
                    <dt>GENDER</dt>
                    <dd>Male</dd>
                  </dl>
                </div>-->
                        <div class=" col-md-9 col-lg-9 ">
                           <table class="table table-user-information">
                              <tbody>
                                 <tr>
                                    <td>아이디</td>
                                    <td id = "f_did">${p_list.id}</td>
                                 </tr>
                                 <tr>
                                    <td>이메일</td>
                                    <td>${p_list.email}</td>
                                 </tr>
                                 <tr>
                                    <td>전화번호</td>
                                    <td>${p_list.phonenumber}</td>
                                 </tr>
                                 
                                 <tr>
                                    <td>운영시간</td>
                                    <td>${sh_list.open_time} ~ ${sh_list.close_time}</td>
                                 </tr>
                                 <tr>
                                    <td>수용인원</td>
                                    <td>${sh_list.capacity}</td>
                                 </tr>
                                 <tr>
                                    <td>평균가격</td>
                                    <td>${sh_list.avg_price}</td>
                                 </tr>
								<tr>
                                    <td>대표메뉴</td>
                                    <td>${sh_list.menu}</td>
                                 </tr>
                                 <!-- <tr> -->
                                 

                                 <!-- </tr> -->                                
                                 
                              </tbody>
                           </table>
                           <c:choose>
                              <c:when test = "${status eq 'delete'}" >
                                 <button id="btn_addFriend_${p_list.id}_delete" type="button" class="btn btn-primary">플러스 친구 삭제</button>
                              </c:when>
                              <c:when test = "${status eq 'update'}">
                                 <button id="btn_addFriend_${p_list.id}_update"  type="button" class="btn btn-primary">플러스 친구 추가</button>
                              </c:when>
                              <c:when test = "${status eq 'insert'}">
                                 <button id="btn_addFriend_${p_list.id}_insert"  type="button" class="btn btn-primary">플러스 친구 추가</button>
                              </c:when>
                           </c:choose>  
                                                      
                           <button class="btn btn-primary" type="button" id="btn_reservation">예약</button>
                                   
                        </div>
                     </div>
                  </div>
                    <c:choose>
                     	<c:when test="${p_list.shop_status eq '2' && loginuser.id eq p_list.id }">
			                  <div class="panel-footer">
			                     <a data-original-title="Broadcast Message" data-toggle="tooltip" type="button" class="btn btn-sm btn-primary">
			                        <i class="glyphicon glyphicon-envelope">
			                        </i>
			                     </a> 
                   
			                     <span class="pull-right"> 
			                        <a href="shop_editform.action" data-original-title="Edit this user" data-toggle="tooltip" type="button" class="btn btn-sm btn-warning">
			                           <i class="glyphicon glyphicon-edit">
			                           </i>
			                        </a>                         
			                     </span>
                    
                 			</div>
 						</c:when>
                    </c:choose>
                     
               </div>
            </div>
         </div>

      </div>
<%--    </c:forEach> --%>
   <br>
   <br>
   <c:import url="/WEB-INF/views/include/footer.jsp" />
</body>
</html>