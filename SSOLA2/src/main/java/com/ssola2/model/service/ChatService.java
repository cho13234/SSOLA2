package com.ssola2.model.service;

import java.util.ArrayList;
import java.util.List;

import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

public interface ChatService {

	public List<ChatRoom> searchChatRoomListById(String id);

	public List<Member> searchChatMemberListById(String from);

	public void setSessionIdById(String id, String sessionId);

	public List<Member> searchFriendListById(String id);

	public void setNotLoginById(String id);

	public void setNotLoginAllUser();

	public List<ChatLog> searchGroupLogByGroupNo(int groupNo);

	public void addChatLog(MessageVO messageVO);
}
