
package com.ssola2.controller;


import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

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

import com.ssola2.model.dto.Comment;
import com.ssola2.model.dto.Member;
import com.ssola2.model.service.CommentService;



/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/comment")
public class CommentController {
	
	@Autowired
	@Qualifier("commentService")
	private CommentService commentservice;
		
	
	
	@RequestMapping(value="/comment.action", method=RequestMethod.GET)
	public String view(Locale locale,Model model){
	
		return "testcomment/comment";
	}
	
	
	/*
	@RequestMapping(value = "/insert.action", method = RequestMethod.POST)
	public String  insertComment(@ModelAttribute Comment comment,HttpSession session) {
//		String id = (String)session.getAttribute("member");
//		comment.setId(id);
//		commentservice.insertComment(comment);
		
		//comment 안에 이미 sectionNo와 contents가 들어가 있다
		Member member = (Member)session.getAttribute("loginuser");
		comment.setId(member.getId());
		commentservice.insertComment(comment);
		
		
		return "redirect:/main/main.action";
	}*/

	@RequestMapping(value = "/insert.action", method = RequestMethod.POST)
	public String insertComment(@ModelAttribute Comment comment,HttpSession session){
//		String id = (String)session.getAttribute("member");
//		comment.setId(id);
//		commentservice.insertComment(comment);
		
		//comment 안에 이미 sectionNo와 contents가 들어가 있다
		Member member = (Member)session.getAttribute("loginuser");
		comment.setId(member.getId());
		commentservice.insertComment(comment);
		
//		System.out.println(comment.getCommentNo());
		
		return "detail/commentfeed"; //view의 이름
	}
	
	@RequestMapping(value = "/list.action", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam int sectionNo, ModelAndView mav){
		
		List<Comment> list=commentservice.list(sectionNo);
		mav.setViewName("detail/detailform");
		mav.addObject("list", list);
		
		
	  
		return mav;
	}
	
	@RequestMapping(value = "/update.action", method = RequestMethod.POST)
	@ResponseBody
	public String  updateComment(@ModelAttribute Comment comment){
//		String id = (String)session.getAttribute("member");
//		comment.setId(id);
//		commentservice.insertComment(comment);
		
		//comment 안에 이미 sectionNo와 contents가 들어가 있다
//		Member member = (Member)session.getAttribute("loginuser");
//		comment.setId(member.getId());
		//TODO: commentContents를 가져오기 jsp에서 수정
		commentservice.updateComment(comment);
		
//		System.out.println(member.getId());
		
		return "success";
	}
	
	@RequestMapping(value = "/delete.action", method = RequestMethod.GET)
	public String  deleteComment(@RequestParam int commentNo){
//		String id = (String)session.getAttribute("member");
//		comment.setId(id);
//		commentservice.insertComment(comment);
		
		//comment 안에 이미 sectionNo와 contents가 들어가 있다
//		Member member = (Member)session.getAttribute("loginuser");

//		System.out.println(commentNo);//		comment.setId(member.getId());
		commentservice.deleteComment(commentNo);
		
//		System.out.println(member.getId());
		
		return "redirect:/main/main.action";
	}

	
}
