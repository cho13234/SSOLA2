package com.ssola2.listener;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationListener;
import org.springframework.http.HttpRequest;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.ssola2.model.dto.LoginUser;
import com.ssola2.model.dto.LoginUserSession;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.ChatService;

public class StompConnectEvent implements ApplicationListener<SessionConnectEvent> {

	private static final Logger logger = LoggerFactory.getLogger(StompConnectEvent.class);
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	private LoginUserSession loginUserSession; //현재 접속중인 유저의 목록을 갖고있는 클래스
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;

	@Override
	public void onApplicationEvent(SessionConnectEvent event) {
		logger.info(event.getMessage().toString());
		/*StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
		
		// session에서 login 정보를 불러와 id를 바탕으로 sessionId를 설정한다.
		
		Map<String, Object> sessionAttributes = sha.getSessionAttributes();
		Member member = (Member) sessionAttributes.get("loginuser");
		
		LoginUser user = loginUserSession.getLoginUser(member.getId());
		
		if (user == null) {
			user = new LoginUser();
			user.setId(member.getId());
			user.setIsConnect(1);
			
			loginUserSession.putLoginUser(user);
			
			logger.info(event.toString());
			logger.info("Connect event [SessionId: " + sha.getSessionId() + 
							"], [Message: " + sha.getMessage() + "]");
		} else {
			user.setIsConnect(user.getIsConnect() + 1);
			
			loginUserSession.putLoginUser(user);
		}
		
		logger.info("[SessionId: " + sha.getSessionId() + "] [Connect count: " + user.getIsConnect() + "]");
		
		if (user.getIsConnect() == 1) {
			// id를 기준으로 현재 접속중인 (is_connect == 1) 친구의 목록을 불러오고 각 친구에게 내가 접속했음을 알린다.
			ArrayList<Member> friends = (ArrayList) chatService.searchFriendListById(member.getId());
			for (Member friend : friends) {
				if (loginUserSession.getLoginUser(friend.getId()) != null) {
					simpMessagingTemplate.convertAndSend("/queue/notice/friend-connect-" + friend.getId(),
							member.getId());
				}
			}
		}*/
		
	}
	
}
