package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;



import com.ssola2.model.dto.Voc;

public interface VocMapper {

	void insertArticle(Voc voc);
	
	List<Voc> selectArticles(HashMap<String, Integer> params);
	
	Voc getArticleByArticleNo(Integer articleNo);
	
	Voc editArticleByArticleNo(Integer articleNo);

	void editArticle(Voc voc);

	void deleteArticle(int articleNo);

	void updateVocReadCount(int articleNo);

	int getVocTotalCount();
}