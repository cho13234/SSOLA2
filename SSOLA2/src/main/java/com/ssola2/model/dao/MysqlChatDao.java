package com.ssola2.model.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.ChatLog;
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
	public List<Member> selectChatMemberListById(String id) {
		return chatMapper.selectChatMemberListById(id);
	}

	@Override
	public String selectSessionIdById(String id) {
		return chatMapper.selectSessionIdById(id);
	}

	@Override
	public void updateSessionIdById(String id, String sessionId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("sessionId", sessionId);
		
		chatMapper.updateSessionIdById(map);
	}

	@Override
	public void insertSessionIdById(String id, String sessionId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("sessionId", sessionId);
		
		chatMapper.insertLoginMember(map);
	}

	@Override
	public List<Member> selectFriendListById(String id) {
		return chatMapper.selectFriendListById(id);
	}

	@Override
	public void updateNotLoginById(String id) {
		chatMapper.updateNotLoginById(id);
	}

	@Override
	public void updateNotLoginAllUser() {
		chatMapper.updateNotLoginAllUser();
	}

	@Override
	public List<ChatLog> selectGroupLogByGroupNo(int groupNo) {
		return chatMapper.selectGroupLogByGroupNo(groupNo);
	}

	@Override
	public void insertChatLog(MessageVO messageVO) {
		chatMapper.insertChatLog(messageVO);
	}

}
