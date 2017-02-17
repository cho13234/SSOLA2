package com.ssola2.model.dto;

import java.util.HashMap;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("singleton")
public class LoginUserSession {
	private HashMap<String, LoginUser> loginUsers;
	
	public LoginUserSession() {
		loginUsers = new HashMap<String, LoginUser>();
	}

	public HashMap<String, LoginUser> getLoginUsers() {
		return loginUsers;
	}

	public void setLoginUsers(HashMap<String, LoginUser> loginUsers) {
		this.loginUsers = loginUsers;
	}
	
	public LoginUser getLoginUser(String id) {
		return loginUsers.get(id); 
	}
	
	public void putLoginUser(LoginUser loginUser) {
		// user의 id와 객체를 매핑한다.
		loginUsers.put(loginUser.getId(), loginUser);
	}
}
