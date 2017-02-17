//package com.ssola2.config;
//
//import java.security.Principal;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.messaging.Message;
//import org.springframework.messaging.MessageChannel;
//import org.springframework.messaging.simp.config.ChannelRegistration;
//import org.springframework.messaging.simp.config.MessageBrokerRegistry;
//import org.springframework.messaging.simp.stomp.StompBrokerRelayMessageHandler;
//import org.springframework.messaging.simp.stomp.StompCommand;
//import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
//import org.springframework.messaging.support.ChannelInterceptorAdapter;
//import org.springframework.messaging.support.MessageHeaderAccessor;
//import org.springframework.web.servlet.config.annotation.EnableWebMvc;
//import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
//import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
//import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
//import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
//
//import com.ssola2.interceptor.ChannelInterceptor;
//import com.ssola2.interceptor.HandshakeInterceptor;
//
//@Configuration
//@EnableWebSocketMessageBroker
//public class WebSocketMessageBrokerConfig extends AbstractWebSocketMessageBrokerConfigurer {
//
////	@Autowired
////	private HandshakeInterceptor handShakeInterceptor;
//	
//	private static final Logger logger = LoggerFactory.getLogger(WebSocketMessageBrokerConfig.class);
//	
//	@Override
//	public void registerStompEndpoints(StompEndpointRegistry registry) {
//		registry.addEndpoint("/endpoint")
//			.addInterceptors(new HttpSessionHandshakeInterceptor())
//			//.addInterceptors(handShakeInterceptor)
////			.setAllowedOrigins("http://192.168.0.5:8888")
//			.withSockJS();
////			.setStreamBytesLimit(512 * 1024)
////			.setHttpMessageCacheSize(1000)
////			.setDisconnectDelay(30 * 1000)
//	}
//	
//	@Override
//	public void configureMessageBroker(MessageBrokerRegistry registry) {
//		registry.setApplicationDestinationPrefixes("/app");
//		registry.enableSimpleBroker("/queue", "/topic");
//	}
//	
//	@Override
//	public void configureClientInboundChannel(ChannelRegistration registration) {
//		/*registration.setInterceptors(new ChannelInterceptorAdapter() {
//			@Override
//			public Message<?> preSend(Message<?> message, MessageChannel channel) {
//				
//				StompHeaderAccessor sha = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
//				
//				if (StompCommand.CONNECT.equals(sha.getCommand())) {
//					//Principal user = ... ;
//					logger.info("in InboundChannel : CONNECT"); // 여기서 접속관리
//				} else if (StompCommand.DISCONNECT.equals(sha.getCommand())) {
//					logger.info("in InboundChannel : DISCONNECT"); // 여기서 접속해제 관리
//				}
//				
//				return message;
//			}
//		});*/
//		registration.setInterceptors(new ChannelInterceptor());
//	}
//}
