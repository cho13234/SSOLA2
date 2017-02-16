package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.SearchDao;
import com.ssola2.model.dto.Member;

@Service(value="searchService")
public class SearchServiceImpl implements SearchService{
	
	@Autowired
	@Qualifier("searchDao")
	private SearchDao dao;

	@Override
	public List<Member> searchfriend(String search) {
		List<Member> members = dao.searchfriend(search);
		return members;
	}

	@Override
	public List<Member> searchfriends() {
		
		return dao.searchfriends();
	}

	

}
