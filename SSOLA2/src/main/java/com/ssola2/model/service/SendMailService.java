package com.ssola2.model.service;

import com.ssola2.model.dto.Customer;
import com.ssola2.model.dto.Member;

public interface SendMailService {
	public void sendTempPasswordEmailTx(Customer customer);
	
	void sendQuestEmailTx(String id, String articleTitle, String mailEditor);

//	public void sendQuestEmailTx(Customer customer, String mailEditor); //mailEditor는 jsp에서 내용 부분 name
}
