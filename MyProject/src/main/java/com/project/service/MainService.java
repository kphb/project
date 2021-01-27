package com.project.service;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;

public interface MainService {

	//각 데이터 개수(remove='n'인 것만)
	public int listCnt(Criteria cri);	
	
	//데이터조회(검색+페이징)
	public List<AdminVO> selectList(Criteria cri);

}
