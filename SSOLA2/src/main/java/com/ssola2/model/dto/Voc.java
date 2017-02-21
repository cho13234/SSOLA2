package com.ssola2.model.dto;

import java.util.Date;


public class Voc {
	
	
	private int articleNo;
	private String articleTitle;
	private String articleContent;
	private Date regDate;
	private String category;
	private Boolean deleted;
	private Boolean secure;
	private String id;
	private int readCount;
	
	public String toString(){
		return String.format("articleNo : %d / articleTitle : %s / articleContent : %s / regDate : %s / category : %s / deleted : %s / secure : %s / id : %s ",
							articleNo, articleTitle, articleContent, regDate, category, deleted, secure, id);
	}
	
	
	public int getReadCount() {
		return readCount;
	}


	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	public Boolean getSecure() {
		return secure;
	}
	public void setSecure(Boolean secure) {
		this.secure = secure;
	}
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public String getArticleTitle() {
		return articleTitle;
	}
	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}
	public String getArticleContent() {
		return articleContent;
	}
	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
