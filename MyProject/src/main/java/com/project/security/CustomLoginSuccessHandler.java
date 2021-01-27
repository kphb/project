package com.project.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{ //로그인 성공 후
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication auth) throws IOException, ServletException {
 
        log.warn("로그인 성공");
        
        List<String> roleNames = new ArrayList<String>();
        
        auth.getAuthorities().forEach(i -> { roleNames.add(i.getAuthority()); });
        
        log.warn("ROLE NAMES: "+roleNames);
        
        if(roleNames.contains("ROLE_ADMIN")) { //관리자권한을 가진 사용자가 로그인하면
            response.sendRedirect("/admin/main"); //해당 페이지로 이동
            return;
        }
        
        if(roleNames.contains("ROLE_MEMBER")) { //회원권한을 가진 사용자가 로그인하면
            response.sendRedirect("/main/main"); //해당 페이지로 이동
            return;
        }
        response.sendRedirect("/");
    }
 
}