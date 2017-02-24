package com.ssola2.model.mapper;

import java.util.List;

import com.ssola2.model.dto.Comment;


public interface CommentMapper {

	public List<Comment> list (int sectionNo);
	
	public void insertComment(Comment comment);
	
	public void updateComment(Comment comment);
	
	public void deleteComment(int commentNo);
}
