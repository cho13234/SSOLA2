package com.ssola2.model.mapper;

import java.util.ArrayList;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Recommend;
import com.ssola2.model.dto.Section;

// com.mvcdemoweb.model.mapper.MemberMapper.xml 
public interface RecommendMapper {

	int selectRecommendCount(Recommend recommend);
	
	void insertRecommend(Recommend recommend);
	
	void deletedRecommend(Recommend recommend);
	
	Recommend selectRecommendById(Recommend recommend);

	Article selectDetail(Recommend recommend);
	
	Section selectDetailSection(int sectionNo);

	String selectRecommendState(Recommend recommend);

	ArrayList<Recommend> selectRecommendListById(String id);

//	void insertAdministrator(Administrator administrator);
//	
//	// id媛? selectMember?씤 <select>?뿉 ???쓳?븯?뒗 硫붿꽌?뱶
//	List<Member> selectMembers();
//	
//	// id媛? selectMemberById?씤 <select>?뿉 ???쓳?븯?뒗 硫붿꽌?뱶
//	Member selectMemberById(String id);
//	
//	// id媛? selectMemberByIdAndPasswd?씤 <select>?뿉 ???쓳?븯?뒗 硫붿꽌?뱶
//	Member selectMemberByIdAndPassword(HashMap<String, Object> params);
//	
//	Customer selectCustomerById(String id);
//	Administrator selectAdministratorById(String id);
//	
//	String selectIdById(String id);
//	String selectNicknameByNickname(String nickname);

}