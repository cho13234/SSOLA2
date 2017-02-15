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

import com.ssola2.model.dto.Member;
import com.ssola2.model.service.VocService;
import com.ssola2.model.dto.Voc;


@Controller
@RequestMapping(value = "/voc")
public class VocController {
	
	@Autowired
	@Qualifier("vocService")
	private VocService vocService ;
	
	private static final Logger logger = LoggerFactory.getLogger(VocController.class); //console에 log찍는 목적으로
	
	@RequestMapping(value = "list.action", method = RequestMethod.GET)
	public String vocList(Locale locale, Model model) {
		
		List<Voc> vocs = vocService.getArticleList();
		
		return "voc/list";
	}
	
	@RequestMapping(value = "write.action", method = RequestMethod.GET)
	public String insertVoc(Locale locale, Model model) {

		return "voc/writeform";
	}

	@RequestMapping(value = "write.action", method = RequestMethod.POST)
	public String insertVoc(HttpServletRequest req, @ModelAttribute Voc voc, HttpServletResponse resp) {

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member) req.getSession().getAttribute("loginuser");

		vocService.registerArticleTx(voc);

		return "redirect:/voc/list.action";
	}
	
	@RequestMapping(value = "edit.action", method = RequestMethod.GET)
	public String editVoc(Model model, HttpSession session, int articleNo, HttpServletResponse resp) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member)session.getAttribute("loginuser");
		
		Voc voc = vocService.editArticleByArticleNo(articleNo);
		model.addAttribute(voc);
		
		return "voc/editform";
		
	}
	
	@RequestMapping(value = "edit.action", method = RequestMethod.POST)
	public String editVoc( HttpServletResponse resp, @ModelAttribute Voc voc) {

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
//		String a = article.getSection1().getStoreName();
//		System.out.println(a);
		vocService.editArticle(voc);
		
		return "redirect:/voc/list.action";
	}
	
	@RequestMapping(value = "delete.action", method = RequestMethod.GET)
	public String deleteArticle( HttpServletResponse resp, int articleNo) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		vocService.deleteArticle(articleNo);
		
		return "redirect:/voc/list.action";
	}
	
	@RequestMapping(value = "detail.action", method = RequestMethod.GET)
	public String detail(Locale locale, Model model) {

		return "voc/detail";
	}
}
