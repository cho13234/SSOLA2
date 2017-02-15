package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.MainDao;
import com.ssola2.model.dto.Article;


@Service(value="mainService")
public class MainServiceImpl implements MainService {
	
	@Autowired
	@Qualifier("mainDao")
	private MainDao dao;

	@Override
	public void registerArticleTx(Article article) {
		
		dao.insertSection(article.getSection1());
		dao.insertSection(article.getSection2());
		dao.insertSection(article.getSection3());
		dao.insertSection(article.getSection4());
		dao.insertArticle(article);
		
	}

	@Override
	public List<Article> getArticleList() {
		return dao.selectArticles();
	}
	
	@Override
	public List<Article> getArticleListByNum(int start, int end) {
		return dao.selectArticlesByNum(start, end);
	}
	
	@Override
	public Article getArticleByArticleNoSize(int articleNo) {
		return dao.selectArticleByArticleNoSize(articleNo);
	}

	@Override
	public Article getArticleByArticleNo(Integer articleNo) {
		return dao.getArticleByAritcleNo(articleNo);
	}

	@Override
	public Article editArticleByArticleNo(Integer articleNo) {
		return dao.editArticleByArticleNo(articleNo);
		
	}
	
	@Override
	public void editArticle(Article article) {
		dao.editSection(article.getSection1());
		dao.editSection(article.getSection2());
		dao.editSection(article.getSection3());
		dao.editSection(article.getSection4());
		dao.editArticle(article);
		
	}

	@Override
	public void deleteArticle(int articleNo) {
		dao.deleteArticle(articleNo);
		
	}

	

}
