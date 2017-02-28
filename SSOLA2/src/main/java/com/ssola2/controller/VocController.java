package com.ssola2.controller;

import java.io.PrintWriter;
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

import com.ssola2.model.dto.Member;
import com.ssola2.model.service.VocService;
import com.ssola2.ui.ThePager;
import com.ssola2.model.dto.Voc;
import com.ssola2.model.dto.VocComment;


@Controller
@RequestMapping(value = "/voc")
public class VocController {
	
	@Autowired
	@Qualifier("vocService")
	private VocService vocService ;
	
	private static final Logger logger = LoggerFactory.getLogger(VocController.class); //console에 log찍는 목적으로
	
	@RequestMapping(value = "list.action", method = RequestMethod.GET)
	public String vocList(Locale locale, Model model,
			HttpServletRequest req, HttpServletResponse resp,
			@RequestParam(required=false) Integer pageno) {
		
		/////////////////////
		int pageSize = 10;
		int pagerSize = 5;
		int currentPage = 1;
		
		if(pageno != null){
			currentPage = pageno;
		}
		
		int start = pageSize * (currentPage - 1);
		
		int totalCount = vocService.getVocTotalCount();
		
		List<Voc> vocs = vocService.getArticleList(start, pageSize);
		
		ThePager pager = new ThePager(totalCount, currentPage, pageSize, pagerSize, "list.action");
		
		for(Voc temp : vocs) {
			System.out.println(temp.toString());
		}
		
	    System.out.println("나간갯수"+vocs.size());
	        
		model.addAttribute("vocs", vocs);
		model.addAttribute("pager", pager);
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
	public String editVoc(HttpServletRequest req, HttpServletResponse resp, @ModelAttribute Voc voc) {

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
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
	public String detail(HttpServletRequest req, HttpServletResponse resp,HttpSession session, Model model, int articleNo) {
		
		//조회수 증가
		vocService.updateVocReadCount(articleNo);
		
		Voc voc = vocService.getArticleByArticleNo(articleNo);
		
		List<VocComment> voccomments = vocService.getVocCommentList(articleNo);
		
		///////
		
		Member member = (Member)session.getAttribute("loginuser");
		PrintWriter out = null;
		
		try {
			req.setCharacterEncoding("utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.setCharacterEncoding("utf-8");
		try {
			out = resp.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(voc.getSecure()== null){
			voc.setSecure(false);
		}
		if (voc.getSecure()){
			if ( member == null){
				out.println("<script>");
				out.println("alert('게시글을 읽을 권한이 없습니다.');");
				out.println("history.back();");
				//out.print(String.format("location.replace(%s)", returnUrl));
				out.println("</script>"); 
				return null;
			}
			if (!member.isUserType()){
				if (!voc.getId().equals(member.getId())){
					out.println("<script>");
					out.println("alert('게시글을 읽을 권한이 없습니다.');");
					out.println("history.back();");
					//out.print(String.format("location.replace(%s)", returnUrl));
					out.println("</script>");
					return null;
				}else{
					model.addAttribute("voc", voc);
					model.addAttribute("voccomments", voccomments);


					return  "voc/detail";
				}
			}else{
				 model.addAttribute("voc", voc);
				 model.addAttribute("voccomments", voccomments);

				 return "voc/detail";
			}
			
		}else{
			model.addAttribute("voc", voc);
			model.addAttribute("voccomments", voccomments);


			return "voc/detail";
		}
	}
	
@RequestMapping(value = "commentWrite.action", method = RequestMethod.POST)
	
	public String insertvocComment(String commentContent,
			HttpServletResponse resp, HttpServletRequest req, HttpSession session, Integer articleNo, Model model) {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		System.out.println(commentContent);

		Member member = (Member)req.getSession().getAttribute("loginuser");
		
		VocComment vocComment = new VocComment();
		vocComment.setArticleNo(articleNo);
		vocComment.setId(member.getId());
		System.out.println(member.getId());
		vocComment.setCommentContent(commentContent);
		vocService.insertVocComment(vocComment);
		
		List<VocComment> voccomments = vocService.getVocCommentList(articleNo);
		model.addAttribute("voccomments", voccomments);
		
		return "voc/comment_list";
	}
	
	@RequestMapping(value = "/commentEdit.action", method = RequestMethod.POST)
	public String editFreeBoardComment(Model model, HttpServletRequest req, HttpServletResponse resp,@ModelAttribute VocComment vocComment, int articleNo){
		
		System.out.println("신호들어옴 ㅋㅋ");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
		
		vocService.editVocComment(vocComment);
		List<VocComment> voccomments = vocService.getVocCommentList(articleNo);
		model.addAttribute("voccomments", voccomments);
		
		return "voc/comment_list";
	}

	@RequestMapping(value = "/commentDelete.action", method = RequestMethod.GET)
	@ResponseBody
	public String  deleteComment(HttpServletRequest req, @RequestParam int commentNo){
		
		Member member = (Member) req.getSession().getAttribute("loginuser");
		
		vocService.deleteVocComment(commentNo);
		return "success";
	}
	
}

	

