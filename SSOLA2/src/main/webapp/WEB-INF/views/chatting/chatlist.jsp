<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>

<!DOCTYPE html>

<html>
<head>
<title>Home</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="/ssola2/resources/scripts/sockjs-1.0.0.min.js"></script>
<script type="text/javascript" src="/ssola2/resources/scripts/stomp.js"></script>

<style type="text/css">
.modal-body {
	max-height: calc(100vh - 210px);
	overflow-y: auto;
}

.chat-me .log-id {
	text-align: right;
}

.chat-other .log-id {
	text-align: left;
}

.isconnect {
	color: blue;
}

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

.row .chatList ul li table td.profile-td {
	width: 50px;
	padding-right: 11px;
}

.row .chatList ul li table td.profile-td img {
	width: 50px;
	height: auto;
}

.row .chatList ul li table td.chat-td .log-id {
	font-size: 12px;
	font-weight: bold;
}

.row .chatList ul li table td.time-td {
	width: 90px;
	text-align: center;
}

.row .chatList ul li table td.time-td .log-time {
	padding-bottom: 4px;
}

span[class*="glyphicon-one-fine"] {
    margin-bottom: -.8em;
    overflow: hidden;
}
.glyphicon-one-fine-red-dot:before {
    content:"\25cf";
    font-size: 1.5em;
    color: red;
}
.glyphicon-one-fine-green-dot:before {
    content:"\25cf";
    font-size: 1.5em;
    color: green;
}
.login:before {
    content:"\25cf";
    font-size: 1.5em;
    color: green;
}
</style>

<script type="text/javascript">
	var sock = null;
	var stompClient = null;
	var id = '${id}';
	var currentRoomNo = null;

	function connect() {
		sock = new SockJS("/ssola2/endpoint");
		stompClient = Stomp.over(sock);
		stompClient.connect({
			id : id
		}, function(frame) {
			console.log('connected stomp over sockjs in chatlist');

			// friendList
			stompClient.subscribe('/queue/notice/group-${id}', onGroup); // 채팅방 초대됐을 때, 관리
			stompClient.subscribe('/queue/notice/group-exit-${id}', onExitGroup); // 채팅방 나갈 때, 관리
			stompClient.subscribe('/queue/notice/friend-connect-${id}',
					onConnect);
			stompClient.subscribe('/queue/notice/friend-disconnect-${id}',
					onDisconnect);
			stompClient.subscribe('/queue/echo/group-${id}', onEcho)
		});
	}

	function onEcho(message) {
		console.log(message);

		var date = getTimeStamp().substr(5, 11);
		var data = JSON.parse(message.body);

		$("#preview_" + data.roomNo).text(data.id + ":" + data.content);
		$("#previewTime_" + data.roomNo).text(date);

		$("#chatRoom_" + data.roomNo).prependTo($("#chatRoomList"));

		if (currentRoomNo != null) {
			onGroupMessage(message);
		}
	}

	function onGroupMessage(data) {
		console.log(data);

		var message = JSON.parse(data.body);
		var groupNo = message.roomNo;
		// 그룹 번호를 받는다.
		// 그룹에서 새로운 메시지가 있으면 그룹 옆에 그림 표시 (파랑), 새로운 그룹도 똑같이 표시한다.

		//var li = $("<li></li>")

		var li = $("#listDummy li").clone(true);

		if (message.id == id) {
			li.attr({
				id : message.chatNo,
				'class' : 'log chat-me'
			})
		} else {
			li.attr({
				id : message.chatNo,
				'class' : 'log chat-other'
			})
		}

		li.find('table').attr({
			cellpading : 0,
			cellspacing : 0
		});

		li.find('.log-id').text(message.id);
		li.find('.log-content').text(message.content);
		li.find('.log-time').text(message.regDate.substr(11,5));

		$("#logList_" + groupNo).append(li);

		$("#roomModal_" + groupNo + " .modal-body")
			.scrollTop($("#roomModal_" + groupNo + " .row").height());
	}

	function onGroup(message) {
		console.log(message);

		var chatRoom = JSON.parse(message.body);
		var chatRoomDiv = $("#chatRoom_"+chatRoom.roomNo);

		if (chatRoomDiv.length != 0) {
			if (!chatRoom.roomName) {
				var members = "";

				for (var i in chatRoom.members) {
					if (chatRoom.members[i] == id) continue;
					members += " " + chatRoom.members[i];
				}
				chatRoomDiv.find(".list-group-item-heading h4").text(members);
				chatRoomDiv.find(".modal-title").text(members);
			}
			
			return;
		}
		
		var groupNo = chatRoom.roomNo;

		var chatRoomClone = $("#chatRoomDummy").clone(true);
		chatRoomClone.css("display", "block");
		chatRoomClone.attr("id", "chatRoom_" + groupNo);
		chatRoomClone.find(".roomModalLink").attr("href", "#roomModal_" + groupNo);
		chatRoomClone.find(".list-group-item-heading p").attr("id", "previewTime_" + groupNo);
		chatRoomClone.find(".list-group-item-text").attr("id", "preview_" + groupNo);
		chatRoomClone.find(".roomModal").attr("id", "roomModal_" + groupNo);
		chatRoomClone.find(".logList").attr("id", "logList_" + groupNo);
		chatRoomClone.find(".chatBox").attr("id", "chatBox_" + groupNo);
		chatRoomClone.find(".chatBtn").attr("id", "chatBtn_" + groupNo);
		chatRoomClone.find(".inviteModalLink").attr("id", "inviteModal_" + groupNo);
		chatRoomClone.find(".exitModal").attr("id", "exitModal_" + groupNo);
		chatRoomClone.find(".groupMemberModalLink").attr("id", "groupMemberModal_" + groupNo);

		if (!chatRoom.roomName) {
			var members = "";

			for (var i in chatRoom.members) {
				if (chatRoom.members[i] == id) continue;
				members += " " + chatRoom.members[i];
			}
			chatRoomClone.find(".list-group-item-heading h4").text(members);
			chatRoomClone.find(".modal-title").text(members);
		}

		$("#chatRoomList").prepend(chatRoomClone);
		
	}

	function onExitGroup(chatRoom) {
		console.group(chatRoom);

		var chatRoomDiv = $("#chatRoom_" + chatRoom.roomNo);
		if (!chatRoom.roomName) {
			var members = "";

			for (var i in chatRoom.members) {
				if (chatRoom.members[i] == id) continue;
				members += " " + chatRoom.members[i];
			}
			chatRoomClone.find(".list-group-item-heading h4").text(members);
			chatRoomClone.find(".modal-title").text(members);
		}
	}

	// friendList
	function onConnect(message) {
		console.log(message);

		$("#list-group-item-" + message.body).attr("class", "list-group-item isconnect");
		
	}
	function onDisconnect(message) {
		console.log(message);

		$("#list-group-item-" + message.body).attr("class", "list-group-item");
		/* $("#" + message.body + '_isconnect').remove(); */
	}

	function getTimeStamp() {
		var d = new Date();
		var s = leadingZeros(d.getFullYear(), 4) + '-'
				+ leadingZeros(d.getMonth() + 1, 2) + '-'
				+ leadingZeros(d.getDate(), 2) + ' ' +

				leadingZeros(d.getHours(), 2) + ':'
				+ leadingZeros(d.getMinutes(), 2) + ':'
				+ leadingZeros(d.getSeconds(), 2);

		return s;
	}

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}

	function sendGroupMessage(event) {
		var groupNo = event.target.id.split("_")[1];

		var text = $("#chatBox_" + groupNo).val();

		if (text == '')
			return;

		$("#chatBox_" + groupNo).val('');

		var data = {
			id : id,
			roomNo : groupNo,
			content : text
		}

		stompClient.send('/app/echo/group', {}, JSON.stringify(data));
	}

	$(function() {
		connect();

		$(".roomModalLink").on("click", function(event) {
			var target = $(event.target);
			var targetLink = null;

			while (!target.is("a")) {
				target = target.parent();
			}
			targetLink = target.attr("href");

			$(targetLink).modal();

		});

		$(".roomModal").on("show.bs.modal", function(event) {
			var target = $(event.target);
			var targetId = target.attr("id");
			var groupNo = targetId.split("_")[1];

			$.ajax({
				"url" : "/ssola2/chat/loadgrouplog.action",
				"method" : "get",
				"data" : {
					groupNo : groupNo
				},
				"dataType" : "json",
				success : function(data) {
					if (!data) {
						return false;
					}

					$.each(data, function(index, log) {
						//console.log(index);
						console.log(log);

						var li = $("#listDummy li").clone(true);

						if (log.id == id) {
							li.attr({
								id : log.chatNo,
								'class' : 'log chat-me'
							})
						} else {
							li.attr({
								id : log.chatNo,
								'class' : 'log chat-other'
							})
						}

						li.find('table').attr({
							cellpading : 0,
							cellspacing : 0
						});

						li.find('.log-id').text(log.id);
						li.find('.log-content').text(log.content);
						li.find('.log-time').text(log.regDate.substr(11,5));

						$("#logList_" + groupNo).append(li);
					});

					return;
				}
			});
		});

		$(".roomModal").on("shown.bs.modal",function(event) {
			var target = $(event.target);
			var targetId = target.attr("id");
			var groupNo = targetId.split("_")[1];

			$("#roomModal_" + groupNo + " .modal-body")
				.scrollTop($("#roomModal_" + groupNo + " .row").height());

			currentRoomNo = groupNo;
		});

		$(".roomModal").on("hidden.bs.modal", function(event) {
			var target = $(event.target);
			var targetId = target.attr("id");
			var groupNo = targetId.split("_")[1];

			$("#logList_" + groupNo).empty();

			currentRoomNo = null;
		});

		// 방 만들기 버튼을 눌렀을 때, 이벤트
		$("#viewFriends").on("click", function(event) {
			$.ajax({
				"url" : "/ssola2/chat/viewfriends.action",
				"method" : "get",
				"dataType" : "json",
				success : function(data) {
					$.each(data, function(index, friend) {
						var aTag =  $("<a></a>");
						
						aTag
						.attr({
							"href" : "#",
							"id" : "list-group-item-" + friend.id,
							"class" : "list-group-item friend"
						})
						.text(friend.id)
						.append(
							$("<input type='checkbox' class='pull-right'>")
						)
						.appendTo($("#makeList1"));
						
						if (friend.password == 1) {
							aTag.attr("class", "list-group-item friend login");
						}
					});
				}
			})
		});

		// 초대 버튼을 눌렀을 때, 내 친구중 해당 그룹에 속하지 않은 사람을 선택한다.
		$(".inviteModalLink").on("click", function(event) {
			var target = $(event.target);
			var targetLink = null;
			var groupNo;
			
			targetLink = target.attr("href");
			groupNo = target.attr("id").split("_")[1];

			/* if (event.target !== this) {
				targetLink = target.parent().attr("href");
				groupNo = target.parent().attr("id").split("_")[1];
			} else {
				targetLink = target.attr("href");
				groupNo = target.attr("id").split("_")[1];
			} */

			$("#inviteChatRoomNo").val(groupNo);

			var members = new Array;

			$.ajax({
				"url" : "/ssola2/chat/viewgroupmembers.action",
				"method" : "get",
				"data" : {
					"groupNo" : groupNo
				},
				"dataType" : "json",
				success : function(data) {
					$.each(data, function(index, member) {
						if (member != id) {
							members.push(member.id);
						}
					});

					$.ajax({
						"url" : "/ssola2/chat/viewfriends.action",
						"method" : "get",
						"dataType" : "json",
						success : function(data) {
							$.each(data, function(index, friend) {
								if ($.inArray(friend.id, members) == -1) {
									$("<a></a>")
									.attr({
										"href" : "#",
										"id" : "list-group-item-" + friend.id,
										"class" : "list-group-item friend"
									})
									.text(friend.id)
									.append(
										$("<input type='checkbox' class='pull-right'>")
									)
									.appendTo($("#inviteList1"));
								}
							});
						}
					});
				}
			});

			$(targetLink).modal();
		});

		$(".groupMemberModalLink").on("click", function(event) {
			var target = $(event.target);
			var targetLink;
			var groupNo;
			
			targetLink = target.attr("href");
			groupNo = target.attr("id").split("_")[1];

			$("#memberListGroupNo").val(groupNo);

			$.ajax({
				"url" : "/ssola2/chat/viewgroupmembers.action",
				"method" : "get",
				"data" : {
					groupNo : groupNo
				},
				"dataType" : "json",
				success : function(data) {
					$.each(data, function(index, member) {
						var aTag = $("<a></a>");
						
						aTag
						.attr({
							"href" : "/ssola2/mypage/mypage_friendmain.action?did=" + member.id,
							"id" : "list-group-item-" + member.id,
							"class" : "list-group-item member"
						})
						.text(member.id)
						.appendTo($("#memberList"));
						
						if (member.password == 1) {
							aTag.attr("class", "list-group-item member login");
						}
					});
				}
			});

			$(targetLink).modal();
		});

		// 종료시엔 공통적으로 리스트를 비워준다.
		$("#friendListModal").on("hidden.bs.modal", function(event) {
			$(".friend").remove();
		});

		$("#inviteListModal").on("hidden.bs.modal", function(event) {
			$(".friend").remove();

			$("#inviteChatRoomNo").val("");
		});
		
		$("#groupMemberListModal").on("hidden.bs.modal", function(event) {
			$(".member").remove();
			
			$("#memberListGroupNo").val("");
		});

		$("#makeChatRoom").on("click", function(event) {
			// 초대목록에 있는 친구 객체들을 불러온다.
			var friends = $("#makeList2 .friend");//.find(".friend");
			var list = new Array;

			friends.each(function(idx, item) {
				list.push(item.text);
			});
			list.push(id);

			$.ajax({
				"url" : "/ssola2/chat/makegroup.action",
				"method" : "get",
				"data" : {
					friends : JSON.stringify(list)
				},
				"dataType" : "json",
				success : function(chatRoom) {
					stompClient.send('/app/notice/group', {}, JSON.stringify(chatRoom));
					alert("채팅방을 만들었습니다");
				}
			});
		});

		$("#inviteChatRoom").on("click", function(event) {
			// 초대목록에 있는 친구 객체들을 불러온다.
			var friends = $("#inviteList2 .friend");//.find(".friend");
			var groupNo = $("#inviteChatRoomNo").val();
			var list = new Array;
			var friendsName = "";

			friends.each(function(idx, item) {
				list.push(item.text);
				friendsName += item.text + ", ";
			});

			$.ajax({
				"url" : "/ssola2/chat/invitegroup.action",
				"method" : "get",
				"data" : {
					friends : JSON.stringify(list),
					groupNo : groupNo
				},
				"dataType" : "json",
				success : function(chatRoom) {
					stompClient.send('/app/notice/group', {}, JSON.stringify(chatRoom));
					
					alert(friendsName + "님을 초대했습니다");
				}
			});
		});

		$(".exitModal").on("click", function(event) {
			var target = $(event.target);
			var groupNo;

			if (event.target !== this) {
				groupNo = target.parent().attr("id").split("_")[1];
			} else {
				groupNo = target.attr("id").split("_")[1];
			}

			stompClient.send("/app/notice/group-exit", {}, JSON.stringify({
				"roomNo" : groupNo,
				"id" : id
			}));

			$("#roomModal_" + groupNo).modal('hide');
			$("#chatRoom_" + groupNo + " > .roomModalLink").remove();
		});

		$(".chatBtn").on("click", function(event) {
			sendGroupMessage(event);
		});

		$(".chatBox").on("keydown", function(event) {
			if (event.keyCode != 13)
				return;
			sendGroupMessage(event);
		});

		$('#makeAdd').click(function() {
			$('.all').prop("checked", false);
			var items = $("#makeList1 input:checked:not('.all')");
			var n = items.length;
			if (n > 0) {
				items.each(function(idx, item) {
					var choice = $(item);
					choice.prop("checked", false);
					choice.parent().appendTo("#makeList2");
				});
			} else {
				alert("Choose an item from list 1");
			}
		});

		$('#makeRemove').click(function() {
			$('.all').prop("checked", false);
			var items = $("#makeList2 input:checked:not('.all')");
			items.each(function(idx, item) {
				var choice = $(item);
				choice.prop("checked", false);
				choice.parent().appendTo("#makeList1");
			});
		});

		$('#inviteAdd').click(function() {
			$('.all').prop("checked", false);
			var items = $("#inviteList1 input:checked:not('.all')");
			var n = items.length;
			if (n > 0) {
				items.each(function(idx, item) {
					var choice = $(item);
					choice.prop("checked", false);
					choice.parent().appendTo("#inviteList2");
				});
			} else {
				alert("Choose an item from list 1");
			}
		});

		$('#inviteRemove').click(function() {
			$('.all').prop("checked", false);
			var items = $("#inviteList2 input:checked:not('.all')");
			items.each(function(idx, item) {
				var choice = $(item);
				choice.prop("checked", false);
				choice.parent().appendTo("#inviteList1");
			});
		});

		/* toggle all checkboxes in group */
		$('.all').click(
				function(e) {
					e.stopPropagation();
					var $this = $(this);
					if ($this.is(":checked")) {
						$this.parents('.list-group').find("[type=checkbox]")
								.prop("checked", true);
					} else {
						$this.parents('.list-group').find("[type=checkbox]")
								.prop("checked", false);
						$this.prop("checked", false);
					}
				});

		$('[type=checkbox]').click(function(e) {
			e.stopPropagation();
		});

		/* toggle checkbox when list group item is clicked */
		$('.list-group a').click(function(e) {

			e.stopPropagation();

			var $this = $(this).find("[type=checkbox]");
			if ($this.is(":checked")) {
				$this.prop("checked", false);
			} else {
				$this.prop("checked", true);
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
			<a href="/ssola2/main/main.action" id="goToMain" class="btn btn-success btn-lg">메인화면</a>
			<Button type="button" id="viewFriends" class="btn btn-info btn-lg"
				data-toggle="modal" data-target="#friendListModal">친구목록</Button>
		</div>
		&nbsp;
		<div id="chatRoomList" class="list-group col-sm-6 col-sm-offset-3">
			<c:forEach var="room" items="${chatRooms}">
				<div id="chatRoom_${ room.roomNo }">
					<!-- a링크에 해당 모달 여는 코드 적용 -->
					<a href="#roomModal_${ room.roomNo }"
						class="roomModalLink btn list-group-item">
						<span class="list-group-item-heading">
							<h4>
								<!-- class="list-group-item-heading" -->
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
							<p id="previewTime_${ room.roomNo }" style="float: right">
								<fmt:parseDate value="${ room.lastLog.regDate }" var="dateFmt"
									pattern="yyyy-MM-dd HH:mm:ss.S" scope="page" />
								<fmt:formatDate value="${ dateFmt }" pattern="MM-dd HH:mm" />
							</p>
					</span>
						<p class="list-group-item-text" id="preview_${ room.roomNo }"
							style="text-align: left">${ room.lastLog.id }: ${ room.lastLog.content }
						</p>
					</a>
					<!-- 여기서부터 채팅방 모달 -->
					<div id="roomModal_${ room.roomNo }" class="roomModal modal fade"
						role="dialog">
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
									<!-- 여기에 입력창 -->
									<div class="col-md-12 text-center">
										<span class="dropup col-md-2">
											<button type="button" class="btn btn-default dropdown-toggle" id="dropdownMenu"
												data-toggle="dropdown" aria-hashpopup="true" aria-expanded="false">
												DropUp
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
											    <li><a href="#inviteListModal" id="inviteModal_${ room.roomNo }" class="inviteModalLink">초대</a></li>
									    		<li><a href="#groupMemberListModal" id="groupMemberModal_${ room.roomNo }" class="groupMemberModalLink">멤버 보기</a></li>
											    <li role="separator" class="divider"></li>
											    <li><a href="#" id="exitModal_${ room.roomNo }" class="exitModal">퇴장</a></li>
										  	</ul>
										</span>
										<span class="col-md-4 col-md-offset-2"> <input type="text" class="chatBox"
											id="chatBox_${ room.roomNo }"> <input type="button"
											class="chatBtn" id="chatBtn_${ room.roomNo }" value="보내기">
										</span>
										<!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
									</div>
								</div>
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
						<h4 class="modal-title">Make ChatRoom</h4>
					</div>
					<div class="modal-body">
						<!-- <p>Some text in the modal.</p> -->
						<div class="row">
							<div class="col-sm-12 text-center">
								<h3>Friend List</h3>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<div class="list-group" id="makeList1">
									<a href="#" class="list-group-item active">친구 목록<input
										title="toggle all" type="checkbox" class="all pull-right"></a>
								</div>
							</div>
							<div class="col-sm-2 v-center">
								<button title="초대" id="makeAdd" class="btn btn-default center-block add">
									<i class="glyphicon glyphicon-chevron-right"></i>
								</button>
								<button title="초대 취소" id="makeRemove"
									class="btn btn-default center-block remove">
									<i class="glyphicon glyphicon-chevron-left"></i>
								</button>
							</div>
							<div class="col-sm-4">
								<div class="list-group" id="makeList2">
									<a href="#" class="list-group-item active">초대 목록<input
										title="toggle all" type="checkbox" class="all pull-right"></a>
									<!-- <a href="#" class="list-group-item">Bravo <input type="checkbox" class="pull-right"></a> -->
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="makeChatRoom" class="btn btn-default" data-dismiss="modal">Make</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div id="inviteListModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Invite Friend</h4>
					</div>
					<div class="modal-body">
						<!-- <p>Some text in the modal.</p> -->
						<div class="row">
							<div class="col-sm-12 text-center">
								<h3>Friend List</h3>
							</div>
							<div class="col-sm-4 col-sm-offset-1">
								<div class="list-group" id="inviteList1">
									<a href="#" class="list-group-item active">친구 목록<input
										title="toggle all" type="checkbox" class="all pull-right"></a>
								</div>
							</div>
							<div class="col-sm-2 v-center">
								<button title="초대" id="inviteAdd" class="btn btn-default center-block add">
									<i class="glyphicon glyphicon-chevron-right"></i>
								</button>
								<button title="초대 취소" id="inviteRemove"
									class="btn btn-default center-block remove">
									<i class="glyphicon glyphicon-chevron-left"></i>
								</button>
							</div>
							<div class="col-sm-4">
								<div class="list-group" id="inviteList2">
									<a href="#" class="list-group-item active">초대 목록<input
										title="toggle all" type="checkbox" class="all pull-right"></a>
									<!-- <a href="#" class="list-group-item">Bravo <input type="checkbox" class="pull-right"></a> -->
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<input type="hidden" id="inviteChatRoomNo" value=""/>
						<button type="button" id="inviteChatRoom" class="inviteChatRoom btn btn-default" data-dismiss="modal">Invite</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<div id="groupMemberListModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Group Member</h4>
					</div>
					<div class="modal-body">
						<!-- <p>Some text in the modal.</p> -->
						<div class="row">
							<div class="col-md-12 text-center">
								<h3>Member List</h3>
							</div>
							<div class="col-sm-8 col-sm-offset-2">
								<div class="list-group" id="memberList">
									<a href="#" class="list-group-item active">친구 목록</a>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<input type="hidden" id="memberListGroupNo" value="" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<div id="listDummy" style="display:none;">
			<li class="log">
				<table>
					<tr>
						<td class="profile-td">
						</td>
						<td class="chat-td">
							<div class="log-id"></div>
							<div class="log-content"></div>
						</td>
						<td class="time-td">
							<div class="log-time"></div>
						</td>
					</tr>
				</table>
			</li>
		</div>

		<div id="chatRoomDummy" style="display:none">
			<!-- a링크에 해당 모달 여는 코드 적용 -->
				<a href="#roomModal_${ room.roomNo }"
					class="roomModalLink btn list-group-item">
					<span class="list-group-item-heading">
						<h4>
							<!-- 여기에 채팅방 이름 -->
						</h4>
						<p id="previewTime_${ room.roomNo }" style="float: right">
							<!-- 여기에 최신 로그 시간 -->
						</p>
					</span>
					<p class="list-group-item-text" id="preview_${ room.roomNo }"
						style="text-align: left">${ room.lastLog.id }: ${ room.lastLog.content }
					</p>
				</a>
				<!-- 여기서부터 채팅방 모달 -->
				<div id="roomModal_${ room.roomNo }" class="roomModal modal fade"
					role="dialog">
					<div class="modal-dialog modal-lg">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">
									<!-- 여기에 채팅방 이름 -->
								</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12 text-center chatList">
										<!-- 여기에 텍스트 로그 -->
										<ul id="logList_${ room.roomNo }" class="logList"></ul>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<!-- 여기에 입력창 -->
								<span class="dropup col-md-2">
									<button type="button" class="btn btn-default dropdown-toggle" id="dropdownMenu"
										data-toggle="dropdown" aria-hashpopup="true" aria-expanded="false">
										DropUp
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
									    <li><a href="#inviteListModal" id="inviteModal_${ room.roomNo }" class="inviteModalLink">초대</a></li>
									    <li><a href="#groupMemberListModal" id="groupMemberModal_${ room.roomNo }" class="groupMemberModalLink">멤버 보기</a></li>
									    <li role="separator" class="divider"></li>
									    <li><a href="#" id="exitModal_${ room.roomNo }" class="exitModal">퇴장</a></li>
								  	</ul>
								</span>
								<span class="col-md-4 col-md-offset-2"> <input type="text" class="chatBox"
									id="chatBox_${ room.roomNo }"> <input type="button"
									class="chatBtn" id="chatBtn_${ room.roomNo }" value="보내기">
								</span>
							</div>
						</div>
					</div>
				</div>
		</div>

		<%-- <c:import url="/WEB-INF/views/include/footer.jsp" /> --%>
	</div>
</body>
</html>
