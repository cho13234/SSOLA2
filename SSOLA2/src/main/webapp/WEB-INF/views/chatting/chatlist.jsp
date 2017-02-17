<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>

<html>
<head>
	<title>Home</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
	<script type="text/javascript" src="/ssola2/resources/scripts/sockjs-1.0.0.min.js"></script>
	<script type="text/javascript" src="/ssola2/resources/scripts/stomp.js"></script>
	
	<style type="text/css">
	
	ul {
		margin: 0;
		padding: 0;
	}
	
	.chat-me {
		clear: both;
		float: right;
	}
	
	.chat-other {
		clear: both;
		float: left;
	}
	
	.row {
		list-style: none;
	}
	.row .chatList {
		padding: 0 16px;
	}
	.row .chatList ul {
		width: 100%;
		list-style: none;
		margin-top: 3px;
	}
	.row .chatList ul li {
		padding-top: 10px;
		padding-bottom: 10px;
		border-bottom: 1px solid #e5e5e5;
	}
	.row .chatList ul li table {
		width: 100%;
	}
	.row .chatList ul li table td.profile_td {
		width: 50px;
		padding-right: 11px;
	}
	.row .chatList ul li table td.profile_td img {
		width: 50px;
		height: auto;
	}
	.row .chatList ul li table td.chat_td .log_id {
		font-size: 12px;
		font-weight: bold;
	}
	.row .chatList ul li table td.time_td {
		width: 90px;
		text-align: center;
	}
	.row .chatList ul li table td.time_td .log_time {
		padding-bottom: 4px;
	}
		
	</style>
	
	<script type="text/javascript">
		
		var sock = null;
		var stompClient = null;
		var id = '${id}';
		
		function connect() {
			sock = new SockJS("/ssola2/stomp");
			stompClient = Stomp.over(sock);
			stompClient.connect({}, function(frame) {
				console.log('connected stomp over sockjs in chatlist');

				// friendList
				//stompClient.subscribe('/queue/notice/friend-connect-${id}', onConnect);
				//stompClient.subscribe('/queue/notice/friend-disconnect-${id}', onDisconnect);
				stompClient.send('/app/hello', {}, JSON.stringify({
					id: id
				}))

				// 각 group에서 오는 메시지 전부 catch
				/* <c:forEach var="chatRoom" items="${ chatRooms }">
					stompClient.subscribe('/queue/echo/group-${ chatRoom.roomNo }', onGroupMessage);
				</c:forEach> */
			});
		}
		
		function onMessage(message) {
			console.log(message);
		}
		
		function onGroupMessage(message) {
			console.log(message);

			var destination = message.headers.destination;
			var groupNo = destination.split("group-")[1];
			// 그룹 번호를 받는다.
			// 그룹에서 새로운 메시지가 있으면 그룹 옆에 그림 표시 (파랑), 새로운 그룹도 똑같이 표시한다.
			
			var li = $("<li></li>")
			if (message.id == id) {
				li.attr({
					id: message.chatNo,
					'class': 'log chat-me'
				})
			} else {
				li.attr({
					id: message.chatNo,
					'class': 'log chat-other'
				})
			}
			
			li.append(
				$("<table></table>")
				.attr({
					cellpading: 0,
					cellspacing: 0
				})
				.append(
					$("<tr></tr>")
					.append(
						$("<td></td>")
						.attr("class", "profile_td")
						.append("") //여기에 이미지 append
					)
					.append(
						$("<td></td>")
						.attr("class", "chat_td")
						.append(
							$("<div></div>")
							.attr("class", "log_id")
							.text(message.id)
						)
						.append(
							$("<div></div>")
							.attr("class", "log_content")
							.text(message.content)
						)
					)
					.append(
						$("<td></td>")
						.attr("class", "time_td")
						.append(
							$("<div></div>")
							.attr("class","log_time")
							.text(message.regDate)
						)
					)
				)
			)
			
			$("#logList_" + groupNo)
			.append(li);
						
		}
		
		// friendList
		function onConnect(message) {
			console.log(message);
			
			$("<a></a>")
			.attr({
				'id': message.body + '_isconnect',
				'href': '#',
				'class': 'list-group-item'
			})
			.text(message.body)
			.append(
					$("<input></input>")
					.attr({
						'type': 'checkbox',
						'class': 'pull-right'
					})
			)
			.appendTo("#list1");
		}
		function onDisconnect(message) {
			console.log(message);
			$("#" + message.body + '_isconnect').remove();
		}
		
		/* function popupOpen() {
			//TODO: popup을 modal로 변형 sock connect 루트가 두개일 경우 두번의 connect event가 발생해
			//알림이 두번 나간다.
			var popUrl = "friendlist.action";
			var popOption = "width=1000, height=600, resizable=yes, scrollbars=yes, status=no;";
			window.open(popUrl, "", popOption);
		} */
		
		$(function() {
			connect();
			
			$(".roomModalLink").on("click", function(event) {
				
				var target = $(event.target);
				var targetLink = null;
				
				if (event.target !== this) {
					targetLink = target.parent().attr("href");
				} else {
					targetLink = target.attr("href");
				}
				
				$(targetLink).modal();
				
			});
			
			$(".roomModal").on("show.bs.modal", function(event) {
				//stompClient.disconnect();
				
				var target = $(event.target);
				var targetId = target.attr("id");
				var groupNo = targetId.split("_")[1];
				
				$.ajax({
					"url" : "/ssola2/chat/loadgrouplog.action",
					"method" : "get",
					"data" : { groupNo : groupNo },
					"dataType" : "json",
					success : function(data) {
						if (!data) {
							return false;
						}
						//console.log(data);
						
						//$("#logList_" + groupNo).empty();
						
						$.each(data, function(index, log) {
							//console.log(index);
							console.log(log);
							
							var li = $("<li></li>")
							if (log.id == id) {
								li.attr({
									id: log.chatNo,
									'class': 'log chat-me'
								})
							} else {
								li.attr({
									id: log.chatNo,
									'class': 'log chat-other'
								})
							}
							
							li.append(
								$("<table></table>")
								.attr({
									cellpading: 0,
									cellspacing: 0
								})
								.append(
									$("<tr></tr>")
									.append(
										$("<td></td>")
										.attr("class", "profile_td")
										.append("") //여기에 이미지 append
									)
									.append(
										$("<td></td>")
										.attr("class", "chat_td")
										.append(
											$("<div></div>")
											.attr("class", "log_id")
											.text(log.id)
										)
										.append(
											$("<div></div>")
											.attr("class", "log_content")
											.text(log.content)
										)
									)
									.append(
										$("<td></td>")
										.attr("class", "time_td")
										.append(
											$("<div></div>")
											.attr("class","log_time")
											.text(log.regDate)
										)
									)
								)
							)
							
							$("#logList_" + groupNo)
							.append(li);
						});
						
						return;
					}
				});
			});
			
			$(".roomModal").on("hidden.bs.modal", function(event) {
				stompClient.disconnect();
				
				var target = $(event.target);
				var targetId = target.attr("id");
				var groupNo = targetId.split("_")[1];
				
				$("#logList_" + groupNo).empty();
			});
			
			$(".chatBtn").on("click", function(event) {
				var groupNo = event.target.id.split("_")[1];
				
				var text = $("#chatBox_" + groupNo).val();
				
				var data = {
						from : id,
						roomNo : groupNo,
						message : text 
				};
				
				stompClient.send('/app/echo/group', {}, JSON.stringify(data));
			});
			
			$('.add').click(function(){
			    $('.all').prop("checked",false);
			    var items = $("#list1 input:checked:not('.all')");
			    var n = items.length;
			  	if (n > 0) {
			      items.each(function(idx,item){
			        var choice = $(item);
			        choice.prop("checked",false);
			        choice.parent().appendTo("#list2");
			      });
			  	}
			    else {
			  		alert("Choose an item from list 1");
			    }
			});

			$('.remove').click(function(){
			    $('.all').prop("checked",false);
			    var items = $("#list2 input:checked:not('.all')");
				items.each(function(idx,item){
			      var choice = $(item);
			      choice.prop("checked",false);
			      choice.parent().appendTo("#list1");
			    });
			});

			/* toggle all checkboxes in group */
			$('.all').click(function(e){
				e.stopPropagation();
				var $this = $(this);
			    if($this.is(":checked")) {
			    	$this.parents('.list-group').find("[type=checkbox]").prop("checked",true);
			    }
			    else {
			    	$this.parents('.list-group').find("[type=checkbox]").prop("checked",false);
			        $this.prop("checked",false);
			    }
			});

			$('[type=checkbox]').click(function(e){
			  e.stopPropagation();
			});

			/* toggle checkbox when list group item is clicked */
			$('.list-group a').click(function(e){
			  
			    e.stopPropagation();
			  
			  	var $this = $(this).find("[type=checkbox]");
			    if($this.is(":checked")) {
			    	$this.prop("checked",false);
			    }
			    else {
			    	$this.prop("checked",true);
			    }
			  
			    if ($this.hasClass("all")) {
			    	$this.trigger('click');
			    }
			});
		})
	</script>
</head>
<body>
	<div id="pageContainer">
	
		<!-- jquery, bootstrap 두번 이상 호출하면 안되므로 jquery, bootstrap import하고있는 header 및 footer 제외
				필요하면 javascript위치를 밑으로 내리고 header 추가 및 footer는 제외한 상태로 운용 가능
				하지만 해당 jsp 파일 내에서 import는 불가 -->
		<%-- <c:import url="/WEB-INF/views/include/header.jsp" /> --%>
	
		<h1>Chat Room List</h1>
		<div>
			<h4>Hi, ${ id }</h4>
		</div>
		<div>
			<!-- <input type="button" id="viewFriends" value="친구목록"/> -->
			<!-- <input type="button" id="viewFriends" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" value="친구목록"> -->
			<input type="button" id="viewFriends" class="btn btn-info btn-lg" data-toggle="modal" data-target="#friendListModal" value="친구목록">
		</div>
		&nbsp;
		<div id="chatRoomList" class="list-group col-sm-6 col-sm-offset-3">
			<c:forEach var="room" items="${chatRooms}">
				<!-- a링크에 해당 모달 여는 코드 적용 -->
				<a href="#roomModal_${ room.roomNo }" class="roomModalLink btn list-group-item">
					<h4 class="list-group-item-heading">
						<c:choose>
							<c:when test="${ room.roomName eq null }">
								<c:forEach var="name" items="${ room.members }">
									<c:choose>
										<c:when test="${ id eq name }"></c:when>
										<c:otherwise>${ name } </c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								${ room.roomName }
							</c:otherwise>
						</c:choose>
					</h4>
					<p class="list-group-item-text">${ room.memberSize }</p>
				</a>
				<!-- 여기서부터 채팅방 모달 -->
				<div id="roomModal_${ room.roomNo }" class="roomModal modal fade" role="dialog">
					<div class="modal-dialog modal-lg">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">
									<c:choose>
										<c:when test="${ room.roomName eq null }">
											<c:forEach var="name" items="${ room.members }">
												<c:choose>
													<c:when test="${ id eq name }"></c:when>
													<c:otherwise>${ name } </c:otherwise>
												</c:choose>
											</c:forEach>
										</c:when>
										<c:otherwise>
											${ room.roomName }
										</c:otherwise>
									</c:choose>
								</h4>
							</div>
							<div class="modal-body">
								<!-- <p>Some text in the modal.</p> -->
								<div class="row">
									<div class="col-md-12 text-center chatList">
										<!-- 여기에 텍스트 로그 -->
										<ul id="logList_${ room.roomNo }" class="logList"></ul>
									</div>
									<!-- 여기에 입력창 -->
									<div class="col-md-12 text-center">
										<input type="text" id="chatBox_${ room.roomNo }">
										<input type="button" class="chatBtn" id="chatBtn_${ room.roomNo }" value="보내기">
									</div>
									
									<%-- 이걸 설정창 (그룹 참여중인 친구, 채팅방 나가기 등등) <div class="col-sm-4 col-sm-offset-1">
										<div class="list-group" id="list1">
											<a href="#" class="list-group-item active">친구 목록<input title="toggle all" type="checkbox" class="all pull-right"></a>
											<c:forEach var="friend" items="${ friendList }">
												<a href="#" class="list-group-item">${ friend.id } <input type="checkbox" class="pull-right"></a>
											</c:forEach>
										</div>
									</div> --%>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<!-- Modal -->
		<div id="friendListModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Modal Header</h4>
					</div>
					<div class="modal-body">
						<!-- <p>Some text in the modal.</p> -->
						<div class="row">
							<div class="col-md-12 text-center"><h3>Friend List</h3></div>
							  <div class="col-sm-4 col-sm-offset-1">
								<div class="list-group" id="list1">
									<a href="#" class="list-group-item active">친구 목록<input title="toggle all" type="checkbox" class="all pull-right"></a>
									<c:forEach var="friend" items="${ friendList }">
										<a href="#" class="list-group-item">${ friend.id } <input type="checkbox" class="pull-right"></a>
									</c:forEach>
								</div>
							</div>
							<div class="col-md-2 v-center">
								<button title="초대" class="btn btn-default center-block add"><i class="glyphicon glyphicon-chevron-right"></i></button>
								<button title="초대 취소" class="btn btn-default center-block remove"><i class="glyphicon glyphicon-chevron-left"></i></button>
							</div>
							<div class="col-sm-4">
								<div class="list-group" id="list2">
									<a href="#" class="list-group-item active">초대 목록<input title="toggle all" type="checkbox" class="all pull-right"></a>
									<!-- <a href="#" class="list-group-item">Bravo <input type="checkbox" class="pull-right"></a> -->
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			
			</div>
		</div>
		
		<%-- <c:import url="/WEB-INF/views/include/footer.jsp" /> --%>
	</div>
</body>
</html>
