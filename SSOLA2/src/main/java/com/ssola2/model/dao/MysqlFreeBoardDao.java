package com.ssola2.model.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;
import com.ssola2.model.mapper.FreeBoardMapper;

@Repository(value="freeBoardDao")
public class MysqlFreeBoardDao implements FreeBoardDao {
	
	@Autowired
	@Qualifier("freeBoardMapper")
	private FreeBoardMapper FreeBoardMapper;
	
	@Override
	public void insertFreeBoard(FreeBoard freeBoard) {
		FreeBoardMapper.insertFreeBoard(freeBoard);
		
	}

	@Override
	public List<FreeBoard> selectFreeBoards(int start, int pageSize) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("start", start);
		params.put("count", pageSize);
		
		return FreeBoardMapper.selectFreeBoards(params);
	}

	@Override
	public FreeBoard getFreeBoardByAritcleNo(Integer articleNo) {
		
		return FreeBoardMapper.getFreeBoardByArticleNo(articleNo);
	}

	@Override
	public FreeBoard editFreBoardByArticleNo(Integer articleNo) {
		return FreeBoardMapper.editFreeBoardByArticleNo(articleNo);
	}

	@Override
	public void editFreeBoard(FreeBoard freeBoard) {
		FreeBoardMapper.editFreeBoard(freeBoard);
		
	}

	@Override
	public void deleteFreeBoard(int articleNo) {
		FreeBoardMapper.deleteFreeBoard(articleNo);
		
	}

	@Override
	public void updateFreeBoardReadCount(int articleNo) {
		FreeBoardMapper.updateFreeBoardReadCount(articleNo);
		
	}

	@Override
	public int getFreeBoardTotalCount() {
		return FreeBoardMapper.getFreeBoardTotalCount();
	}

	@Override
	public void insertFreeBoardComment(FreeBoardComment freeBoardComment) {
		FreeBoardMapper.insertFreeBoardComment(freeBoardComment);
		
	}

	@Override
	public void editFreeBoardComment(FreeBoardComment freeBoardComment) {
		FreeBoardMapper.editFreeBoardComment(freeBoardComment);
		
	}

	@Override
	public void deleteFreeBoardComment(int commentNo) {
		FreeBoardMapper.deleteFreeBoardComment(commentNo);
		
	}


	@Override
	public List<FreeBoardComment> selectFreeBoardCommentsByArtcicleNo(Integer articleNo) {
		
		return FreeBoardMapper.selectFreeBoardCommentsByArticleNo(articleNo);
	}

	@Override
	public FreeBoardComment editCommentByCommentNo(Integer commentNo) {
		
		return FreeBoardMapper.editCommentByCommentNo(commentNo);
	}

	public List<FreeBoard> selectFreeBoardsById(int start, int pageSize, String id) {		
		HashMap<String, Object> params2 = new HashMap<String, Object>();
		params2.put("start", start);
		params2.put("count", pageSize);
		params2.put("id", id);
		return FreeBoardMapper.selectFreeBoardsById(params2);
	}

	@Override
	public void getFreeBoardCommentTotalCountByarticleNo(Integer articleNo) {
		FreeBoardMapper.getFreeBoardCommentTotalCountByArticleNo(articleNo);
		
	}

	
	

}
