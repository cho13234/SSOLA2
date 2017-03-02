package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.ChatDao;
import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatMember;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

@Service(value="chatService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	@Qualifier("chatDao")
	private ChatDao chatDao;

	@Override
	public List<ChatRoom> searchChatRoomListById(String id) {
		return chatDao.selectChatRoomListById(id); 
	}

	@Override
	public List<Member> searchFriendListById(String id) {
		return chatDao.selectFriendListById(id);
	}

	@Override
	public List<ChatLog> searchGroupLogByGroupNo(int groupNo) {
		return chatDao.selectGroupLogByGroupNo(groupNo);
	}

	@Override
	public void addChatLog(ChatLog chatLog) {
		if (Integer.parseInt(chatLog.getRoomNo()) > 0) {
			chatDao.insertChatLog(chatLog);
		}
	}

	@Override
	public List<String> searchGroupMemberByGroupNo(String groupNo) {
		return chatDao.selectGroupMemberByGroupNo(groupNo);
	}

	@Override
	public void createChatRoomTx(ChatRoom chatRoom) {
		
		chatRoom.setMemberSize(chatRoom.getMembers().size());
		chatDao.insertChatRoom(chatRoom);
		
		insertAndUpdateMembers(chatRoom);
	}

	private void insertAndUpdateMembers(ChatRoom chatRoom) {
		for (String friend : chatRoom.getMembers()) {
			//매번 chatmember 클래스를 만들어 id와 roomNo를 넣어준다.
			ChatMember chatMember = new ChatMember();
			chatMember.setId(friend);
			chatMember.setRoomNo(chatRoom.getRoomNo());
			chatDao.insertChatMember(chatMember);
		}
	}

	@Override
	public ChatRoom inviteChatMembersTx(ChatRoom chatRoom) {
		
		chatRoom.setMemberSize(chatRoom.getMembers().size());
		chatDao.updateChatRoom(chatRoom);
		
		insertAndUpdateMembers(chatRoom);
		
		return chatDao.selectChatRoomByRoomNo(chatRoom.getRoomNo());
	}

	@Override
	public void exitGroupByGroupMember(ChatMember chatMember) {
		chatDao.updateChatMemberDeletedTrue(chatMember);
	}

}
