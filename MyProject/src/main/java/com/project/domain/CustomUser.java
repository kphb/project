package com.project.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User{
	
	//MemberVO를 UserDetails타입으로 변환하기
    
    private static final long serialVersionUID = 1L;
    
    private MemberVO member;
 
    //CustomUser는 User클래스를 상속하기 때문에
    //부모 클래스의 생성자를 호출해야만 정상적인 객체를 생성할 수 있음
    public CustomUser(String username, String password,
            Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }
    
    //MemberVO를 파라미터로 전달해서 User클래스에 맞게 생성자를 호출
    //이 과정에서 AuthVO인스턴스는 GrantedAuthority객체로 변환
    public CustomUser(MemberVO vo) {
        super(vo.getUser_id(), vo.getUser_pw(), vo.getAuthList().stream()
                .map(i -> new SimpleGrantedAuthority(i.getAuth()))
                .collect(Collectors.toList()));
        
        this.member = vo;
    }
}
