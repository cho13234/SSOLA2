package com.ssola2.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

public class StompDisconnectEvent implements ApplicationListener<SessionDisconnectEvent> {

	private static final Logger logger = LoggerFactory.getLogger(StompDisconnectEvent.class);

	@Override
	public void onApplicationEvent(SessionDisconnectEvent event) {

		StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
		
		//logger.info(event.toString());
		logger.info("Disconnect event [SessionId: " + sha.getSessionId() + "]");
		
	}
	
}
