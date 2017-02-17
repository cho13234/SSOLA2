package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Friend_list;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;

// com.mvcdemoweb.model.mapper.MemberMapper.xml 파일에 대응하는 인터페이스
public interface MemberMapper {

	// id가 insertMember인 <insert>에 대응하는 메서드
	void insertMember(Member member);
	
	void insertCustomer(Customer customer);
	
	void insertAdministrator(Administrator administrator);
	
	// id가 selectMember인 <select>에 대응하는 메서드
	List<Member> selectMembers();
	
	// id가 selectMemberById인 <select>에 대응하는 메서드
	Member selectMemberById(String id);
	
	// id가 selectMemberByIdAndPasswd인 <select>에 대응하는 메서드
	Member selectMemberByIdAndPassword(HashMap<String, Object> params);
	
	Customer selectCustomerById(String id);
	Administrator selectAdministratorById(String id);
	
	String selectIdById(String id);
	String selectNicknameByNickname(String nickname);
	
	void updatePasswordByIdAndEmail(Customer customer);

	//선민 - 회원정보 수정
	void updateMember(Member member);
	void updateCustomer(Customer customer);

	void deleteMember(Member member);

	void updatePasswdN(Member member);
	
	//프로필
	Profile selectProfile(String id);
	List<Friend_list> friendsStatus(String sid);

	void insertFriend(Friend_list f_list);

	void updateFriend(Friend_list f_list);

	void updateFriend1(Friend_list f_list);
}