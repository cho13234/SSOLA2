package com.ssola2.controller;

import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Recommend;
import com.ssola2.model.service.MainService;
import com.ssola2.model.service.RecommendService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/main")
public class MainController {

	@Autowired
	@Qualifier("mainService")
	private MainService mainService;
	
	@Autowired
	@Qualifier(value ="recommendService")
	private RecommendService recommendService;

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping(value = "main.action", method = RequestMethod.GET)
	public String Main(Locale locale, Model model) {
		
//		List<Article> articles = mainService.getArticleList();
		List<Article> articles = mainService.getArticleListByNum(0, 1);
		
		if(articles.size() > 0) {
			//model.addAttribute("articles",articles);
			model.addAttribute("recentArticle", articles.get(0).getArticleNo() + 1);
			// 마지막 article 번호 + 1을 해줌으로써 해당 번호보다 작은 article을 불러올 수 있도록 설계
			// uploadFeed method에서 해당 번호를 기준으로 article을 불러온다.
		}
		return "main/main";
	}

	@RequestMapping(value = "write.action", method = RequestMethod.GET)
	public String writeMain(Locale locale, Model model) {

		return "main/writeform";
	}

	@RequestMapping(value = "write.action", method = RequestMethod.POST)
	public String writeMain(HttpServletRequest req, @ModelAttribute Article article, HttpServletResponse resp) {

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member) req.getSession().getAttribute("loginuser");

		mainService.registerArticleTx(article);

		return "redirect:/main/main.action";
	}

	@RequestMapping(value = "uploadfeed.action", method = RequestMethod.GET)
	public String uploadFeed(Locale locale, Model model, int recent , HttpSession session) {
//	public String uploadFeed(Locale locale, Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("loginuser");
		Recommend recommend = new Recommend();

		//TODO : 로그인 하지 않았을 때 처리가 필요

//		Article article = mainService.getArticleByArticleNo(recent);
		Article article = mainService.getArticleByArticleNoSize(recent);
		if(article != null) { //articleNo 가 없을때 나는 오류 잡기위함
			model.addAttribute("article", article);
			
			if (member != null) {//member 가 null 이면 게시글을 볼수없게 하기위함
				String id = member.getId();
				recommend.setId(id);	//recommend 에 loginuser.id 추가
				recommend.setArticleNo(article.getArticleNo());	//articleno 를 받아와야함
				//String zero : 사용자가 추천 버튼 눌렀는지 유무 판단
				String zero = recommendService.selectRecommnedState(recommend);
				model.addAttribute("zero" , zero);
				//int count : 몇명의 사용자가 추천 눌럿는지 판단
				int count = recommendService.selectRecommendCount(recommend); // count 를 가져오기위한 sql 문
				recommend.setCount(count);
				model.addAttribute("recommend" ,recommend);
			}
		}
		return "main/uploadfeed";
	}
	
	//recommend.action : 추천 눌렀을때 발동
	@RequestMapping(value = "/recommend.action" , method = RequestMethod.GET) 
	@ResponseBody
	public String recommend( HttpSession session , Model model ,int articleNo) {
		
		Member member = (Member) session.getAttribute("loginuser");
		if(member != null) { 
			String id = member.getId();
			Recommend recommend = new Recommend();
			recommend.setId(id);
			recommend.setArticleNo(articleNo);
			String zero = recommendService.selectRecommnedState(recommend);
			if(zero==null) {	//사용자가 눌렀는지 판단해서 null (안눌름) 이 뜨면 insert
				recommendService.insertRecommend(recommend);
			} else if(zero.equals("0")) { //사용자가 눌렀었으면 deleted 시켜준다
				recommendService.deletedRecommend(recommend);
			}
		//그리고 count 를 뽑아서 responseBody 를 이용해 값을 내보내줌 (ajax)
			int count = recommendService.selectRecommendCount(recommend);
		
			recommend.setCount(count);
			model.addAttribute("recommend" , recommend);
		
//		Map<String , Object> result = new HashMap<String , Object>();
//		result.put("count", count);

		return String.valueOf(count);
		}
		return String.valueOf(0);
	}
	
	
	@RequestMapping(value = "edit.action", method = RequestMethod.GET)
	public String editMain(Model model, HttpSession session, int articleNo, HttpServletResponse resp) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member)session.getAttribute("loginuser");
		
		Article article = mainService.editArticleByArticleNo(articleNo);
		model.addAttribute(article);
		
		return "main/editform";
		
	}
	
	@RequestMapping(value = "edit.action", method = RequestMethod.POST)
	public String editMain1( HttpServletResponse resp, @ModelAttribute Article article) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
//		String a = article.getSection1().getStoreName();
//		System.out.println(a);
		mainService.editArticle(article);
		
		return "redirect:/main/main.action";
	}
	
	@RequestMapping(value = "delete.action", method = RequestMethod.GET)
	public String deleteMain( HttpServletResponse resp, int articleNo) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		mainService.deleteArticle(articleNo);
		
		return "redirect:/main/main.action";
	}
	
	@RequestMapping(value = "about.action", method = RequestMethod.GET)
	public String about(Locale locale, Model model) {

		return "main/about2";
	}
	}
