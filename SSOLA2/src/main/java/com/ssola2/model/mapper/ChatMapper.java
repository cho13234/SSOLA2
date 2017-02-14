package com.ssola2.model.mapper;

import java.util.List;

import com.ssola2.model.dto.ChatRoom;

public interface ChatMapper {

	List<ChatRoom> selectChatRoomListById(String id);
}
