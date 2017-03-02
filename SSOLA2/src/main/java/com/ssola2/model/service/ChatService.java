package com.ssola2.model.service;

import java.util.ArrayList;
import java.util.List;

import com.ssola2.model.dto.ChatLog;
import com.ssola2.model.dto.ChatMember;
import com.ssola2.model.dto.ChatRoom;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.MessageVO;

public interface ChatService {

	/**
	 * 해당 id가 속해있는 채팅방을 db에서 가져온다.
	 * @param id 채팅방에 포함을 검색할 id
	 * @return id로 검색된 채팅방 리스트
	 */
	public List<ChatRoom> searchChatRoomListById(String id);

	/**
	 * 해당 id에 연결된 친구 리스트를 db에서 가져온다.
	 * @param id 친구를 검색할 id
	 * @return id로 검색된 친구 리스트
	 */
	public List<Member> searchFriendListById(String id);

	/**
	 * 해당 groupNo에 연관된 chatLog들을 가져온다.
	 * @param groupNo chatLog를 가져올 채팅방 번호
	 * @return groupNo로 검색된 chatLog의 리스트
	 */
	public List<ChatLog> searchGroupLogByGroupNo(int groupNo);

	/**
	 * ChatLog를 db에 등록한다. chatLog 내부에 roomNo가 없으면 db에 등록할 수 없다.
	 * @param chatLog db에 등록할 chatLog 해당 log내에 roomNo가 지정되어 있어야 한다.
	 */
	public void addChatLog(ChatLog chatLog);

	/**
	 * 해당 groupNo에 등록된 채팅방 멤버의 id 리스트를 db에서 가져온다.
	 * @param groupNo 그룹 멤버를 가져올 채팅방 번호
	 * @return 채팅방 멤버의 id 리스트
	 */
	public List<String> searchGroupMemberByGroupNo(String groupNo);

	/**
	 * chatRoom을 db에 등록한다. chatRoom.roomNo는 autoIncrement로 등록된다.
	 * @param chatRoom db에 등록할 chatRoom 정보
	 */
	public void createChatRoomTx(ChatRoom chatRoom);

	/**
	 * chatRoom 내부에 있는 초대할 멤버에 대한 정보 및 채팅방 번호 정보를 이용해 등록한다.
	 * 해당 멤버가 이미 해당 채팅방에 들어온 기록이 있다면 deleted 값만 수정한다.
	 * @param chatRoom 해당 채팅방에 들어올 멤버들에 대한 정보 및 채팅방에 대한 정보를 가진다.
	 * @return 등록이 완료된 이후 해당 채팅방에 대한 정보를 조회해서 반환한다.
	 */
	public ChatRoom inviteChatMembersTx(ChatRoom chatRoom);

	/**
	 * 해당 chatMember 정보를 이용해 db내에 등록된 해당 멤버의 deleted값을 1로 수정한다. 
	 * @param chatMember 퇴장할 채팅방에 대한 번호 및 id값이 기록된 채팅방 멤버에 대한 정보
	 */
	public void exitGroupByGroupMember(ChatMember chatMember);
}
