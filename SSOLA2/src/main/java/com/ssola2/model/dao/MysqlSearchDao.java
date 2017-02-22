package com.ssola2.model.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Section;
import com.ssola2.model.mapper.MemberMapper;
import com.ssola2.model.mapper.SearchMapper;

@Repository(value="searchDao")
public class MysqlSearchDao implements SearchDao {

	@Autowired
	@Qualifier("searchMapper")
	private SearchMapper searchMapper;

	@Override
	public List<Member> searchfriend(String search) {
		List<Member> members = searchMapper.searchfriend(search);
		return members;
	}

	@Override
	public List<Member> searchfriends() {
		return searchMapper.searchfriends();
	}

	@Override
	public List<Section> search_stores(Section section) {
		
		return searchMapper.search_stores(section);
	}

	@Override
	public String search_article(int sectionNo) {
		return searchMapper.search_article(sectionNo);
	}

	

}
