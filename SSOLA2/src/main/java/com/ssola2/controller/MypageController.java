package com.ssola2.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ssola2.common.Util;
import com.ssola2.model.dao.MemberDao;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.Friend_list;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Profile;
import com.ssola2.model.dto.Reservation;
import com.ssola2.model.dto.Scrap;
import com.ssola2.model.dto.Shop_Profile;
import com.ssola2.model.dto.Voc;
import com.ssola2.model.service.FreeBoardService;
import com.ssola2.model.service.MemberService;
import com.ssola2.model.service.ScrapService;
import com.ssola2.model.service.ShopService;
import com.ssola2.model.service.VocService;
import com.ssola2.ui.ThePager;

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

	@Autowired
	@Qualifier("vocService")
	private VocService vocService;

	@Autowired
	@Qualifier("freeBoardService")
	private FreeBoardService freeBoardService;
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;

	//my profile
	@RequestMapping(value = "mypage_main.action", method = RequestMethod.GET)
	public String mypage_main(Model model, Profile profile, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");
		Profile p_list = memberService.selectProfile(member.getId());
		Shop_Profile sh_list = shopService.selectShopProfile(member.getId());
		
		if(p_list.getShop_status().equals("2")) {
			model.addAttribute("p_list", p_list);
			model.addAttribute("sh_list", sh_list);
			return "mypage/shop_profile";
		} else  {
			model.addAttribute("p_list", p_list);
			return "mypage/mypage_main";
		}
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
	public String mypage_friendmain(Model model, String did, HttpSession session) {

		// session에서 변수 가져옴
		Member member = (Member)session.getAttribute("loginuser");
		// member 변수 id로 profile select
		Profile profile = memberService.selectProfile(did);
		Shop_Profile sh_list = shopService.selectShopProfile(did);

		//매장 신청이 완료됐을 경우.
		if(profile.getShop_status().equals("2")) {

			String sid = member.getId();
			// 내 친구의 목록을 가져온다.
			Friend_list _f_list = new Friend_list();
			_f_list.setSource_id(sid);
			_f_list.setDestination_id(did);

			List<Friend_list> mf_list = memberService.friendsStatus(_f_list);
			model.addAttribute("p_list", profile);
			model.addAttribute("sh_list", sh_list);

			if(mf_list.size() == 0) { // 데이터테이블에 데이터가 없을때 // 친구 아닐 때
				model.addAttribute("status" , "insert");
			} else { // 데이터테이블에 데이터가 있을 때
				for(Friend_list f_list : mf_list) {
					// 넌 나의 친구 상태
					if(f_list.isDeleted() == false)  { // datatable에 친구일 때,               
						model.addAttribute("status" ,"delete");
					}else if(f_list.isDeleted() == true){ // 친구였는데 삭제했을 때
						model.addAttribute("status" ,"update");
					}
				}
			}		
			return "mypage/shop_profile";
		} else {

			String sid = member.getId();
			// 내 친구의 목록을 가져온다.
			Friend_list _f_list = new Friend_list();
			_f_list.setSource_id(sid);
			_f_list.setDestination_id(did);

			List<Friend_list> mf_list = memberService.friendsStatus(_f_list);
			model.addAttribute("p_list", profile);
			model.addAttribute("sh_list", sh_list);
			
			if(mf_list.size() == 0) { // 데이터테이블에 데이터가 없을때 // 친구 아닐 때
				model.addAttribute("status" , "insert");
			} else { // 데이터테이블에 데이터가 있을 때
				for(Friend_list f_list : mf_list) {
					// 넌 나의 친구 상태
					if(f_list.isDeleted() == false)  { // datatable에 친구일 때,               
						model.addAttribute("status" ,"delete");
					}else if(f_list.isDeleted() == true){ // 친구였는데 삭제했을 때
						model.addAttribute("status" ,"update");
					}
					/*else if(!f_list.getDestination_id().equals(did)) {
	               model.addAttribute("status", "insert");
	            }*/
				}
			}
		}
		return "mypage/friend_main";
	}



	////////////////친구 추가
	@RequestMapping(value = "add_friend.action", method = RequestMethod.GET)
	@ResponseBody
	public String addFriend(HttpSession session, String did , String status) {

		Member member = (Member)session.getAttribute("loginuser");
		Friend_list f_list = new Friend_list();

		// 내 아이디의 친구목록 검색
		f_list.setSource_id(member.getId());
		f_list.setDestination_id(did); // 친구 추가 할 대상의 아이디

		// table에 data 삽입을 위한 임시 객체 생성
		Friend_list _f_list = new Friend_list();
		_f_list.setSource_id(member.getId());
		_f_list.setDestination_id(did);

		// sid did를 둘다 입력해서 하나만 출력
		List<Friend_list> mf_list = memberService.friendsStatus(_f_list);
		if(mf_list.size() == 0) { 
			memberService.insertFriend(f_list);
			return "delete";
		} else {

			for(Friend_list f_list2 : mf_list) {

				if (f_list2.isDeleted() == true && status.equals("update")){//친구가 아닌상태이면서  delete 를1인 
					memberService.updateFriend(f_list);
					return "delete";
				} else if(f_list2.isDeleted() == false && status.equals("delete")) { //친구 인상태 이면서 
					memberService.updateFriend1(f_list);
					return "update";
				}
			}
		}
		return null;
	}


	//내가 친구추가한 리스트 
	@RequestMapping(value="friends_list.action", method = RequestMethod.GET)
	public String friendlist(HttpSession session, Model model) {

		Member member = (Member)session.getAttribute("loginuser");

		List<Friend_list> my_flist = memberService.selectFriendList(member.getId());

		model.addAttribute("my_flist", my_flist);

		return "mypage/friends_list";
	}

	//나에게 친구신청 했다는 메세지 대체.
	//나를 친구로 등록한 사람(친구 추천같은 개념)
	@RequestMapping(value = "friend_add_confirm.action", method = RequestMethod.GET)
	public String friend_add_confirm(Model model, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");
		List<Friend_list> add_flist =memberService.selectAddFriendList(member.getId()); 

		model.addAttribute("add_flist", add_flist);


		return "mypage/friend_add_confirm";
	}




	//이미지 업로드 후 '등록'버튼 눌렀을 경우 나오는 결과 페이지
	//프로필 수정(회원가입에서 등록버튼 후 자기소개 작성 페이지)
	@RequestMapping(value = "profile_editform.action", method = RequestMethod.GET)
	public String profile_editform(Model model, Profile profile, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");

		Profile p_list = memberService.selectProfile(member.getId());

		model.addAttribute("p_list", p_list);


		return "mypage/profile_editform";
	}
	
	//shop_editform.jsp
	@RequestMapping(value = "shop_editform.action", method = RequestMethod.GET)
	public String shop_editform(Model model, Profile profile, HttpSession session) {

		Member member = (Member)session.getAttribute("loginuser");

		Profile p_list = memberService.selectProfile(member.getId());
		Shop_Profile sh_list = shopService.selectShopProfile(member.getId());

		model.addAttribute("p_list", p_list);
		model.addAttribute("sh_list", sh_list);

		return "mypage/shop_editform";
	}

	//이미지 업로드 액션
	@RequestMapping(value="/upload.action", method=RequestMethod.POST)
	private String upload(@RequestParam("file") MultipartFile file,HttpSession session , String description, String open_status, String shop_status, Model model) throws Exception { 
		Member member = (Member)session.getAttribute("loginuser");
		Profile profile = new Profile();
		shopService.insertShopProfileById(member.getId());

		String uploadPath = session.getServletContext().getRealPath("/resources/profileImages");
		//실제 디플로이되는 폴더의 root path를 따온다
		//System.out.println("UPLOAD_PATH : "+uploadPath);

		if(file.getOriginalFilename() == "") {
			profile.setImage("sino.gif");
			profile.setId(member.getId());
			profile.setDescription(description);
			profile.setOpen_status(open_status);
			profile.setShop_status(shop_status);
			
			scrapService.updateProfile(profile);

			model.addAttribute("p_status", profile.getOpen_status());        	  

		} else {
			String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
			FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(uploadPath+"/"+inTime+file.getOriginalFilename()));
			//upload 폴더안에 등록하겠다는 말

			profile.setImage(inTime+file.getOriginalFilename());
			profile.setId(member.getId());
			profile.setDescription(description);
			profile.setOpen_status(open_status);
			profile.setShop_status(shop_status);
			//이미지 네임을 디비에 저장하는 곳
			scrapService.updateProfile(profile);
			
			model.addAttribute("p_status", profile.getOpen_status());        

		}


		return "redirect:/mypage/mypage_main.action";
	} 
	
	//Profile 테이블의 shop_status가 "2"인 경우 shop_editform.jsp로 이동
	@RequestMapping(value="/upload_shop_profile.action", method=RequestMethod.POST)
	private String upload_shop_profile(@RequestParam("file") MultipartFile file,HttpSession session , Model model,
			String open_time, String close_time, String shop_status, int capacity, String menu, int avg_price) throws Exception { 
		Member member = (Member)session.getAttribute("loginuser");
		Shop_Profile shopProfile = new Shop_Profile();
		
		String uploadPath = session.getServletContext().getRealPath("/resources/profileImages");
		//실제 디플로이되는 폴더의 root path를 따온다
		//System.out.println("UPLOAD_PATH : "+uploadPath);

		if(file.getOriginalFilename() == "") {
			shopProfile.setImage("sino.gif");
			shopProfile.setId(member.getId());
			shopProfile.setOpen_time(open_time);
			shopProfile.setClose_time(close_time);
			shopProfile.setCapacity(capacity);
			shopProfile.setMenu(menu);
			shopProfile.setAvg_price(avg_price);			
			
			shopService.updateShopProfile(shopProfile);
//
			model.addAttribute("p_list", shopProfile);        	  

		} else {
			String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
			FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(uploadPath+"/"+inTime+file.getOriginalFilename()));
			//upload 폴더안에 등록하겠다는 말

			shopProfile.setImage(inTime+file.getOriginalFilename());
			shopProfile.setId(member.getId());
			shopProfile.setOpen_time(open_time);
			shopProfile.setClose_time(close_time);
			shopProfile.setCapacity(capacity);
			shopProfile.setMenu(menu);
			shopProfile.setAvg_price(avg_price);
			//이미지 네임을 디비에 저장하는 곳
			shopService.updateShopProfile(shopProfile);
			
			model.addAttribute("p_list", shopProfile);        
		}


		return "redirect:/mypage/mypage_main.action";
	} 
	
	//reservation 입력
	@RequestMapping(value = "insert_reservation.action", method = RequestMethod.POST)
	public String reservation(HttpServletResponse response, String store_id, String booker, int book_size, String book_date, String book_time) throws ParseException {
			
		String from = book_date;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date book_date2 = transFormat.parse(book_date);
		 
		Reservation reservation = new Reservation();
		System.out.println(book_size + "짱난다");
		reservation.setStore_id(store_id);
		reservation.setBooker(booker);
		reservation.setBook_date(book_date2);
		reservation.setBook_size(book_size);
		reservation.setBook_time(book_time);
		
		System.out.println(reservation.getStore_id());
		
		shopService.insertReservation(reservation);
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>window.close();</script>");
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
	//reservation 팝업
	@RequestMapping(value = "reservation.action", method = RequestMethod.GET)
	public String reservation(String store_id, HttpSession session, Model model) {
		
		Member member = (Member)session.getAttribute("loginuser");
		
		
		model.addAttribute("store_id", store_id);
		
		
		return "mypage/reservation";
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

	//friend_main.action에서 스크랩 
	@RequestMapping(value = "f_scrapform.action", method = RequestMethod.GET)
	public ModelAndView f_scrapform(String did, ModelAndView mav, Member member, HttpSession session)	
	{	
		//로그인 된 계정 정보 가져오려고.. 
		Member dMember = (Member)session.getAttribute("loginuser");
		//로그인 된 id
		String did2 = dMember.getId();
		Friend_list f_list = new Friend_list();
		f_list.setSource_id(did); //친구 계정
		f_list.setDestination_id(did2);//로그인한 계정

		Profile p_list = memberService.selectProfile(did);		

		//친구스크랩의 본인(source_id), 로그인 된 계정(destination_id)
		String fDeleted = memberService.selectOpenFriend(f_list);
		if(fDeleted == null) {
			fDeleted = "3";
		}

		List<Scrap> list = scrapService.getListById(did);
		mav.addObject("list", list);

		if(p_list.getOpen_status().equals("2")) { //전체공개
			mav.setViewName("mypage/f_scrapform");	
			return mav;
		}
		else if(fDeleted.equals("0") && p_list.getOpen_status().equals("1")) { // 내가 추가한 친구한테 공개
			mav.setViewName("mypage/f_scrapform_1");
			return mav;
		} else { //비공개
			mav.setViewName("mypage/f_scrapform_0");
			return mav;
		} 


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

	//내가 작성한 고객의 소리 게시글 리스트
	@RequestMapping(value = "my_voc_list.action", method = RequestMethod.GET)
	public String my_voc_list(HttpSession session, Model model, @RequestParam(required=false) Integer pageno) {

		Member member = (Member)session.getAttribute("loginuser");	

		int pageSize = 10;
		int pagerSize = 5;
		int currentPage = 1;

		if(pageno != null){
			currentPage = pageno;
		}

		int start = pageSize * (currentPage - 1);

		int totalCount = vocService.getVocTotalCount();
		List<Voc> vocs = vocService.getArticleListById(start, pageSize, member.getId());

		ThePager pager = new ThePager(totalCount, currentPage, pageSize, pagerSize, "my_voc_list.action");

		model.addAttribute("m_voc", vocs);
		model.addAttribute("pager", pager);

		return "mypage/my_voc_list";
	}

	//내가 작성한 자유게시판 게시글 리스트
	@RequestMapping(value = "my_fboard_list.action", method = RequestMethod.GET)
	public String my_fboard_list(HttpSession session, Model model, @RequestParam(required=false) Integer pageno) {

		Member member = (Member)session.getAttribute("loginuser");	

		int pageSize = 10;
		int pagerSize = 5;
		int currentPage = 1;

		if(pageno != null){
			currentPage = pageno;
		}

		int start = pageSize * (currentPage - 1);

		int totalCount = freeBoardService.getFreeBoardTotalCount();

		List<FreeBoard> my_fboard_list = freeBoardService.getFreeBoardListById(start, pageSize, member.getId());


		ThePager pager = new ThePager(totalCount, currentPage, pageSize, pagerSize, "my_fboard_list.action");

		model.addAttribute("m_fboard", my_fboard_list);
		model.addAttribute("pager", pager);

		return "mypage/my_fboard_list";
	}



}