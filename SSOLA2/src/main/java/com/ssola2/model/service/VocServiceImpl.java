package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.VocDao;
import com.ssola2.model.dto.Voc;
import com.ssola2.model.dto.VocComment;


@Service(value="vocService")
public class VocServiceImpl implements VocService {
	
	@Autowired
	@Qualifier("vocDao")
	private VocDao dao;

	@Override
	public void registerArticleTx(Voc voc) {
		dao.insertArticle(voc);
		
	}

	@Override
	public List<Voc> getArticleList(int start, int pageSize) {
		return dao.selectArticles(start, pageSize);
	}

	@Override
	public Voc getArticleByArticleNo(Integer articleNo) {
		
		return dao.getArticleByAritcleNo(articleNo);
	}

	@Override
	public Voc editArticleByArticleNo(Integer articleNo) {
		
		return dao.editArticleByArticleNo(articleNo);
	}
	
	@Override
	public void editArticle(Voc voc) {
		dao.editArticle(voc);
		
	}
	@Override
	public void deleteArticle(int articleNo) {
		dao.deleteArticle(articleNo);
		
	}

	@Override
	public void updateVocReadCount(int articleNo) {
		dao.updateVocReadCount(articleNo);
		
	}

	@Override
	public int getVocTotalCount() {
		int totalCount = dao.getVocTotalCount();
		return totalCount;
	}

	@Override
	public List<Voc> getArticleListById(int start, int pageSize, String id) {
		return dao.selectArticlesById(start, pageSize, id);
	}

	@Override
	public void insertVocComment(VocComment vocComment) {
		dao.insertVocComment(vocComment);
		
	}

	@Override
	public VocComment editCommentByCommentNo(Integer commentNo) {
		
		return dao.editCommentByCommentNo(commentNo);
	}

	@Override
	public void editVocComment(VocComment vocComment) {
		dao.editVocComment(vocComment);
		
	}

	@Override
	public void deleteVocComment(int commentNo) {
		dao.deleteVocComment(commentNo);
		
	}

	@Override
	public List<VocComment> getVocCommentList(Integer articleNo) {
		return dao.selectVocCommentsByArtcicleNo(articleNo);
	}

	@Override
	public void getVocCommentTotalCountByArticleNo(Integer articleNo) {
		dao.getVocCommentTotalCountByArticleNo(articleNo);
		
	}

	
	

}
