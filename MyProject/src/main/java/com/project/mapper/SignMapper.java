package com.project.mapper;

import com.project.domain.AuthVO;
import com.project.domain.MemberVO;

public interface SignMapper {
	
	//정보확인
	public MemberVO selectOne(String user_id);
	
	//아이디 중복확인
	public boolean checkUser_id(String user_id);
	
	//회원가입
	public void signUp(MemberVO member);
	
	//권한설정
	public void signUp_auth(AuthVO auth);
	
	//비밀번호 찾기(아이디&이름으로 존재하는 회원인지 조회)
	public boolean checkMember(MemberVO member);
	
	//비밀번호 변경
	public void updateUser_pw(MemberVO member);
	

}
