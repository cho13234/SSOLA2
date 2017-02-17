package com.ssola2.listener;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.ssola2.model.dto.LoginUser;
import com.ssola2.model.dto.LoginUserSession;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.ChatService;

public class StompDisconnectEvent implements ApplicationListener<SessionDisconnectEvent> {

	private static final Logger logger = LoggerFactory.getLogger(StompDisconnectEvent.class);
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	private LoginUserSession loginUserSession;
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@Override
	public void onApplicationEvent(SessionDisconnectEvent event) {
		StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
		
		
		Map<String, Object> sessionAttributes = sha.getSessionAttributes();
		
		//sessionId를 기준으로 db상에 is_connect 값을 0으로 바꿔서 접속중이 아님을 알린다.
		Member member = (Member)sessionAttributes.get("loginuser");
		//chatService.setNotLoginById(member.getId());
		
		LoginUser user = loginUserSession.getLoginUser(member.getId());
		
		if (user == null) {
			// 에러
			return;
		} else {
			user.setIsConnect(user.getIsConnect() - 1);
		}
		
		logger.info("[SessionId: " + sha.getSessionId() + "] [Connect count: " + user.getIsConnect() + "]");
		
		if (user.getIsConnect() < 1) {
			logger.info(event.toString());
			logger.info("Disconnect event [SessionId: " + sha.getSessionId() + 
					"], [Message: " + sha.getMessage() + "]");
			
			//여기서 sessionID를 기준으로 LOGIN_MEMBER 테이블에서 내 id를 가져오고 이를 바탕으로 접속 종료를 친구들에게 알린다.
			ArrayList<Member> friends = (ArrayList) chatService.searchFriendListById(member.getId());
			for (Member friend : friends) {
				if (loginUserSession.getLoginUser(friend.getId()) != null) {
					simpMessagingTemplate.convertAndSend("/queue/notice/friend-disconnect-" + friend.getId(),
							member.getId());					
				}
			}
		}
		
	}
	
}
