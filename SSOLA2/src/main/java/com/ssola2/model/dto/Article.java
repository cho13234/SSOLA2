package com.ssola2.model.dto;

import java.util.ArrayList;
import java.util.Date;


public class Article {
	
	private int articleNo;
	private String articleTitle;
	private Date regDate;
	private Boolean deleted;
	private String id;
	private String mainImage;
	private Section section1;
	private Section section2;
	private Section section3;
	private Section section4;
//	private ArrayList<Recommend> recommends;
	private int recommendCount;
	
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
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
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
	public String getMainImage() {
		return mainImage;
	}
	public void setMainImage(String mainImage) {
		this.mainImage = mainImage;
	}
	public Section getSection1() {
		return section1;
	}
	public void setSection1(Section section1) {
		this.section1 = section1;
	}
	public Section getSection2() {
		return section2;
	}
	public void setSection2(Section section2) {
		this.section2 = section2;
	}
	public Section getSection3() {
		return section3;
	}
	public void setSection3(Section section3) {
		this.section3 = section3;
	}
	public Section getSection4() {
		return section4;
	}
	public void setSection4(Section section4) {
		this.section4 = section4;
	}
//	public ArrayList<Recommend> getRecommends() {
//		return recommends;
//	}
//	public void setRecommends(ArrayList<Recommend> recommends) {
//		this.recommends = recommends;
//	}
	public int getRecommendCount() {
		return recommendCount;
	}
	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}
	
}
