package com.project.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.AuthVO;
import com.project.domain.MemberVO;
import com.project.service.SignService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/sign/*")
@AllArgsConstructor
@Slf4j
public class SignController {
	
	private SignService service;
	private PasswordEncoder pw;
	
	//회원가입 페이지
	@GetMapping("/signUp")
	public void signUp() {
		
	}
	
	//아이디 중복확인
	@ResponseBody
	@GetMapping(value="/check_id")
	public boolean check_id(String user_id) {
		return service.checkUser_id(user_id);
	}
	
	//회원가입 페이지에서 입력한 정보를 전달받음
	@PostMapping("/signUp")
	public String SignUp2(MemberVO member, AuthVO auth) {
				
		//회원가입+권한설정 같이 하기위한 메소드
		service.join(member,auth);
		
		return "redirect:/main/main";
	}
	
	//로그인 페이지
	@GetMapping("/customLogin")
    public void customLogin(String error, Model model) {
		log.info("=====로그인 페이지=====");
        log.info("에러: "+error);
        
        if(error != null) {
            model.addAttribute("error", "아이디,비밀번호를 다시 확인해주세요.");
        }
    }
	
	//로그아웃 페이지
	@GetMapping("/logout")
	public void logout() {
		
	}
	
	//비밀번호 찾기
	@GetMapping("/findPassword")
	public void findPassword() {
		
	}
	
	//아이디&이름으로 존재하는 회원인지 조회
	@ResponseBody
	@GetMapping("/check_member")
	public boolean check_member(MemberVO member) {
		return service.checkMember(member);
	}
	
	//비밀번호 변경
	@PostMapping("/changeUser_pw")
	public String changeUser_pw(MemberVO member) {
		
		//전달받은 비밀번호를 암호화하고 저장
		MemberVO mem = new MemberVO();
		mem.setUser_id(member.getUser_id());
		mem.setUser_pw(pw.encode(member.getUser_pw()));
		mem.setUser_name(member.getUser_name());
		service.updateUser_pw(mem);
		
		return "redirect:/sign/customLogin";
	}

	
	//권한이 없는 페이지에 접근할 경우
	@GetMapping("/accessError")
    public void accessDenied(Authentication auth) {
        log.info("접근거부: "+auth);
    }
	

}
