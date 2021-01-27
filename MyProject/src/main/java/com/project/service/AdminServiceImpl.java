package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.MemberVO;
import com.project.domain.RecommendVO;
import com.project.domain.RequestVO;
import com.project.mapper.AdminMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{
	
	private AdminMapper mapper;

	@Override
	public void insert(AdminVO board) {
		mapper.insert(board);
	}
	
	public List<AdminVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int countList() {
		return mapper.countList();
	}
	
	@Override
	public int countSearch(Criteria cri) {
		return mapper.countSearch(cri);
	}
	
	@Override
	public AdminVO selectOne(Long bnum) {
		return mapper.selectOne(bnum);
	}

	@Override
	public void update(AdminVO board) {
		mapper.update(board);
	}

	@Override
	public List<AdminVO> removeList() {
		return mapper.removeList();
	}

	@Override
	public void updateY(Long bnum) {
		mapper.updateY(bnum);
	}

	@Override
	public void updateN(Long bnum) {
		mapper.updateN(bnum);
	}
	
	@Override
	public void delete(Long bnum) {
		mapper.delete(bnum);
	}

	@Override
	public boolean plusCnt(Long bnum) {
		return mapper.plusCnt(bnum);
	}

	@Override
	public void rec_insert(RecommendVO rec) {
		mapper.rec_insert(rec);
	}
	
	@Override
	public RecommendVO rec_check(RecommendVO rec) {
		return mapper.rec_check(rec);
	}

	@Override
	public int rec_count(Long bnum) {
		return mapper.rec_count(bnum);
	}

	@Override
	public void deleteRec(Long bnum) {
		mapper.deleteRec(bnum);
	}
	
	
	////회원 관련////
	
	@Override
	public int memberCount() {
		return mapper.memberCount();
	}
	
	@Override
	public List<MemberVO> memberList() {
		return mapper.memberList();
	}

	@Override
	public List<MemberVO> memberListWithPaging(Criteria cri) {
		return mapper.memberListWithPaging(cri);
	}

	@Override
	public void memberRemove(String user_id) {
		mapper.memberRemove(user_id);
	}

	@Override
	public void autoRemove(String user_id) {
		mapper.autoRemove(user_id);
	}

	@Override
	public List<RequestVO> requestList(Criteria cri) {
		return mapper.requestList(cri);
	}
	
	@Override
	public int requestCount() {
		return mapper.requestCount();
	}

	@Override
	public void insertRequest(RequestVO request) {
		mapper.insertRequest(request);
	}

	@Override
	public void insertResponse(RequestVO request) {
		mapper.insertResponse(request);
	}

	@Override
	public void updateResponse(Long grpnum) {
		mapper.updateResponse(grpnum);
	}

	@Override
	public void updateResponseContent(RequestVO request) {
		mapper.updateResponseContent(request);
	}

	@Override
	public void deleteRequest(Long grpnum) {
		mapper.deleteRequest(grpnum);
	}

	@Override
	public void deleteResponse(Long rnum) {
		mapper.deleteResponse(rnum);
	}



}
