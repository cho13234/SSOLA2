package com.ssola2.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Section;
import com.ssola2.model.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	@Qualifier("searchService")
	private SearchService searchService;
	
	@RequestMapping(value = {"search.action"}, method = RequestMethod.GET)
	public String searchForm(HttpSession session , Model model) {
		Member member = (Member)session.getAttribute("loginuser");
		
			List<Member> members = searchService.searchfriends();
			model.addAttribute("members" , members);
			return "search/searchform";			
		}
	
	
	@RequestMapping(value = {"search.action"}, method = RequestMethod.POST)
	@ResponseBody
	public List<Member> searchMember(Model model,HttpSession session, String searchSelect , String search) {
		Member member = (Member)session.getAttribute("loginuser");
			List<Member> members = new ArrayList<Member>();
			members = searchService.searchfriend(search);
			return members;		
		}
	
	@RequestMapping(value = {"searchgps.action"}, method = RequestMethod.POST)
	@ResponseBody
	public List<Section> searchGps(Model model,HttpSession session, String searchSelect , String search , String LAT ,String LNG) { //가져와야 되는 데이터는 ? 매장명 , 매장주소 , 전화번호 , 매장위치 (위도, 경도) 
		Member member = (Member)session.getAttribute("loginuser");
		Section section = new Section();
		section.setLAT(LAT);
		section.setLNG(LNG);
		List<Section> sections = searchService.search_stores(section);
		return sections;
		}
	
	@RequestMapping(value = {"searchArticle.action"}, method = RequestMethod.GET)
	@ResponseBody
	public String searchGps(int sectionNo) { //가져와야 되는 데이터는 ? 매장명 , 매장주소 , 전화번호 , 매장위치 (위도, 경도) 
			String articleNo = searchService.search_article(sectionNo);
				
		return articleNo;
		}
	
	
	
	}
