package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
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
//	public List<Profile >selectProfileById(String id);
	public List<Profile> selectProfile(String id);
}