package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.mapper.MainMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor	
public class MainServiceImpl implements MainService {
	
	private MainMapper mapper;

	@Override
	public int listCnt(Criteria cri) {
		return mapper.listCnt(cri);
	}

	@Override
	public List<AdminVO> selectList(Criteria cri) {
		return mapper.selectList(cri);
	}

}
