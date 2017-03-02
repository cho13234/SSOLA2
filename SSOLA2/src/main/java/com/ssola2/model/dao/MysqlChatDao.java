package com.ssola2.model.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatMember;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;
import com.ssola2.model.mapper.ChatMapper;

@Repository(value="chatDao")
public class MysqlChatDao implements ChatDao {

	@Autowired
	@Qualifier("chatMapper")
	private ChatMapper chatMapper;
	
	@Override
	public List<ChatRoom> selectChatRoomListById(String id) {
		return chatMapper.selectChatRoomListById(id);
	}

	@Override
	public List<Member> selectFriendListById(String id) {
		return chatMapper.selectFriendListById(id);
	}

	@Override
	public List<ChatLog> selectGroupLogByGroupNo(int groupNo) {
		return chatMapper.selectGroupLogByGroupNo(groupNo);
	}

	@Override
	public void insertChatLog(ChatLog chatLog) {
		chatMapper.insertChatLog(chatLog);
	}

	@Override
	public List<String> selectGroupMemberByGroupNo(String groupNo) {
		return chatMapper.selectGroupMemberByGroupNo(groupNo);
	}

	@Override
	public void insertChatRoom(ChatRoom chatRoom) {
		chatMapper.insertChatRoom(chatRoom);
	}

	@Override
	public void insertChatMember(ChatMember chatMember) {
		chatMapper.insertChatMember(chatMember);
	}

	@Override
	public void updateChatRoom(ChatRoom chatRoom) {
		chatMapper.updateChatRoom(chatRoom);
	}

	@Override
	public ChatRoom selectChatRoomByRoomNo(int roomNo) {
		return chatMapper.selectChatRoomByRoomNo(roomNo);
	}

	@Override
	public void updateChatMemberDeletedTrue(ChatMember chatMember) {
		chatMapper.updateChatMemberDeletedTrue(chatMember);
	}

}
