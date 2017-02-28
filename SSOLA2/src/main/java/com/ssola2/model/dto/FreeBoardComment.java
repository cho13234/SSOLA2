package com.ssola2.model.dto;

import java.util.Date;


public class FreeBoardComment {
	
	private int articleNo;
	private int commentNo;
	private String commentContent;
	private Date regDate;
	private String id;
	private boolean deleted;
	
	
	
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
