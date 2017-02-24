package com.ssola2.model.dto;

import java.util.ArrayList;

import com.google.gson.Gson;

public class ChatRoom {
	private int roomNo;
	private int memberSize;
	private String roomName;
	private ChatLog lastLog;
	private ArrayList<String> members;
	
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getMemberSize() {
		return memberSize;
	}
	public void setMemberSize(int memberSize) {
		this.memberSize = memberSize;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public ChatLog getLastLog() {
		return lastLog;
	}
	public void setLastLog(ChatLog lastLog) {
		this.lastLog = lastLog;
	}
	public ArrayList<String> getMembers() {
		return members;
	}
	public void setMembers(ArrayList<String> members) {
		this.members = members;
	}
	
	public static ChatRoom convertMessage(String source) {
		ChatRoom message = new ChatRoom();
		Gson gson = new Gson();
		
		message = gson.fromJson(source, ChatRoom.class);
		
		return message;
	}
}
