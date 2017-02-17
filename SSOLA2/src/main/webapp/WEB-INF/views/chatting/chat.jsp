<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>

<html>
<head>
	<title>Home</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="/ssola2/resources/scripts/sockjs-1.0.0.min.js"></script>
	<script type="text/javascript" src="/ssola2/resources/scripts/stomp.js"></script>
	<script type="text/javascript">
		
		var sock = null;
		var stompClient = null;
		var id = '${id}';
		
		function connect() {
			//sock = new SockJS("/mychat/echo");
			sock = new SockJS("/ssola2/stomp");
			stompClient = Stomp.over(sock);
			stompClient.connect({}, function(frame) {
				console.log('connected stomp over sockjs');

				stompClient.subscribe('/queue/notice', onMessage);
				stompClient.subscribe('/queue/echo', onMessage);
				stompClient.subscribe('/queue/private-${id}', onMessage);
				
				stompClient.send('/app/greeting', {}, id);
				stompClient.send('/app/hello', {}, id);
			});
		}
		
		function onMessage(message) {
			console.log(message);
			$("#chatMessage").append(message.body + "<br/>");
		}
		
		$(function() {
			connect();
			
			$("#sendMessage").on("click", function() {
				var sendMessage = $("#message").val();
				
				if(sendMessage != "") {
					if($("#to").val() != "") {
						var data = {
								from : id,
								to : $("#to").val(),
								message : sendMessage 
						};
						
						stompClient.send("/app/private", {}, JSON.stringify(data));
					} else {
						var data = {
								from : id,
								message : sendMessage 
						};
						
						stompClient.send("/app/echo", {}, JSON.stringify(data));
					}
				}
			});
			
			$("#changeNickname").on("click", function() {
				var nickname = $("#nickname").val();
				
				if(nickname != "") {
					
					var befId = id;
					id = nickname;
					
					alert("id가 " + id + "으로 변경되었습니다");
					$("nickname").val(id);
					
					var data = {
						from : befId,
						to : id
					};
					
					stompClient.send("/app/echo/change_id", {}, JSON.stringify(data));
				}
			});
		})
	</script>
</head>
<body>
	<h4>Chatting Page</h4>
	<div>
		<input type="text" id="nickname" value="${ id }"/>
		<input type="button" id="changeNickname" value="아이디 바꾸기"/>
	</div>
	<div>
		<input type="text" id="to" />
		<input type="text" id="message" />
	</div>
	<input type="button" id="sendMessage" value="메시지 보내기" />
	
	<div id="chatMessage"></div>
</body>
</html>
