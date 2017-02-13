package com.ssola2.model.dto;

public class Section {
	
	private int sectionNo;
	private String category;
	private String address;
	private String mainTag;
	private String storeName;

	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public int getSectionNo() {
		return sectionNo;
	}
	public void setSectionNo(int sectionNo) {
		this.sectionNo = sectionNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMainTag() {
		return mainTag;
	}
	public void setMainTag(String mainTag) {
		this.mainTag = mainTag;
	}
	
	
}
