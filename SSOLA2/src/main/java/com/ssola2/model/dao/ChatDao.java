package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;

public interface ChatDao {
	
	public List<ChatRoom> selectChatRoomListById(String id);
}