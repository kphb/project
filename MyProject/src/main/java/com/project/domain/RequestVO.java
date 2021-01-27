package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RequestVO {
	
	private Long rnum; //요청글 번호
	private String title; //요청글 제목
	private String content; //요청글 내용
	private String user_id; //요청글 작성자(회원id)
	private Date regDate; //요청글 작성날짜
	
	private Long grpnum; //글의 그룹번호(부모값, 원글이면 본인값=rnum)
	private Long grpord; //그룹내의 순서(부모의 자식값)
	private Long depth; //답글의 답글일수록 값이 커짐

}
