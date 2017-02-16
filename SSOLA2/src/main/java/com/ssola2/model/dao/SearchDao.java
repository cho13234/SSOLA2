package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;

public interface SearchDao {

	List<Member> searchfriend(String search);

	List<Member> searchfriends();
	
}