package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;



public interface FreeBoardDao {
	
	public void insertFreeBoard(FreeBoard freeBoard);
	public List<FreeBoard> selectFreeBoards(int start, int pageSize);
	public FreeBoard getFreeBoardByAritcleNo(Integer articleNo);
	public FreeBoard editFreBoardByArticleNo(Integer articleNo);
	public void editFreeBoard(FreeBoard freeBoard);
	public void deleteFreeBoard(int articleNo);
	public void updateFreeBoardReadCount(int articleNo);
	public int getFreeBoardTotalCount();
	////////////////////////////////////////////////////////////////
	
	public void insertFreeBoardComment(FreeBoardComment freeBoardComment);
	public FreeBoardComment editCommentByCommentNo(Integer commentNo);
	
	public void editFreeBoardComment(FreeBoardComment freeBoardComment);
	public void deleteFreeBoardComment(int commentNo);

	public List<FreeBoardComment> selectFreeBoardCommentsByArtcicleNo(Integer articleNo);
	public void getFreeBoardCommentTotalCountByarticleNo(Integer articleNo);
	/////////////////////////////
	public List<FreeBoard> selectFreeBoardsById(int start, int pageSize, String id);
	

}