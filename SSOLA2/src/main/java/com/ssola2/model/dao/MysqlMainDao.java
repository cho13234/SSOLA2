package com.ssola2.model.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Section;
import com.ssola2.model.mapper.MainMapper;

@Repository(value="mainDao")
public class MysqlMainDao implements MainDao {

	@Autowired
	@Qualifier("mainMapper")
	private MainMapper mainMapper;

	@Override
	public void insertArticle(Article article) {
		mainMapper.insertArticle(article);
	}

	@Override
	public Integer insertSection(Section section) {
		return mainMapper.insertSection(section);
	}
	
	
	@Override
	public List<Article> selectArticles() {
		return mainMapper.selectArticles();
	}
	
	@Override
	public List<Article> selectArticlesByNum(int start, int end) {

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));
		
		return mainMapper.selectArticlesByNum(params);
	}
	
	@Override
	public Article selectArticleByArticleNoSize(int articleNo) {
		return mainMapper.selectArticleByArticleNoSize(articleNo);
	}

	@Override
	public Article getArticleByAritcleNo(Integer articleNo) {
		Article article = mainMapper.getArticleByArticleNo(articleNo);
		System.out.println(article.getArticleTitle()+"fghfgfg");
		return article;
	}

	@Override
	public Article editArticleByArticleNo(Integer articleNo) {
		
		 return mainMapper.editArticleByArticleNo(articleNo);
		
	}

	@Override
	public void deleteArticle(int articleNo) {
		mainMapper.deleteArticle(articleNo);
		
	}

	@Override
	public void editArticle(Article article) {
		mainMapper.editArticle(article);
		
	} 

	@Override
	public void editSection(Section section) {
		 mainMapper.editSection(section);
		
	}

	

}
