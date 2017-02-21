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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void editFreeBoardComment(FreeBoardComment freeBoardComment) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteFreeBoardComment(int commentNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<FreeBoardComment> selectFreeBoardCommentsByArtcicleNo(Integer articleNo) {
		// TODO Auto-generated method stub
		return null;
	}

	
	

}