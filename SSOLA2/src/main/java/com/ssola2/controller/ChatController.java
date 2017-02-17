package com.ssola2.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.LoginUserSession;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.ChatService;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {

	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	private LoginUserSession loginUserSession;
	
	@RequestMapping(value = "chatlist.action", method = RequestMethod.GET)
	public String viewChatRoom(Model model, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginuser");
		model.addAttribute("id", member.getId());
		
		//service에서 내 id가 등록된 chatroom을 전부 조회해 보여준다.
		ArrayList<ChatRoom> chatRooms = (ArrayList)chatService.searchChatRoomListById(member.getId());
		model.addAttribute("chatRooms", chatRooms);

		//service에서 내 id로 등록된 현재 접속중인 친구목록을 가져온다.
		ArrayList<Member> friendList = (ArrayList)chatService.searchFriendListById(member.getId());
		ArrayList<Member> friends = new ArrayList<Member>();
		
		for (Member friend : friendList) {
			if (loginUserSession.getLoginUser(friend.getId()) != null) {
				friends.add(friend);
			}
		}
		
		model.addAttribute("friendList", friends);

		return "chatting/chat";
		//return "chatting/chatlist";
	}
	
	@RequestMapping(value = "loadgrouplog.action", method = RequestMethod.GET)
	@ResponseBody
	public String loadGroupLog(int groupNo) {
		
		ArrayList<ChatLog> groupLog = (ArrayList) chatService.searchGroupLogByGroupNo(groupNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String logs = gson.toJson(groupLog);
		
		return logs;
	}
	
	/*@RequestMapping(value= "friendlist.action", method = RequestMethod.GET)
	@ResponseBody
	public String viewFriendList(Model model, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginuser");
		//model.addAttribute("id", member.getId());
		
		ArrayList<Member> friendList = (ArrayList)chatService.searchFriendListById(member.getId());
		model.addAttribute("friendList", friendList);
		
		return "chatting/friendlist";
	}*/
}
