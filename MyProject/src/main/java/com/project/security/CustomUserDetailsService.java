package com.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.project.domain.CustomUser;
import com.project.domain.MemberVO;
import com.project.mapper.SignMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService{ 
	
	//UserDetailsService 인터페이스는 DB에서 유저 정보를 가져와서
	//Authentication-Provider 인터페이스로 유저 정보를 리턴하면
	//그 곳에서 사용자가 입력한 정보와 DB에 있는 유저 정보를 비교함
	
	//굳이 CustomUserDetailsService를 이용하는 이유는
	//jsp 등에서 사용자의 이름이나 이메일과 같은 추가적인 정보를 이용하기 위해서

    @Setter(onMethod_ = @Autowired)
    private SignMapper mapper;
    
    @Override
    public UserDetails loadUserByUsername(String user_id) throws UsernameNotFoundException {
    	
    	//loadUserByUsername()는 내부적으로 signMapper를 이용해서 MemberVO를 조회하고
    	//MemberVO의 인스턴스를 얻을 수 있다면 CustomUser타입의 객체로 변환해서 반환
    	
        log.warn("사용자id: "+user_id);
 
        MemberVO vo = mapper.selectOne(user_id);
        
        log.warn("mapper.selectOne(user_id): "+vo);
        
        return vo == null ? null : new CustomUser(vo);
        //CustomUser의 객체로 변환해서 반환
 
    }
 
}

