package com.ssola2.model.dao;

import java.util.ArrayList;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Recommend;

public interface RecommendDao {
	
	public Recommend selectRecommendById(Recommend recommend);
	public int selectRecommendCount(Recommend recommend); //article no 를 보내줘야함
	public void insertRecommend(Recommend recommend);
	public void deletedRecommend(Recommend recommend);
	//	public void insertAdministrator(Administrator administrator);
//	public List<Member> selectMembers();
//	public Member selectMemberById(String id);
//	public Member selectMemberByIdAndPassword(String id, String password);
//	public Customer selectCustomerById(String id);
//	public Administrator selectAdministratorById(String id);
//	public String selectIdById(String id);
//	public String selectNicknameByNickname(String nickname);
	public Article selectDetail(Recommend recommend);
	public String selectRecommendState(Recommend recommend);
	public ArrayList<Recommend> selectRecommendListById(String id);
	
}
