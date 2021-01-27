package com.project.domain;

import lombok.Data;

@Data
public class Criteria { //특정페이지 조회

	private int page; //현재 페이지
	private int amount; //한 페이지당 보여줄 게시글의 개수
	
	private String array; //정렬
	
	private String type; //검색조건
	private String keyword; //검색어
	
	public Criteria() { //기본 생성자
		this.page=1;
		this.amount=10;
	}
	
//	public Criteria(int page , int amount) {
//		this.page = page;
//		this.amount=amount;
//	}
	
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
            //페이지가 음수가 되면 1페이지로
        } else {
            this.page = page;
        }
    }
        public String[] getTypeArr() {
        	return type == null? new String[] {}: type.split("");
    }
}
