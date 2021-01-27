package com.project.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminVO {
	
	private Long bnum; //게시글 번호
	private String title; //게시글 제목
	private String content; //게시글 내용
	private String writer; //게시글 작성자
	private Date regDate; //게시글 등록날짜
	private Date updateDate; //게시글 수정날짜
	
	private String area; //지역
	private String startDate; //축제기간
	private String endDate; //축제기간
	
	private String img; //이미지
	private String thumbImg; //썸네일
	
	private String remove; //데이터 삭제여부
	
	private Long cnt; //조회수
	
	private Long rec; //count(r.bnum) as rec

}
