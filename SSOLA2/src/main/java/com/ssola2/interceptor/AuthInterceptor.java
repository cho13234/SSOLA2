package com.ssola2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ssola2.model.dto.Administrator;
import com.ssola2.model.dto.Member;

public class AuthInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
		Member member = (Member)request.getSession().getAttribute("loginuser");
	      
		String url = request.getRequestURI();
		boolean redirectLogin = false;
		boolean redirectMain = false;
	      
		if(url.contains("/account/")) {
			if(url.contains("adminregister.action")) {
				if(member == null || !member.isUserType() || !((Administrator)member).isAuthority()) {
					redirectMain = true;
				}
			}
		} else if(url.contains("/main/")){
			if(url.contains("write.action")) {
				if(member == null || !member.isUserType() || ((Administrator)member).isAuthority()) {
					redirectMain = true;
				}
			} else if(url.contains("delete.action") || url.contains("edit.action")) {
				if(member == null || !member.isUserType()) {
					redirectLogin = true;
				}
			}
		} else if(url.contains("/mypage/")){
			if(member == null) {
				redirectLogin = true;
			}
		}
		
		if(redirectLogin) {
			response.sendRedirect("/ssola/account/login.action");
		} else if (redirectMain) {
			response.sendRedirect("/ssola/main/main.action");
		}
    
		return !redirectLogin; //false가 반환되면 요청 처리 중단...<더이상 진행하지 않도록 막아주는 역할>
	}

	@Override // 컨트롤러에 있는 mapping된 method가 처리를 끝냈을 때 요청됨. after returning of controller method
	//아직 뷰까지 요청되지 않은 상태입니다.
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
//      System.out.println("HandlerInterceptor.postHandler");
	}

	@Override //after request processing
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
         throws Exception {
//   )   System.out.println("HandlerInterceptor.afterHandler");
      
	}
   
}