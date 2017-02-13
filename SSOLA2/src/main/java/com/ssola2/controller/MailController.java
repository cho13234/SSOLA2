package com.ssola2.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.SendMailService;

@Controller
public class MailController {
	
	@Autowired
	@Qualifier("mailService")
	private SendMailService service;
	

	@RequestMapping(value = "/account/findpassword.action", method = RequestMethod.GET)
	public String findPasswordForm() {
		return "account/findform";
	}
	
	@RequestMapping(value = "/account/findpassword.action", method = RequestMethod.POST)
	public String findPassword(Customer customer) {
//		System.out.println(customer.getId() + " " + customer.getEmail());
		
		service.sendTempPasswordEmailTx(customer);
		
		return "redirect:/account/login.action";
	}
	
	////////////////
	
	@RequestMapping(value="/mypage/complete_sendEditor.action", method = RequestMethod.GET)
	public String sendEmailForm()
	{
		System.out.println("sendEmailForm get");
		return "mypage/complete_sendEditor";
	}
	
	@RequestMapping(value="/mypage/complete_sendEditor.action", method = RequestMethod.POST)
	public String complete_sendEditor(String id, String articleTitle, String mailEditor, HttpServletResponse resp)
	{
		System.out.println("complete_sendEditor post");
		
		
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("test/html;charset=utf-8");
		
//		Member member = (Member) req.getSession().getAttribute("loginuser");
		
		service.sendQuestEmailTx(id, articleTitle, mailEditor);
		return "redirect:/mypage/mypage_main.action";
	}
	
}
