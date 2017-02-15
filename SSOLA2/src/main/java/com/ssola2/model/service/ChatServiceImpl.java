package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.ChatDao;
import com.ssola2.model.dto.ChatRoom;

@Service(value="chatService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	@Qualifier("chatDao")
	private ChatDao chatDao;

	@Override
	public List<ChatRoom> searchChatRoomListById(String id) {
		return chatDao.selectChatRoomListById(id);
	}

}
