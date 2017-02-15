package com.ssola2.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.ChatService;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {

	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@RequestMapping(value = "chatroom", method = RequestMethod.GET)
	public String viewChatRoom(Model model, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginuser");
		//service에서 내 id가 등록된 chatroom을 전부 조회해 보여준다.
		
		ArrayList<ChatRoom> chatRooms = (ArrayList)chatService.searchChatRoomListById(member.getId());
		model.addAttribute("chatRooms", chatRooms);
		
		return "chatting/chat";
	}
}
