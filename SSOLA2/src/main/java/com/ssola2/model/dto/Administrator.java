package com.ssola2.model.dto;

public class Administrator extends Member {
	
	private boolean authority;

	public boolean isAuthority() {
		return authority;
	}

	public void setAuthority(boolean authority) {
		this.authority = authority;
	}
	
}
