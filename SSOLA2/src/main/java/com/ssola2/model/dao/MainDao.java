package com.ssola2.model.dao;

import java.util.List;


import com.ssola2.model.dto.Article;

import com.ssola2.model.dto.Section;

public interface MainDao {
	
	public void insertArticle(Article article);
	public Integer insertSection(Section section);
	public List<Article> selectArticles();
	public List<Article> selectArticlesByNum(int start, int end);
	public Article selectArticleByArticleNoSize(int articleNo);
	public Article getArticleByAritcleNo(Integer articleNo);
	public Article editArticleByArticleNo(Integer articleNo);
	public void editArticle(Article article);
	public void editSection(Section section);
	public void deleteArticle(int articleNo);
}
