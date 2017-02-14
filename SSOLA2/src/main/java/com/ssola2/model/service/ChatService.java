package com.ssola2.model.service;

import java.util.ArrayList;
import java.util.List;

import com.ssola2.model.dto.ChatRoom;

public interface ChatService {

	public List<ChatRoom> searchChatRoomListById(String id);
}
