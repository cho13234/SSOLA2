package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Section;

public interface SearchService {

	public List<Member> searchfriend(String search);

	public List<Member> searchfriends();

	public List<Section> search_stores(Section section);

	public String search_article(int sectionNo);

}
