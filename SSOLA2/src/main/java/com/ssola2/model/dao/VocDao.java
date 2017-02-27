package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Voc;
import com.ssola2.model.dto.VocComment;



public interface VocDao {
	
	public void insertArticle(Voc voc);
	public List<Voc> selectArticles(int start, int pageSize);
	public Voc getArticleByAritcleNo(Integer articleNo);
	public Voc editArticleByArticleNo(Integer articleNo);
	public void editArticle(Voc voc);
	public void deleteArticle(int articleNo);
	public void updateVocReadCount(int articleNo);
	public int getVocTotalCount();
	
	/////////////////////////////////////////////////////////
	public void insertVocComment(VocComment vocComment);
	public VocComment editCommentByCommentNo(Integer commentNo);
	
	public void editVocComment(VocComment vocComment);
	public void deleteVocComment(int commentNo);

	public List<VocComment> selectVocCommentsByArtcicleNo(Integer articleNo);
	public void getVocCommentTotalCountByArticleNo(Integer articleNo);
	////////////////////////////////
	public List<Voc> selectArticlesById(int start, int pageSize, String id);

	
}