package com.project.domain;

import lombok.Data;

@Data
public class RecommendVO {
	
	private Long bnum; //AdminVO의 게시글번호
	private String user_id; //MemberVO의 id
}
