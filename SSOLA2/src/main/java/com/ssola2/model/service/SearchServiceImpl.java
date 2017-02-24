package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.SearchDao;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Section;

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

	@Override
	public List<Section> search_stores(Section section) {
		
		return dao.search_stores(section);
	}

	@Override
	public String search_article(int sectionNo) {
		return dao.search_article(sectionNo);
	}

	

}
