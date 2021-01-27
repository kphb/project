package com.project.service;

import java.util.List;


import com.project.domain.Criteria;
import com.project.domain.RequestVO;

public interface MemberService {
	
	//문의내역 조회
	public List<RequestVO> requestList(String user_id, Criteria cri);
	
	//문의내역 데이터 개수
	public int requestCount(String user_id);
	
	//문의내역 삭제
	public void requestDelete(Long grpnum);

}
