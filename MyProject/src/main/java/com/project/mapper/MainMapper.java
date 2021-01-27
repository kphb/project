package com.project.mapper;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;

public interface MainMapper {
	
	//데이터조회(검색+페이징)
	public List<AdminVO> selectList(Criteria cri);
	
	//각 데이터 개수(remove='n'인 것만)
	public int listCnt(Criteria cri);

}
