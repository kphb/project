package com.project.mapper;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.MemberVO;
import com.project.domain.RecommendVO;
import com.project.domain.RequestVO;

public interface AdminMapper {
	
	//데이터 생성
	public void insert(AdminVO board);
	
	//삭제여부(remove)가 'n'인 데이터 전체 조회(페이징)
	public List<AdminVO> getListWithPaging(Criteria cri);
	
	//전체 데이터 개수 조회
	public int countList();
	
	//검색 데이터 개수
	public int countSearch(Criteria cri);
	
	//데이터 한개 조회
	public AdminVO selectOne(Long bnum);
	
	//데이터 수정
	public void update(AdminVO board);
	
	//삭제여부(remove)가 'y'인 데이터 전체 조회
	public List<AdminVO> removeList();
	
	//삭제여부(remove)를 'y'로 변경
	public void updateY(Long bnum);
	
	//삭제여부(remove)를 'n'로 변경
	public void updateN(Long bnum);
	
	//데이터 삭제
	public void delete(Long bnum);
	
	//조회수 증가
	public boolean plusCnt(Long bnum);
	
	//게시글 추천
	public void rec_insert(RecommendVO rec);
	
	//각 게시글 추천 여부
	public RecommendVO rec_check(RecommendVO rec);
	
	//게시글 추천수
	public int rec_count(Long bnum);
	
	//추천 데이터 삭제(게시글 삭제될 때)
	public void deleteRec(Long bnum);
	
	
	////회원 관련////

	//회원 전체 데이터 개수 조회
	public int memberCount();
	
	//회원정보 조회하기
	public List<MemberVO> memberList();
	
	//회원정보 조회하기(id내림차순으로)
	public List<MemberVO> memberListWithPaging(Criteria cri);

	//회원탈퇴
	public void memberRemove(String user_id);
	
	//회원탈퇴(user_id연결)
	public void autoRemove(String user_id);
		
	//요청글 전체조회
	public List<RequestVO> requestList(Criteria cri);
	
	//요청글 데이터 개수
	public int requestCount();
	
	//요청글 작성
	public void insertRequest(RequestVO request);
	
	//요청글 답변
	public void insertResponse(RequestVO request);
	
	//요청글 답변(답변추가할때마다 grpord변경)
	public void updateResponse(Long grpnum);
	
	//요청글 답변수정
	public void updateResponseContent(RequestVO request);
	
	//요청글 삭제
	public void deleteRequest(Long grpnum);
	
	//답변 삭제
	public void deleteResponse(Long rnum);
	
	
}
