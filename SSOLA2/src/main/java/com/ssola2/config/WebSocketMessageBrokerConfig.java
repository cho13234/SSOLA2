package com.ssola2.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.ssola2.interceptor.HandshakeInterceptor;

@Configuration
@EnableWebSocketMessageBroker
@EnableWebMvc
public class WebSocketMessageBrokerConfig extends AbstractWebSocketMessageBrokerConfigurer {

//	@Autowired
//	private HandshakeInterceptor handShakeInterceptor;
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/stomp")
			//.addInterceptors(new HttpSessionHandshakeInterceptor())
			//.addInterceptors(handShakeInterceptor)
//			.setAllowedOrigins("http://192.168.0.5:8888")
			.withSockJS();
//			.setStreamBytesLimit(512 * 1024)
//			.setHttpMessageCacheSize(1000)
//			.setDisconnectDelay(30 * 1000)
	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		registry.setApplicationDestinationPrefixes("/app");
		registry.enableSimpleBroker("/queue", "/topic");
	}
}
