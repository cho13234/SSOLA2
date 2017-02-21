package com.ssola2.model.dto;

import com.google.gson.Gson;

public class ChatLog {
	
	private int chatNo;
	private String regDate;
	private String content;
	private String roomNo;
	private String id;
	
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public static ChatLog convertMessage(String source) {
		ChatLog message = new ChatLog();
		Gson gson = new Gson();
		
		message = gson.fromJson(source, ChatLog.class);
		
		return message;
	}
}
