package com.ssola2.model.service;

import java.util.ArrayList;
import java.util.List;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Member;
import com.ssola2.model.dto.Recommend;

public interface RecommendService {
	
	public int selectRecommendCount(Recommend recommend);
	
	public void insertRecommend(Recommend recommend);

	public void deletedRecommend(Recommend recommend);

	public Recommend selectRecommendById(Recommend recommend);

	public Article selectDetail(Recommend recommend);

	public String selectRecommnedState(Recommend recommend);
	
	

	public ArrayList<Recommend> getListById(String id);

}
