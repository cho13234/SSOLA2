package com.ssola2.model.dto;

import com.google.gson.Gson;

public class MessageVO {

	private String message;
	private String roomNo;
	private String from;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public static MessageVO convertMessage(String source) {
		MessageVO message = new MessageVO();
		Gson gson = new Gson();
		
		message = gson.fromJson(source, MessageVO.class);
		
		return message;
	}
}