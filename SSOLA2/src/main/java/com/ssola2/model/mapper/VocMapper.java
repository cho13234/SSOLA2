package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssola2.model.dto.FreeBoardComment;
import com.ssola2.model.dto.Voc;
import com.ssola2.model.dto.VocComment;

public interface VocMapper {

	void insertArticle(Voc voc);
	
	List<Voc> selectArticles(HashMap<String, Integer> params);
	
	Voc getArticleByArticleNo(Integer articleNo);
	
	Voc editArticleByArticleNo(Integer articleNo);

	void editArticle(Voc voc);

	void deleteArticle(int articleNo);

	void updateVocReadCount(int articleNo);

	int getVocTotalCount();

	List<Voc> selectMyVocList(String id);

	List<Voc> selectMyFBoardList(String id);

	List<Voc> selectArticlesById(HashMap<String, Object> params2);
	
	////////////////////////////////////////////////////////////
	
	void insertVocComment(VocComment vocComment);
	List<VocComment> selectVocCommentsByArticleNo(Integer articleNo);
	VocComment editCommentByCommentNo(Integer commentNo);
	
	void editVocComment(VocComment vocComment);
	void deleteVocComment(int commentNo);
	
	
	void getVocCommentTotalCountByArticleNo(Integer articleNo);
}