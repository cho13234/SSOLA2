package com.ssola2.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssola2.model.dto.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = {"/", "home.action"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		Member member = (Member)session.getAttribute("loginuser");
		
		if (member == null) {
			return "redirect:/account/login.action";			
		} else {
			//return "redirect:/main/main.action";
			return "redirect:/chat/chatlist.action";
		}
		
	}
	
}
