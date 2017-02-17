package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

public interface ChatDao {
	
	public List<ChatRoom> selectChatRoomListById(String id);

	public List<Member> selectChatMemberListById(String id);

	public String selectSessionIdById(String id);

	public void updateSessionIdById(String id, String sessionId);

	public void insertSessionIdById(String id, String sessionId);

	public List<Member> selectFriendListById(String id);

	public void updateNotLoginById(String id);

	public void updateNotLoginAllUser();

	public List<ChatLog> selectGroupLogByGroupNo(int groupNo);

	public void insertChatLog(MessageVO messageVO);
}