package com.project.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.AuthVO;
import com.project.domain.MemberVO;
import com.project.mapper.SignMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class SignServiceImpl implements SignService{
	
	private SignMapper mapper;
	private PasswordEncoder pw;
	
	@Override
	public boolean checkUser_id(String user_id) {
		return mapper.checkUser_id(user_id);
	}

	@Override
	@Transactional
	public void join(MemberVO member, AuthVO auth) {
		
		//회원가입
		//PasswordEncoder클래스의 encode메소드는 비밀번호를 자동으로 암호화해줌
		MemberVO mem = new MemberVO();
		mem.setUser_id(member.getUser_id());
		mem.setUser_pw(pw.encode(member.getUser_pw()));
		mem.setUser_name(member.getUser_name());
		mapper.signUp(mem);
		
		//권한설정
		AuthVO a = new AuthVO();
		a.setUser_id(auth.getUser_id());
		a.setAuth(auth.getAuth());
		mapper.signUp_auth(a);
		
	}

	@Override
	public boolean checkMember(MemberVO member) {
		return mapper.checkMember(member);
	}

	@Override
	public void updateUser_pw(MemberVO member) {
		mapper.updateUser_pw(member);
	}

}
