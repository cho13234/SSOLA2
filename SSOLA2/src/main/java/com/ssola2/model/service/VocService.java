package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Voc;

public interface VocService{

	/**
	 *
	 * @param article
	 */
	public void registerArticleTx(Voc voc); 
	public List<Voc> getArticleList(int start, int pageSize);
	public Voc getArticleByArticleNo(Integer articleNo);
	public Voc editArticleByArticleNo(Integer articleNo);
	public void deleteArticle(int articleNo);
	public void editArticle(Voc voc);
	public void updateVocReadCount(int articleNo);
	public int getVocTotalCount();

	
				
}