package com.ssola2.controller;

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
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@MessageMapping("/hello")
	public void hello(String message) {
		logger.info(message);
	}
	
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
		logger.info(message);
		
		MessageVO messageVO = MessageVO.convertMessage(message);
		
		chatService.addChatLog(messageVO);
		
		simpMessagingTemplate.convertAndSend("/queue/echo/group-" + messageVO.getRoomNo(),
				message);
	}
}
