package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Member;

public interface SearchService {

	public List<Member> searchfriend(String search);

	public List<Member> searchfriends();

}
