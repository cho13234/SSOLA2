package com.ssola2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssola2.common.Util;
import com.ssola2.model.dao.MemberDao;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Friend_list;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;
import com.ssola2.model.dto.Scrap;
import com.ssola2.model.service.MemberService;
import com.ssola2.model.service.ScrapService;

@Controller
@RequestMapping(value = "/mypage")
public class MypageController {

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	@Autowired
	@Qualifier("memberDao")
	private MemberDao dao;

	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;

	@Autowired
	@Qualifier("scrapService")
	private ScrapService scrapService;


	//my profile
	@RequestMapping(value = "mypage_main.action", method = RequestMethod.GET)
	public String mypage_main(Model model, Profile profile, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");
		Profile p_list = memberService.selectProfile(member.getId());

		model.addAttribute("p_list", p_list);



		return "mypage/mypage_main";
	}

	//회원정보 보기
	@RequestMapping(value = "loginedit.action", method = RequestMethod.GET)
	public String mypage_loginedit(HttpSession session, Model model , Customer customer, Member member)	
	{		
		customer = (Customer) session.getAttribute("loginuser");


		return "mypage/loginedit";
	}


	//회원정보 수정<<보류 : 수정한 내용 적용 ㄴㄴ
	@RequestMapping(value ="update_loginedit.action", method = RequestMethod.POST)
	public String updateMember(@ModelAttribute Customer customer, HttpSession session)
	{		

		String passwd = customer.getPassword();

		if (passwd == "") {
			memberService.updatePasswdNTx(customer);
		} else {
			customer.setPassword(Util.getHashedString(customer.getPassword(), "SHA-256"));
			memberService.updateMemberTx(customer);
		}


		return "redirect:/mypage/mypage_main.action";

	}

	@RequestMapping(value = "logindelete.action", method = RequestMethod.GET)
	public String deleteMember(HttpSession session, Model model, Customer customer, Member member)	
	{		
		member = (Member) session.getAttribute("loginuser");
		String id = member.getId();
		boolean deleted = member.isDeleted();
		member.setId(id);
		member.setDeleted(deleted);
		memberService.deleteMember(member);


		return "account/login";
	}

	///////////////////////친구 프로필
	@RequestMapping(value = "mypage_friendmain.action", method = RequestMethod.GET)
	//@ResponseBody //String 값을 내보낼 때
	public String mypage_friendmain(Model model, String id, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");
		Profile p_list = memberService.selectProfile(id);
		String sid = member.getId();	
		System.out.println(sid);
		List<Friend_list> mf_list = memberService.friendsStatus(sid);
		model.addAttribute("p_list", p_list);

		for(Friend_list f_list : mf_list) {
			// 넌 나의 친구 상태
			if(f_list.getDestination_id().equals(id) && f_list.isDeleted() == true)  {
				System.out.println("친구 삭제할거");
				model.addAttribute("a" ,"a");
			}else if(f_list.isDeleted() == false){
				model.addAttribute("b" ,"b");
			}else if(!f_list.getDestination_id().equals(id)) {
				model.addAttribute("c", "c");
			}
		}

		return "mypage/mypage_main";
	}

	////////////////친구 추가
	@RequestMapping(value = "add_friend.action", method = RequestMethod.GET)
	@ResponseBody
	public String addFriend(HttpSession session, String id2 , String abc) {

		System.out.println(id2 +"확인중");
		Member member = (Member)session.getAttribute("loginuser");
		Friend_list f_list = new Friend_list();
		f_list.setSource_id(member.getId());
		f_list.setDestination_id(id2);

		List<Friend_list> mf_list = memberService.friendsStatus(member.getId());

		for(Friend_list f_list2 : mf_list) {
			// 넌 나의 친구 상태
			if(!f_list2.getDestination_id().equals(id2) && abc.equals("c"))  {
				memberService.insertFriend(f_list);
			}else if (f_list2.isDeleted() == true && abc.equals("a")){
				memberService.updateFriend(f_list);
			} else if(f_list2.isDeleted() == false && abc.equals("b")) {
				memberService.updateFriend1(f_list);
			}
		}
		return "a";		
	}

	/////////////////////////scrap
	@RequestMapping(value = "scrapform.action", method = RequestMethod.GET)
	public ModelAndView mypage_scrapform(HttpSession session, ModelAndView mav)	
	{

		Member member = (Member)session.getAttribute("loginuser");

		List<Scrap> list = scrapService.getListById(member.getId());

		mav.setViewName("mypage/scrapform");
		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "deleteScrap.action", method = RequestMethod.GET)
	public String deleteScrap(@RequestParam int scrapNo)
	{


		scrapService.deleteScrap(scrapNo);
		return "redirect:/mypage/scrapform.action";
	}

	@RequestMapping(value = "insertScrap.action", method = RequestMethod.POST)
	public String insertScrap()
	{

		return "main/main";
	}

	@RequestMapping(value = "scrapInfo.action", method = RequestMethod.GET)
	public String scrapInfo(HttpSession session, @ModelAttribute Scrap scrap, int articleNo)	
	{

		Member member = (Member)session.getAttribute("loginuser");
		scrap = scrapService.selectScrapInfo(articleNo);
		scrap.setId(member.getId());

		scrapService.InsertScrapTx(scrap);

		return "redirect:/main/main.action";
	}

	///////////////////////email
	@RequestMapping(value = "q_mail.action", method = RequestMethod.GET)
	public String q_mail()
	{
		return "mypage/q_mail";
	}



}
