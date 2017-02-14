package com.ssola2.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.ChatRoom;
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

}
