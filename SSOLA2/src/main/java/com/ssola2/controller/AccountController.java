package com.ssola2.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssola2.common.Util;
import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.MemberService;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService service;
	
	@RequestMapping(value = "login.action", method = RequestMethod.GET)
	public String loginForm(Member member, Model model, BindingResult br) {
		model.addAttribute("loginfailed", false);
		return "account/login";
	}

	@RequestMapping(value = "login.action", method = RequestMethod.POST)
	public String login(Member member, Model model, HttpSession session) {
		
		Member m = service.searchMemberByIdAndPasswordTx(
				member.getId(), member.getPassword());
		
		if(m == null) {
			model.addAttribute("loginfailed", true);
			return "account/login";
		} else {
			if (m.isUserType()) {
				Administrator a = (Administrator)m;
				session.setAttribute("loginuser", a);
			} else {
				Customer c = (Customer)m;
				session.setAttribute("loginuser", c);
			}
		}
		
		return "redirect:/home.action";
	}
	
	@RequestMapping(value = "logout.action", method = RequestMethod.GET)
	public String logout(Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("loginuser");
		
		if(member == null) {
			model.addAttribute("loginfailed", true);
			return "account/login";
		} else {
			session.removeAttribute("loginuser");
			return "redirect:/home.action";
		}
	}
	
	@RequestMapping(value = "register.action", method = RequestMethod.GET)
	public String customerRegisterForm(Customer customer, BindingResult br) {

		return "account/registerform";
	}
	
	@RequestMapping(value = "register.action", method = RequestMethod.POST)
	public String customerRegister(@Valid Customer customer, BindingResult br) {
		
		if (br.hasErrors()) {
			
			return "account/registerform";
			
		} else {
			service.registerMemberTx(customer);
			
			return "redirect:/home.action";
		}
	}
	
	//TODO 관리자 회원 가입을 위한 버튼을 숨겨서 생성한다. 관리자 회원가입은 adminregister.action으로 연결
	@RequestMapping(value = "adminregister.action", method = RequestMethod.GET)
	public String adminRegisterForm(Administrator administrator, BindingResult br) {
		
		return "account/adminregisterform";
	}
	
	@RequestMapping(value = "adminregister.action", method = RequestMethod.POST)
	public String adminRegister(@Valid Administrator administrator, BindingResult br) {
		
		if (br.hasErrors()) {
			
			return "account/adminregisterform";
		} else {
			
			administrator.setUserType(true);
			service.registerMemberTx(administrator);

			return "redirect:/home.action";
		}
	}
	
	@RequestMapping(value = "idcheck.action", method = RequestMethod.GET, produces="text/plain;charset=utf-8")
	@ResponseBody
	public String idCheck(String id) {
		if(service.searchIdById(id)) {
			return id;
		} else {
			return null;
		}
		
	}
	
	@RequestMapping(value = "nicknamecheck.action", method = RequestMethod.GET, produces="text/plain;charset=utf-8")
	@ResponseBody
	public String nicknameCheck(String nickname) {
		if(service.searchNicknameByNickname(nickname)) {
			return nickname;
		} else {
			return null;
		}
	}
	
}
