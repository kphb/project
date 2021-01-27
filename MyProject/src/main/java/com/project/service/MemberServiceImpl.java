package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.Criteria;
import com.project.domain.RequestVO;
import com.project.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper mapper;

	@Override
	public List<RequestVO> requestList(String user_id, Criteria cri) {
		return mapper.requestList(user_id,cri);
	}

	@Override
	public int requestCount(String user_id) {
		return mapper.requestCount(user_id);
	}

	@Override
	public void requestDelete(Long grpnum) {
		mapper.requestDelete(grpnum);
	}

}
