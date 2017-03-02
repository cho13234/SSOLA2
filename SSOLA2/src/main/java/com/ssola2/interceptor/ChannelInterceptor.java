package com.ssola2.interceptor;

import java.util.ArrayList;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptorAdapter;
import org.springframework.messaging.support.MessageHeaderAccessor;

import com.ssola2.model.dto.LoginUser;
import com.ssola2.model.dto.LoginUserSession;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.ChatService;

public class ChannelInterceptor extends ChannelInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(ChannelInterceptor.class);
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	private LoginUserSession loginUserSession; //현재 접속중인 유저의 목록을 갖고있는 클래스
	
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;

	@Override
	public Message<?> preSend(Message<?> message, MessageChannel channel) {
		StompHeaderAccessor sha = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
		
		Map<String, Object> sessionAttributes = sha.getSessionAttributes();
		Member member = (Member)sessionAttributes.get("loginuser");
		LoginUser user = loginUserSession.getLoginUser(member.getId());
		
		if (StompCommand.CONNECT.equals(sha.getCommand())) {
			// 여기서 접속관리
			logger.info("in InboundChannel : CONNECT"); 
			
			//String id = sha.getNativeHeader("id").get(0);
			
			if (user == null) {
				user = new LoginUser();
				user.setId(member.getId());
				user.setIsConnect(1);
				
				loginUserSession.putLoginUser(user);
				
				logger.info("Connect event [SessionId: " + sha.getSessionId() + 
								"], [Message: " + sha.getMessage() + "]");
			} else {
				user.setIsConnect(user.getIsConnect() + 1);
				
				loginUserSession.putLoginUser(user);
			}
			
			logger.info("[SessionId: " + sha.getSessionId() + "] [Connect count: " + user.getIsConnect() + "]");
			
			if (user.getIsConnect() == 1) {
				// id를 기준으로 현재 접속중인 (is_connect == 1) 친구의 목록을 불러오고 각 친구에게 내가 접속했음을 알린다.
				ArrayList<Member> friends = (ArrayList) chatService.searchFriendListById(user.getId());
				for (Member friend : friends) {
					if (loginUserSession.getLoginUser(friend.getId()) != null) {
						simpMessagingTemplate.convertAndSend("/queue/notice/friend-connect-" + friend.getId(),
								user.getId());
					}
				}
			}
			
		} else if (StompCommand.DISCONNECT.equals(sha.getCommand())) {
			// 여기서 접속해제 관리
			logger.info("in InboundChannel : DISCONNECT"); 
			
			if (user == null) {
				// 에러
				return null;
			} else {
				user.setIsConnect(user.getIsConnect() - 1);
			}
			
			logger.info("[SessionId: " + sha.getSessionId() + "] [Connect count: " + user.getIsConnect() + "]");
			
			if (user.getIsConnect() < 1) {
				logger.info("Disconnect event [SessionId: " + sha.getSessionId() + 
						"], [Message: " + sha.getMessage() + "]");
				
				//여기서 sessionID를 기준으로 Member 테이블에서 내 id를 가져오고 이를 바탕으로 접속 종료를 친구들에게 알린다.
				ArrayList<Member> friends = (ArrayList) chatService.searchFriendListById(user.getId());
				for (Member friend : friends) {
					if (loginUserSession.getLoginUser(friend.getId()) != null) {
						simpMessagingTemplate.convertAndSend("/queue/notice/friend-disconnect-" + friend.getId(),
								user.getId());
					}
				}
			}
		}
		
		return message;
	}
}
