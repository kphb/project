package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.domain.Criteria;
import com.project.domain.RequestVO;

public interface MemberMapper {
	
	//문의내역 조회
	public List<RequestVO> requestList(@Param("user_id") String user_id, @Param("cri") Criteria cri);
	
	//문의내역 데이터 개수
	public int requestCount(String user_id);
	
	//문의내역 삭제
	public void requestDelete(Long grpnum);

}
