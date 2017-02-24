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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Voc;
import com.ssola2.model.service.FreeBoardService;
import com.ssola2.ui.ThePager;

@Controller
@RequestMapping(value = "/freeboard")
public class FreeBoardController {
	
	
	@Autowired
	@Qualifier("freeBoardService")
	private FreeBoardService freeBoardService ;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeBoardController.class); //console에 log찍는 목적으로
	
	@RequestMapping(value = "list.action", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, 
			@RequestParam(required=false) Integer pageno) {
		
		/////////////////////
		int pageSize = 10;
		int pagerSize = 5;
		int currentPage = 1;
		
		if(pageno != null){
		currentPage = pageno;
		}
		
		int start = pageSize * (currentPage - 1);
		
		int totalCount = freeBoardService.getFreeBoardTotalCount();
		
		List<FreeBoard> freeboards = freeBoardService.getFreeBoardList(start, pageSize);
		
		ThePager pager = new ThePager(totalCount, currentPage, pageSize, pagerSize, "list.action");
		
		System.out.println("나간갯수"+ freeboards.size());
		
		model.addAttribute("freeboards", freeboards);
		model.addAttribute("pager", pager);
		return "freeboard/list";
	}
	
	@RequestMapping(value = "write.action", method = RequestMethod.GET)
	public String insertArticle(Locale locale, Model model) {

		return "freeboard/writeform";
	}

	@RequestMapping(value = "write.action", method = RequestMethod.POST)
	public String insertArticle(HttpServletRequest req, @ModelAttribute FreeBoard freeBoard, HttpServletResponse resp) {

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member) req.getSession().getAttribute("loginuser");

		freeBoardService.registerArticleTx(freeBoard);

		return "redirect:/freeboard/list.action";
	}
	
	@RequestMapping(value = "edit.action", method = RequestMethod.GET)
	public String editArticle(Model model, HttpSession session, int articleNo, HttpServletResponse resp) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		Member member = (Member)session.getAttribute("loginuser");
		
		FreeBoard freeBoard = freeBoardService.editFreeBoardByArticleNo(articleNo);
		model.addAttribute(freeBoard);
		
		return "freeboard/editform";
		
	}
	
	@RequestMapping(value = "edit.action", method = RequestMethod.POST)
	public String editArticle( HttpServletRequest req, HttpServletResponse resp, @ModelAttribute FreeBoard freeBoard) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
		freeBoardService.editFreeBoard(freeBoard);
		
		
		
		return "redirect:/freeboard/list.action";
	}
	
	@RequestMapping(value = "delete.action", method = RequestMethod.GET)
	public String deleteArticle( HttpServletResponse resp, int articleNo) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		freeBoardService.deleteFreeBoard(articleNo);
		
		return "redirect:/freeboard/list.action";
	}
	
	@RequestMapping(value = "detail.action", method = RequestMethod.GET)
	public String detail(Locale locale, Model model, Integer articleNo) {
		//조회수 증가
		
				freeBoardService.updateFreeBoardReadCount(articleNo);
				
				FreeBoard freeBoard = freeBoardService.getFreeBoardByArticleNo(articleNo);
				///////////////////////////////
				
				List<FreeBoardComment> freeboardcomments = freeBoardService.getFreeBoardCommentsByarticleNo(articleNo);
				
				model.addAttribute("freeBoard", freeBoard);
				model.addAttribute("freeboardcomments", freeboardcomments);
		
				return "freeboard/detail";
	}
	
	
	@RequestMapping(value = "commentWrite.action", method = RequestMethod.POST)
	
	public String insertFreeBoardComment(String commentContent,
			HttpServletResponse resp, HttpSession session, Integer articleNo, Model model) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		System.out.println(commentContent);

		Member member = (Member) session.getAttribute("loginuser");
		
		FreeBoardComment freeBoardComment = new FreeBoardComment();
		freeBoardComment.setArticleNo(articleNo);
		freeBoardComment.setId(member.getId());
		freeBoardComment.setCommentContent(commentContent);
		freeBoardService.insertFreeBoardComment(freeBoardComment);
		
		List<FreeBoardComment> freeboardcomments = freeBoardService.getFreeBoardCommentsByarticleNo(articleNo);
		model.addAttribute("freeboardcomments", freeboardcomments);
		return "freeboard/comment_list";
	}
	
	@RequestMapping(value = "/commentEdit.action", method = RequestMethod.POST)
	@ResponseBody
	public String editFreeBoardComment(HttpServletRequest req, HttpServletResponse resp,@ModelAttribute FreeBoardComment freeBoardComment){
		
		System.out.println("신호들어옴 ㅋㅋ");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
		
		freeBoardService.editFreeBoardComment(freeBoardComment);
		
		return "freeboard/comment_list";
	}

	@RequestMapping(value = "/commentDelete.action", method = RequestMethod.GET)
	@ResponseBody
	public String  deleteComment(HttpServletRequest req, @RequestParam int commentNo){
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
		
		freeBoardService.deleteFreeBoardComment(commentNo);
		return "success";
	}
	
}

