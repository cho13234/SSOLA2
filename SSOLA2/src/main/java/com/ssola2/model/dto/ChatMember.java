package com.ssola2.model.dto;

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
	
}
