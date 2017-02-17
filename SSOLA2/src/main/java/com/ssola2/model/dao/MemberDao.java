package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Friend_list;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;

public interface MemberDao {
	
	public void insertMember(Member member);
	public void insertCustomer(Customer customer);
	public void insertAdministrator(Administrator administrator);
	public List<Member> selectMembers();
	public Member selectMemberById(String id);
	public Member selectMemberByIdAndPassword(String id, String password);
	public Customer selectCustomerById(String id);
	public Administrator selectAdministratorById(String id);
	public String selectIdById(String id);
	public String selectNicknameByNickname(String nickname);
	public void updatePasswordByIdAndEmail(Customer customer);

	//선민 추가(회원정보 수정)
	public void updateMember(Member member);
	public void updatePasswdN(Member member);
	public void updateCustomer(Customer customer);
	public void deleteMember(Member member);
	
	
	//프로필
	public Profile selectProfile(String id);
	public List<Friend_list> friendsStatus(String sid);
	public void insertFriend(Friend_list f_list);
	public void updateFriend(Friend_list f_list);
	public void updateFriend1(Friend_list f_list);	
}