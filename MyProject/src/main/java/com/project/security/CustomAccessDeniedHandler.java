package com.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{ //권한없는 사용자가 접근하면 accessError.jsp로 이동
 
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
            AccessDeniedException accessDeniedException) throws IOException, ServletException {
        
        log.error("Access Denied Handler");
        log.error("Redirect.........");
        response.sendRedirect("/sign/accessError");
        
        //<security:access-denied-handler error-page="/accessError" />
        //위의 경우는 url자체의 변화는 없고 화면의 내용만 accessError.jsp를 보여줌
        
        //HttpServletResponse에 특정한 헤더정보를 추가하는 경우 직접 구현하는 방식이 더 권장됨
        //response.sendRedirect("/accessError")를 이용해서
        //url자체를 /accessError로 리다이렉트 시킴
    }
 
}

