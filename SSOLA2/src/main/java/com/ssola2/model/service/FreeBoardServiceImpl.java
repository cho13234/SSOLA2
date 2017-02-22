package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.FreeBoardDao;
import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;



@Service(value="freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired
	@Qualifier("freeBoardDao")
	private FreeBoardDao dao;

	@Override
	public void registerArticleTx(FreeBoard freeBoard) {
		dao.insertFreeBoard(freeBoard);
		
	}

	@Override
	public List<FreeBoard> getFreeBoardList(int start, int pageSize) {
		
		return dao.selectFreeBoards(start, pageSize);
	}

	@Override
	public FreeBoard getFreeBoardByArticleNo(Integer articleNo) {
		
		return dao.getFreeBoardByAritcleNo(articleNo);
	}

	@Override
	public FreeBoard editFreeBoardByArticleNo(Integer articleNo) {
		return dao.editFreBoardByArticleNo(articleNo);
	}

	@Override
	public void deleteFreeBoard(int articleNo) {
		dao.deleteFreeBoard(articleNo);
		
	}

	@Override
	public void editFreeBoard(FreeBoard freeBoard) {
		dao.editFreeBoard(freeBoard);
		
	}

	@Override
	public void updateFreeBoardReadCount(int articleNo) {
		dao.updateFreeBoardReadCount(articleNo);
		
	}

	@Override
	public int getFreeBoardTotalCount() {
		int totalCount = dao.getFreeBoardTotalCount();
		return totalCount;
	}

	@Override
	public void insertFreeBoardComment(FreeBoardComment freeBoardComment) {
		dao.insertFreeBoardComment(freeBoardComment);
		
	}

	@Override
	public void editFreeBoardComment(FreeBoardComment freeBoardComment) {
		dao.editFreeBoardComment(freeBoardComment);
	}


	@Override
	public List<FreeBoardComment> getFreeBoardCommentList(Integer articleNo) {
		return dao.selectFreeBoardCommentsByArtcicleNo(articleNo);
	}

	@Override
	public void deleteFreeBoardComment(int commentNo) {
		dao.deleteFreeBoardComment(commentNo);
		
	}

	@Override
	public List<FreeBoard> getFreeBoardListById(int start, int pageSize, String id) {		
		return dao.selectFreeBoardsById(start, pageSize, id);
	}
	

	

}
