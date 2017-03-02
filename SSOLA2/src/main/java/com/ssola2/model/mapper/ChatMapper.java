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

	List<Member> selectFriendListById(String id);

	List<ChatLog> selectGroupLogByGroupNo(int groupNo);

	void insertChatLog(ChatLog chatLog);

	List<String> selectGroupMemberByGroupNo(String groupNo);

	void insertChatRoom(ChatRoom chatRoom);

	void insertChatMember(ChatMember chatMember);

	void updateChatRoom(ChatRoom chatRoom);

	ChatRoom selectChatRoomByRoomNo(int roomNo);

	void updateChatMemberDeletedTrue(ChatMember chatMember);
}
