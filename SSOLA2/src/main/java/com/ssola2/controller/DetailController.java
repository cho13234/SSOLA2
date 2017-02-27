package com.ssola2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssola2.model.service.CommentService;
import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Comment;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Recommend;
import com.ssola2.model.service.RecommendService;


@Controller
public class DetailController {
   
   @Autowired
   @Qualifier(value ="recommendService")
   private RecommendService service;
   
   @Autowired
   @Qualifier("commentService")
   private CommentService commentservice;
   
//main 에서 articleNo 를 가져옴   
   @RequestMapping(value = "/detail.action" , method = RequestMethod.GET)
   public String detail(Model model , HttpSession session , int articleNo) { //main에서 article no 를 받아서 가져오기
      
	  Member member = (Member)session.getAttribute("loginuser");
      Recommend recommend = new Recommend();
     
      if (member != null) {
         String id = member.getId();
         recommend.setId(id);   //recommend 에 loginuser.id 추가
         recommend.setArticleNo(articleNo);   //articleno 를 받아와야함
         //String zero : 사용자가 이 게시물을 추천 했는지 안했는 지 유무 판단.
         String zero = service.selectRecommnedState(recommend);
         model.addAttribute("zero" , zero);
         //int count : 몇명의 사용자가 추천했는지 판단
         int count = service.selectRecommendCount(recommend); // count 를 가져오기위한 sql 문
         recommend.setCount(count);
         model.addAttribute("recommend" ,recommend);
   //      String title = service.selectDetail(recommend); //article title 인데 section 부분때문에 일단 이렇게 가져옴
         Article article = service.selectDetail(recommend); //article title 인데 section 부분때문에 일단 이렇게 가져옴
         
//         article.setArticleNo(4); // debug
         model.addAttribute("article" ,article);
         
         //여기부터가 comment
   //      model.addAttribute("title" , title);
        int sectionNo1 = article.getSection1().getSectionNo();
 		int sectionNo2 = article.getSection2().getSectionNo();
 		int sectionNo3 = article.getSection3().getSectionNo();
 		int sectionNo4 = article.getSection4().getSectionNo();
 		List<Comment> list1=commentservice.list(sectionNo1);
 		List<Comment> list2=commentservice.list(sectionNo2);
 		List<Comment> list3=commentservice.list(sectionNo3);
 		List<Comment> list4=commentservice.list(sectionNo4);
 		model.addAttribute("list1" , list1);
 		model.addAttribute("list2" , list2);
 		model.addAttribute("list3" , list3);
 		model.addAttribute("list4" , list4);
      } else {
         String confirm = "로그인 해주세요";
         model.addAttribute("confirm" , confirm);
      }
      return "detail/detailform";
   }
   
}