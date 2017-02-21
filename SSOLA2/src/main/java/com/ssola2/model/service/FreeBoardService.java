package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;

public interface FreeBoardService{

	/**
	 *
	 * @param article
	 */
	public void registerArticleTx(FreeBoard freeBoard); 
	public List<FreeBoard> getFreeBoardList(int start, int pageSize);
	public FreeBoard getFreeBoardByArticleNo(Integer articleNo);
	public FreeBoard editFreeBoardByArticleNo(Integer articleNo);

	public void deleteFreeBoard(int articleNo);
	public void editFreeBoard(FreeBoard freeBoard);
	public void updateFreeBoardReadCount(int articleNo);
	public int getFreeBoardTotalCount();
	
	public void insertFreeBoardComment(FreeBoardComment freeBoardComment);
	public void editFreeBoardComment(FreeBoardComment freeBoardComment);
	public void deleteFreeBoardComment(int commentNo);
	public List<FreeBoardComment> getFreeBoardCommentList(Integer articleNo);
	
	
}
