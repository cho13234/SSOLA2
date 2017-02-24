package com.ssola2.model.dao;

import java.util.List;

import com.ssola2.model.dto.Comment;



public interface CommentDao {
	public List<Comment> list (int sectionNo);
	public void insertComment(Comment comment);
	public void updateComment(Comment comment);
	public void deleteComment(int commentNo);
}
