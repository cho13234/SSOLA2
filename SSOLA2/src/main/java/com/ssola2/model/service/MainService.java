package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Article;

public interface MainService{

	/**
	 *
	 * @param article
	 */
	public void registerArticleTx(Article article); 
	public List<Article> getArticleList();
	public List<Article> getArticleListByNum(int start, int end);
	public Article getArticleByArticleNoSize(int articleNo);
	public Article getArticleByArticleNo(Integer articleNo);
	
	public Article editArticleByArticleNo(Integer articleNo);
	public void deleteArticle(int articleNo);
	public void editArticle(Article article);
	
}
