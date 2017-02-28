package com.ssola2.model.mapper;

import java.util.HashMap;
import java.util.List;
import com.ssola2.model.dto.FreeBoard;
import com.ssola2.model.dto.FreeBoardComment;

public interface FreeBoardMapper {
	///////////////////////////////////////
	//boards 불러오기
	void insertFreeBoard(FreeBoard freeBoard);
	
	List<FreeBoard> selectFreeBoards(HashMap<String, Integer> params);
	
	FreeBoard getFreeBoardByArticleNo(Integer articleNo);
	
	FreeBoard editFreeBoardByArticleNo(Integer articleNo);

	void editFreeBoard(FreeBoard freeBoard);

	void deleteFreeBoard(int articleNo);

	void updateFreeBoardReadCount(int articleNo);
	
	int getFreeBoardTotalCount();
	
	////////////////////////////////////////////////////////////
	List<FreeBoard> selectFreeBoardsById(HashMap<String, Object> params2);

	//comment불러오기
	
	void insertFreeBoardComment(FreeBoardComment freeBoardComment);
	List<FreeBoardComment> selectFreeBoardCommentsByArticleNo(Integer articleNo);
	FreeBoardComment editCommentByCommentNo(Integer commentNo);
	
	void editFreeBoardComment(FreeBoardComment freeBoardComment);
	void deleteFreeBoardComment(int commentNo);
	
	
	void getFreeBoardCommentTotalCountByArticleNo(Integer articleNo);
}