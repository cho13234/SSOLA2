package com.ssola2.model.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


import com.ssola2.model.dto.Voc;
import com.ssola2.model.mapper.VocMapper;

@Repository(value="vocDao")
public class MysqlVocDao implements VocDao {

	@Autowired
	@Qualifier("vocMapper")
	private VocMapper vocMapper;

	@Override
	public void insertArticle(Voc voc) {
		vocMapper.insertArticle(voc);
	}
	
	
	@Override
	public List<Voc> selectArticles(int start, int pageSize) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("start", start);
		params.put("count", pageSize);
		return vocMapper.selectArticles(params);
	}

	@Override
	public Voc getArticleByAritcleNo(Integer articleNo) {
		Voc voc = vocMapper.getArticleByArticleNo(articleNo);
		return voc;
	}

	@Override
	public Voc editArticleByArticleNo(Integer articleNo) {
		
		 return vocMapper.editArticleByArticleNo(articleNo);
		
	}

	@Override
	public void deleteArticle(int articleNo) {
		vocMapper.deleteArticle(articleNo);
		
	}

	@Override
	public void editArticle(Voc voc) {
		vocMapper.editArticle(voc);
		
	}


	@Override
	public void updateVocReadCount(int articleNo) {
		vocMapper.updateVocReadCount(articleNo);
		
	}


	@Override
	public int getVocTotalCount() {
		return vocMapper.getVocTotalCount();
	}



	

	

}
