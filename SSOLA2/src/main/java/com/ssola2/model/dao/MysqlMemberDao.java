package com.ssola2.model.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.mapper.MemberMapper;

@Repository(value="memberDao")
public class MysqlMemberDao implements MemberDao {

	@Autowired
	@Qualifier("memberMapper")
	private MemberMapper memberMapper;

	@Override
	public void insertMember(Member member) {
		memberMapper.insertMember(member);
	}

	@Override
	public void insertCustomer(Customer customer) {
		memberMapper.insertCustomer(customer);
	}

	@Override
	public void insertAdministrator(Administrator administrator) {
		memberMapper.insertAdministrator(administrator);
	}

	@Override
	public List<Member> selectMembers() {
		return memberMapper.selectMembers();
	}

	@Override
	public Member selectMemberById(String id) {
		return memberMapper.selectMemberById(id);
	}

	@Override
	public Member selectMemberByIdAndPassword(String id, String password) {

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("id", id);
		params.put("password", password);

		return memberMapper.selectMemberByIdAndPassword(params);
	}

	@Override
	public Customer selectCustomerById(String id) {
		return memberMapper.selectCustomerById(id);
	}

	@Override
	public Administrator selectAdministratorById(String id) {
		return memberMapper.selectAdministratorById(id);
	}

	@Override
	public String selectIdById(String id) {
		return memberMapper.selectIdById(id);
	}

	@Override
	public String selectNicknameByNickname(String nickname) {
		return memberMapper.selectNicknameByNickname(nickname);
	}

	@Override
	public void updatePasswordByIdAndEmail(Customer customer) {
		memberMapper.updatePasswordByIdAndEmail(customer);
	}

	//선민 추가(회원정보 수정)
	@Override
	public void updateMember(Member member)
	{
		System.out.println("수정 전 dao: " + member.getNickname());
		memberMapper.updateMember(member);
	}

	@Override
	public void updateCustomer(Customer customer) {
		System.out.println(customer.getEmail() + "이메일");
		memberMapper.updateCustomer(customer);
		
	}

	@Override
	public void deleteMember(Member member) {
		memberMapper.deleteMember(member);
		
	}

	@Override
	public void updatePasswdN(Member member) {
		memberMapper.updatePasswdN(member);
		
	}
	

}
