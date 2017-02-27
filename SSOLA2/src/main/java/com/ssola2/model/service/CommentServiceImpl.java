package com.ssola2.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ssola2.model.dao.CommentDao;
import com.ssola2.model.dto.Comment;



@Service(value="commentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	@Qualifier("commentDao")
	private CommentDao dao;
	
	
	@Override
	public List<Comment> list(int sectionNo) {
		
		List<Comment> list = dao.list(sectionNo);
	    
	    return list;
	}

	@Override
	public void insertComment(Comment comment) {
		dao.insertComment(comment);
//		return comment; //자기가 보낸 값을 그대로 다시 가져온다.
	}

	@Override
	public void updateComment(Comment comment) {
		dao.updateComment(comment);
	}

	@Override
	public void deleteComment(int commentNo) {
		dao.deleteComment(commentNo);
	}

	

}
