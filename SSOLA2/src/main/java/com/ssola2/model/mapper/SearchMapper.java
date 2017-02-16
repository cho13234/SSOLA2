package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;

// com.mvcdemoweb.model.mapper.MemberMapper.xml 파일에 대응하는 인터페이스
public interface SearchMapper {

	List<Member> searchfriend(String search);

	List<Member> searchfriends();
	

	
}