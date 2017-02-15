package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.common.Util;
import com.ssola2.model.dao.MemberDao;
import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;

@Service(value="memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	@Qualifier("memberDao")
	private MemberDao dao;

	@Override
	public void registerMemberTx(Member member) {
		member.setPassword(Util.getHashedString(member.getPassword(), "SHA-256"));
		dao.insertMember(member);
		if(member.isUserType()) {
			dao.insertAdministrator((Administrator)member);
		} else {
			dao.insertCustomer((Customer)member);			
		}
	}
	
	@Override
	public List<Member> getMemberList() {
		return dao.selectMembers();
	}

	@Override
	public Member searchMemberById(String id) {
		return dao.selectMemberById(id);
	}

	@Override
	public Member searchMemberByIdAndPasswordTx(String id, String password) {
		Member member = dao.selectMemberByIdAndPassword(id, Util.getHashedString(password, "SHA-256"));
		if (member == null) {
			return null;
		} else {
			if (member.isUserType()) {
				Administrator administrator = dao.selectAdministratorById(id);
				administrator.setNickname(member.getNickname());
				administrator.setUserType(member.isUserType());
				administrator.setDeleted(member.isDeleted());
				return administrator;
			} else {
				Customer customer = dao.selectCustomerById(id);
				customer.setNickname(member.getNickname());
				customer.setUserType(member.isUserType());
				customer.setDeleted(member.isDeleted());
				return customer;
			}
		}
	}

	@Override
	public boolean searchIdById(String id) {
		String _id = dao.selectIdById(id);
		if (_id == null) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean searchNicknameByNickname(String nickname) {
		String _nickname = dao.selectNicknameByNickname(nickname);
		if (_nickname == null) {
			return true;
		} else {
			return false;
		}
	}
	
	
	//	
	@Override
	public void updateMemberTx(Member member)
	{
		dao.updateMember(member);
		dao.updateCustomer((Customer)member);
	}
	
	@Override
	public void updatePasswdNTx(Member member) {
		dao.updatePasswdN(member);
		dao.updateCustomer((Customer)member);		
	}

	@Override
	public void deleteMember(Member member) {
		dao.deleteMember(member);		
	}


	//프로필
	@Override
	public List<Profile> selectProfile(String id) {
		
		return dao.selectProfile(id);
	}

}
