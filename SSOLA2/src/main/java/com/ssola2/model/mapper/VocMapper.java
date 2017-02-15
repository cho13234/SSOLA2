package com.ssola2.model.mapper;

import java.util.List;



import com.ssola2.model.dto.Voc;

// com.mvcdemoweb.model.mapper.MemberMapper.xml 파일에 대응하는 인터페이스
public interface VocMapper {

	void insertArticle(Voc voc);
	
	List<Voc> selectArticles();
	
	Voc getArticleByArticleNo(Integer articleNo);
	
	Voc editArticleByArticleNo(Integer articleNo);

	void editArticle(Voc voc);

	void deleteArticle(int articleNo);
}