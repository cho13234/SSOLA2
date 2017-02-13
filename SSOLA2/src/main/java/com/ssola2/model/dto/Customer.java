package com.ssola2.model.dto;

import java.util.Date;

import javax.validation.constraints.Future;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class Customer extends Member {

	@NotEmpty(message="이메일은 필수 입력 항목입니다.")
	@Email(message="이메일 형식이 맞지 않습니다.")
	private String email;
//	@Pattern(regexp="^[0-9]{4}-[0-9]{2}-[0-9]{2}*$",
//			message="생년월일 형식에 맞지 않습니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Past(message="해당 날짜의 데이터가 맞지 않습니다.")
	private Date birth;
	private boolean gender;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	
}
