package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;
import com.ssola2.model.dto.Article;
import com.ssola2.model.dto.Section;

// com.mvcdemoweb.model.mapper.MemberMapper.xml 파일에 대응하는 인터페이스
public interface MainMapper {

	void insertArticle(Article article);

	Integer insertSection(Section section);
	
	List<Article> selectArticles();

	List<Article> selectArticlesByNum(HashMap<String, Object> params);

	Article selectArticleByArticleNoSize(int articleNo);
	
	Article getArticleByArticleNo(Integer articleNo);
	
	Article editArticleByArticleNo(Integer articleNo);
	Section editSection(Integer sectionNo);

	void editArticle(Article article);
	void editSection(Section section);

	void deleteArticle(int articleNo);
}