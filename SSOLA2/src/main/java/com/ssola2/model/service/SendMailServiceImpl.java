package com.ssola2.model.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import com.ssola2.common.Util;
import com.ssola2.model.dao.MemberDao;
import com.ssola2.model.dto.Customer;

@Service(value="mailService")
public class SendMailServiceImpl implements SendMailService {
	
	@Autowired
	@Qualifier("mailSender")
	private MailSender sender;
	
	@Autowired
	@Qualifier("memberDao")
	private MemberDao memberDao;
	
	
	@Override
	public void sendTempPasswordEmailTx(Customer customer) {
		
		SimpleMailMessage message = new SimpleMailMessage();
		
		String tempPassword = Util.temporaryPassword(10) ;
		String hashPassword = Util.getHashedString(tempPassword, "SHA-256");
		customer.setPassword(hashPassword);
		
		memberDao.updatePasswordByIdAndEmail(customer);
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("임시 비밀번호는 \r\n")
			.append(tempPassword)
			.append("\r\n 입니다");
		
		message.setSubject(customer.getId() + "님 임시비밀번호 안내입니다.");
		message.setFrom("kwonjunho90@naver.com");
		message.setText(sb.toString());
		message.setTo(customer.getEmail());
		
		sender.send(message);
		
		return;
	}
	
	@Override
	public void sendQuestEmailTx(String id, String articleTitle, String mailEditor) {
		System.out.println("sendQuestEmailTx 들어옴");
		
		System.out.println("try 못 들어감");
		try
		{			
			SimpleMailMessage msg = new SimpleMailMessage();			
//			String text ="testtest";
			
			msg.setSubject(articleTitle);
			msg.setFrom("kwonjunho90@naver.com");
			msg.setText(mailEditor);
			msg.setTo("kwonjunho90@naver.com");
			
			sender.send(msg);
			System.out.println("성공적으로 이메일 발송.");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("catch");
		}
		return;
		
	}
	
}
