package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Voc;



public interface VocDao {
	
	public void insertArticle(Voc voc);
	public List<Voc> selectArticles(int start, int pageSize);
	public Voc getArticleByAritcleNo(Integer articleNo);
	public Voc editArticleByArticleNo(Integer articleNo);
	public void editArticle(Voc voc);
	public void deleteArticle(int articleNo);
	public void updateVocReadCount(int articleNo);
	public int getVocTotalCount();
}