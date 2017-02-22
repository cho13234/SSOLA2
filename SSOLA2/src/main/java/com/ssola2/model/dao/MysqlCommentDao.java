package com.ssola2.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ssola2.model.dto.Comment;
import com.ssola2.model.mapper.CommentMapper;


@Repository(value="commentDao")
public class MysqlCommentDao implements CommentDao {

	@Autowired
	@Qualifier("commentMapper")
	private CommentMapper commentMapper;
	
	@Override
	public List<Comment> list(int sectionNo) {
	    
		List<Comment> list = commentMapper.list(sectionNo);
	  
	    return list;
	}

	@Override
	public void insertComment(Comment comment) {
		commentMapper.insertComment(comment);
	}

	@Override
	public void updateComment(Comment comment) {
		
		commentMapper.updateComment(comment);

	}

	@Override
	public void deleteComment(int commentNo) {
		commentMapper.deleteComment(commentNo);

	}

}
