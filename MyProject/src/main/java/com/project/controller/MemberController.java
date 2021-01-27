package com.project.controller;

import java.util.Date;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Criteria;
import com.project.domain.MemberVO;
import com.project.domain.PageMaker;
import com.project.service.MemberService;
import com.project.service.SignService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
@Slf4j
public class MemberController {
	
	private SignService service;
	private MemberService mservice;
	private PasswordEncoder pw;
	
	//회원페이지
	@GetMapping("/main")
	public void memberPage() {
		log.info("=====회원 페이지=====");
	}
	
	//비밀번호 변경
	@ResponseBody
	@PostMapping("/changeUser_pw")
	public void changeUser_pw(MemberVO member) {
		
		//전달받은 비밀번호를 암호화하고 저장
		MemberVO mem = new MemberVO();
		mem.setUser_id(member.getUser_id());
		mem.setUser_pw(pw.encode(member.getUser_pw()));
		mem.setUser_name(member.getUser_name());
		service.updateUser_pw(mem);
		
		log.info("=====회원 페이지: 비밀번호 변경=====");
	}
	
	//문의내역 조회
	@GetMapping("/requestList")
	public void requestList(@RequestParam("user_id") String user_id, Model model, Criteria cri) {
		log.info("=====회원 페이지: 문의 내역=====");
		
		//오늘날짜구하기
		Date now = new Date();
		model.addAttribute("now", now);
		
		//전달받은 user_id로 조회
		model.addAttribute("list", mservice.requestList(user_id,cri));
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(mservice.requestCount(user_id)); //데이터 개수를 전달
	    
	    model.addAttribute("pageMaker", pageMaker);
		
	}
	
	//문의내역 삭제
	@ResponseBody
	@PostMapping("/requestList/selectDelete")
	public void selectDelete(@RequestParam(value="chbox[]") List<String> chArr) {
		
		Long grpnum;
		
		for(String i : chArr) {   
			grpnum = Long.parseLong(i);
			mservice.requestDelete(grpnum); //문의글 삭제
			log.info("=====회원페이지: "+grpnum+"번 문의글 삭제=====");
		}
	}
	
	
}
