package com.ssola2.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.RecommendDao;
import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Recommend;

@Service(value="recommendService")
public class RecommendServiceImpl implements RecommendService {
	
	@Autowired
	@Qualifier("recommendDao")
	private RecommendDao dao;

	@Override
	public int selectRecommendCount(Recommend recommend) {

		return dao.selectRecommendCount(recommend);
	}

	@Override
	public void insertRecommend(Recommend recommend) {
		dao.insertRecommend(recommend);
		
	}

	public void deletedRecommend(Recommend recommend) {
		dao.deletedRecommend(recommend);
		
	}

	@Override
	public Recommend selectRecommendById(Recommend recommend) {
		return dao.selectRecommendById(recommend);
	}

	@Override
	public Article selectDetail(Recommend recommend) {
		
		return dao.selectDetail(recommend);
	}

	@Override
	public String selectRecommnedState(Recommend recommend) {
		
		return dao.selectRecommendState(recommend);
	}
	
	@Override
	public ArrayList<Recommend> getListById(String id) {

		return dao.selectRecommendListById(id);
	}

}
