package com.ssola2.controller;

import java.text.DateFormat;
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

import com.ssola2.model.dto.Member;
import com.ssola2.model.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	@Qualifier("searchService")
	private SearchService searchService;
	
	@RequestMapping(value = {"search.action"}, method = RequestMethod.GET)
	public String a(HttpSession session , Model model) {
		Member member = (Member)session.getAttribute("loginuser");
		
			List<Member> members = searchService.searchfriends();
			model.addAttribute("members" , members);
			return "search/searchform";			
		}
	
	
	@RequestMapping(value = {"search.action"}, method = RequestMethod.POST)
	@ResponseBody
	public List<Member> b(Model model,HttpSession session, String searchSelect , String search) {
		Member member = (Member)session.getAttribute("loginuser");
			List<Member> members = null;
			members = searchService.searchfriend(search);
			return members;		
		}
	
	@RequestMapping(value = {"searchgps.action"}, method = RequestMethod.POST)
	@ResponseBody
	public List<Member> c(Model model,HttpSession session, String searchSelect , String search) {
		Member member = (Member)session.getAttribute("loginuser");
			List<Member> members = null;
			members = searchService.searchfriend(search);
			return members;
		}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	}
