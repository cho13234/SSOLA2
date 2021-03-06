package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatMember;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

public interface ChatDao {
	
	public List<ChatRoom> selectChatRoomListById(String id);

	public List<Member> selectFriendListById(String id);

	public List<ChatLog> selectGroupLogByGroupNo(int groupNo);

	public void insertChatLog(ChatLog chatLog);

	public List<String> selectGroupMemberByGroupNo(String groupNo);

	public void insertChatRoom(ChatRoom chatRoom);

	public void insertChatMember(ChatMember chatMember);

	public void updateChatRoom(ChatRoom chatRoom);

	public ChatRoom selectChatRoomByRoomNo(int roomNo);

	public void updateChatMemberDeletedTrue(ChatMember chatMember);
}