package com.ssola2.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.LoginUserSession;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;
import com.ssola2.model.service.ChatService;

@Controller
public class EchoController {

	private static final Logger logger = LoggerFactory.getLogger(EchoController.class);
	
	// 귓속말을 위해 만든 Collection 실제 사용에선 id - sessionId로 매핑해 사용하고, 닉네임 변경을 하지 않을 수 있으므로
	// 혹은 닉네임을 사용해도 DB와의 연결을 통해 사용하는 방식으로 변경한다.
	//private Map<String, String> connectedUsers = new HashMap<String, String>();
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("org.springframework.messaging.simp.SimpMessagingTemplate#0")
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@Autowired
	private LoginUserSession loginUserSession;
	
	// debugging
	@MessageMapping("/hello")
	public void hello(String message) {
		logger.info(message);
	}
	
	// debugging
	@MessageMapping("/greeting")
	public void sendGreeting(String message) {
		
		MessageVO messageVO = MessageVO.convertMessage(message);
		logger.info(messageVO.getFrom() + " 입장");
		
		//simpMessagingTemplate.convertAndSend("/queue/notice-group-" + messageVO.getRoomNo(),
		//		messageVO.getFrom() + "님이 입장하셨습니다.");
		//simpMessagingTemplate.convertAndSend("/queue/notice-friend-" + messageVO.getRoomNo(),
		//		messageVO.getFrom() + "님이 입장하셨습니다.");
	}
	
	//@MessageMapping("/echo")
	@MessageMapping("/echo/group")
	public void sendEcho(String message) {
		logger.info("/echo/group" + message);
		
		//MessageVO messageVO = MessageVO.convertMessage(message);
		ChatLog chatLog = ChatLog.convertMessage(message);
		
		//chatService.addChatLog(messageVO);
		chatService.addChatLog(chatLog);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		chatLog.setRegDate(sdf.format(new Date()));
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String message1 = gson.toJson(chatLog);
		
		//ArrayList<String> members = (ArrayList<String>) chatService.searchGroupMemberByGroupNo(messageVO.getRoomNo());
		ArrayList<String> members = (ArrayList<String>) chatService.searchGroupMemberByGroupNo(chatLog.getRoomNo());
		
		for (String member : members) {
			// 이런 접속자 관리가 꼭 필요한지 의문 = 한 그룹에 최대 멤버의 수를 줄이면 필요가 없을 수 있음
			if (loginUserSession.getLoginUser(member) != null) {
				simpMessagingTemplate.convertAndSend("/queue/notice/group-" + member, message1);
			}
		}
		
		simpMessagingTemplate.convertAndSend("/queue/echo/group-" + chatLog.getRoomNo(),
				message1);
	}
}
