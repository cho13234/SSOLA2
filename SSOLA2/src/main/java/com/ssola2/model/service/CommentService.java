package com.ssola2.model.service;

import java.util.List;

import com.ssola2.model.dto.Comment;



public interface CommentService {
	public List<Comment> list (int sectionNo);
	public void insertComment(Comment comment);
	public void updateComment(Comment comment);
	public void deleteComment(int commentNo);
}
