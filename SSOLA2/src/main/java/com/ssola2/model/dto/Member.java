package com.ssola2.model.dto;

import java.util.Date;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class Member {
	
	@NotEmpty(message="아이디는 필수 입력 항목입니다.")
	@Pattern(regexp="^.*(?=.{4,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$", 
				message="아이디는 숫자+영어 4~20글자 크기를 가져야 합니다.")
	private String id;
	@NotEmpty(message="비밀번호는 필수 입력 항목입니다.")
	@Pattern(regexp="^.*(?=.{8,16})(?=.*[0-9])(?=.*[a-zA-Z]).*$", 
				message="비밀번호는 숫자+영어 8-16자리입니다")
	private String password;
	@NotEmpty(message="닉네임은 필수 입력 항목입니다.")
	@Pattern(regexp="^.*(?=.{2,15})(?=.*[ㄱ-ㅎ가-힣a-zA-Z0-9]).*$", 
				message="닉네임은 2-15자리입니다")
	private String nickname;
	private Date regDate;
	private String phoneNumber;
	private boolean deleted;
	private boolean userType;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public boolean isUserType() {
		return userType;
	}
	public void setUserType(boolean userType) {
		this.userType = userType;
	}
	
}
