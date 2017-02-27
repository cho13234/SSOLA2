package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatMember;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

public interface ChatMapper {

	List<ChatRoom> selectChatRoomListById(String id);

	List<Member> selectChatMemberListById(String id);
	
	List<Member> selectFriendListById(String id);

	String selectSessionIdById(String id);

//	void updateSessionIdById(String id, String sessionId);
	void updateSessionIdById(HashMap<String, Object> map);

//	void insertLoginMember(String id, String sessionId);
	void insertLoginMember(HashMap<String, Object> map);

	void updateNotLoginById(String id);

	void updateNotLoginAllUser();

	List<ChatLog> selectGroupLogByGroupNo(int groupNo);

	void insertChatLog(ChatLog chatLog);

	List<String> selectGroupMemberByGroupNo(String groupNo);

	void insertChatRoom(ChatRoom chatRoom);

	void insertChatMember(ChatMember chatMember);
}
