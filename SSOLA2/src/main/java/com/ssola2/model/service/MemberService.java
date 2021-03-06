package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Friend_list;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;

public interface MemberService {

	/**
	 * registerMember 안에서 
	 * administrator, customer에 대해 구분하고
	 * 각 테이블에 한번에 등록한다.
	 * @param member
	 */
	public void registerMemberTx(Member member); 
	public List<Member> getMemberList();
	public Member searchMemberById(String id);
	public Member searchMemberByIdAndPasswordTx(String id, String password);
	public Member searchMemberByIdAndPasswordNoneHashTx(String id, String password);
	public boolean searchIdById(String id);
	public boolean searchNicknameByNickname(String nickname);
	
	//선민
	void updateMemberTx(Member member);
	void updatePasswdNTx(Member member);
	public void deleteMember(Member member);
	
	//프로필


	
	
	public List<Friend_list> friendsStatus(Friend_list f_list);
	
	public void insertFriend(Friend_list f_list);
	public void updateFriend(Friend_list f_list);
	public void updateFriend1(Friend_list f_list);
	
	public Profile searchProfileByIdTx(String id);
	
	public Profile selectProfile(String id);
	void insertProfileById(String id);
	public List<Friend_list> selectFriendList(String id);
	public List<Friend_list> selectAddFriendList(String id);
	public String selectOpenFriend(Friend_list f_list);
	
}
