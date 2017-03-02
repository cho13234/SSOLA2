package com.ssola2.model.dto;

import com.google.gson.Gson;

public class ChatMember {
	private String id;
	private int roomNo;
	private String lastConnect;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getLastConnect() {
		return lastConnect;
	}
	public void setLastConnect(String lastConnect) {
		this.lastConnect = lastConnect;
	}
	
	public static ChatMember convertMessage(String source) {
		ChatMember message = new ChatMember();
		Gson gson = new Gson();
		
		message = gson.fromJson(source, ChatMember.class);
		
		return message;
	}
	
}
