package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Voc;
import com.ssola2.model.dto.VocComment;

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
	public List<Voc> getArticleListById(int start, int pageSize, String id);
	
	//////////////////////
	public void insertVocComment(VocComment vocComment);
	public VocComment editCommentByCommentNo(Integer commentNo);
	
	public void editVocComment(VocComment vocComment);
	public void deleteVocComment(int commentNo);

	public List<VocComment> getVocCommentList(Integer articleNo);
	public void getVocCommentTotalCountByArticleNo(Integer articleNo);
}
