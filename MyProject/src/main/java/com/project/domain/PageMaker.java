package com.project.domain;


import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageMaker { //페이징 처리

    private Criteria cri;
    private int totalCount; //총 게시글 수
    private int startPage; //시작 페이지
    private int endPage; //끝 페이지
    private boolean prev; //이전
    private boolean next; //다음
    private int displayPageNum = 5; //화면에 보여질 페이지 번호의 갯수

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }

    private void calcData() {
    	
        //끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
        
        //시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 번호의 갯수) + 1
        startPage = (endPage - displayPageNum) + 1;
        if(startPage <= 0) startPage = 1;
        
        //마지막 페이지 번호 = 총 게시글 수 / 한 페이지당 보여줄 게시글의 갯수
        int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getAmount()));
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }
 
        //이전 버튼 생성 여부 = 시작 페이지 번호 == 1 ? false : true
        prev = startPage == 1 ? false : true;
        
        //다음 버튼 생성 여부 = 끝 페이지 번호 * 한 페이지당 보여줄 게시글의 갯수 < 총 게시글의 수 ? true: false
        next = endPage * cri.getAmount() < totalCount ? true : false;
        
    }
    
    //UriComponents는 URI를 생성해주는 클래스
    public String makeQuery(int page) {
    	
     UriComponents uriComponents =
       UriComponentsBuilder.newInstance()
       .queryParam("page", page)
       .queryParam("amount", cri.getAmount())
       .build();
       
     return uriComponents.toUriString();
    }
    
    public String makeSearch(int page) {
    	
        UriComponents uriComponents =
          UriComponentsBuilder.newInstance()
          .queryParam("page", page)
          .queryParam("amount", cri.getAmount())
          .queryParam("type", cri.getType())
          .queryParam("keyword", cri.getKeyword())
          .build();
          
        return uriComponents.toUriString();
    }
    
    public String makeArraySearch(int page) {
    	
        UriComponents uriComponents =
          UriComponentsBuilder.newInstance()
          .queryParam("page", page)
          .queryParam("amount", cri.getAmount())
          .queryParam("array", cri.getArray())
          .queryParam("type", cri.getType())
          .queryParam("keyword", cri.getKeyword())
          .build();
          
        return uriComponents.toUriString();
    }

}
