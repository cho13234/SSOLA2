package com.ssola2.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Recommend;
import com.ssola2.model.mapper.MemberMapper;
import com.ssola2.model.mapper.RecommendMapper;

@Repository(value="recommendDao")
public class MysqlRecommendDao implements RecommendDao {

	@Autowired
	@Qualifier("recommendMapper")
	private RecommendMapper recommendMapper;

	//////////////////////////////////////////////////////
	@Override
	public int selectRecommendCount(Recommend recommend) {
		int count =recommendMapper.selectRecommendCount(recommend);
		return count;
	}

	@Override
	public void insertRecommend(Recommend recommend) {
		System.out.println(recommend.getArticleNo() +"zz");
		System.out.println(recommend.getId() + "id");
		recommendMapper.insertRecommend(recommend);
	}

	@Override
	public void deletedRecommend(Recommend recommend) {
		recommendMapper.deletedRecommend(recommend);
		
	}

	@Override
	public Recommend selectRecommendById(Recommend recommend) {
		return recommendMapper.selectRecommendById(recommend);
	}

	@Override
	public Article selectDetail(Recommend recommend) {
//		String title =recommendMapper.selectDetail(recommend);
		Article article = recommendMapper.selectDetail(recommend);
//		article.setSection1(recommendMapper.selectDetailSection(article.getSection1().getSectionNo()));
//		article.setSection2(recommendMapper.selectDetailSection(article.getSection2().getSectionNo()));
//		article.setSection3(recommendMapper.selectDetailSection(article.getSection3().getSectionNo()));
//		article.setSection4(recommendMapper.selectDetailSection(article.getSection4().getSectionNo()));
		//String title = article.getArticleTitle();
//		System.out.println(title);
		return article;
	}

	@Override
	public String selectRecommendState(Recommend recommend) {
		
		return recommendMapper.selectRecommendState(recommend);
	}

	
	@Override
	public ArrayList<Recommend> selectRecommendListById(String id) {

		return recommendMapper.selectRecommendListById(id);
	}


//	@Override
//	public void insertCustomer(Customer customer) {
//		memberMapper.insertCustomer(customer);
//	}
//
//	@Override
//	public void insertAdministrator(Administrator administrator) {
//		memberMapper.insertAdministrator(administrator);
//	}
//	
//	@Override
//	public List<Member> selectMembers() {
//		return memberMapper.selectMembers();
//	}
//
//	@Override
//	public Member selectMemberById(String id) {
//		return memberMapper.selectMemberById(id);
//	}
//
//	@Override
//	public Member selectMemberByIdAndPassword(String id, String password) {
//		
//		HashMap<String, Object> params = new HashMap<String, Object>();
//		
//		params.put("id", id);
//		params.put("password", password);
//		
//		return memberMapper.selectMemberByIdAndPassword(params);
//	}
//
//	@Override
//	public Customer selectCustomerById(String id) {
//		return memberMapper.selectCustomerById(id);
//	}
//
//	@Override
//	public Administrator selectAdministratorById(String id) {
//		return memberMapper.selectAdministratorById(id);
//	}
//
//	@Override
//	public String selectIdById(String id) {
//		return memberMapper.selectIdById(id);
//	}
//
//	@Override
//	public String selectNicknameByNickname(String nickname) {
//		return memberMapper.selectNicknameByNickname(nickname);
//	}

}
