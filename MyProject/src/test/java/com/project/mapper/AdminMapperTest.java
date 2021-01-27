package com.project.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.RequestVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AdminMapperTest {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Test
	//데이터 생성 테스트
	public void insertTest() {
		AdminVO vo = new AdminVO();
		vo.setTitle("제목 테스트3");
		vo.setContent("내용 테스트3");
		vo.setWriter("작성자 테스트3");
		mapper.insert(vo);
		log.info("@@@@@생성@@@@@"+vo);
	}
	
	@Test
	//데이터 한개 조회 테스트
	public void selectOneTest() {
		AdminVO vo = new AdminVO();
		vo = mapper.selectOne(4L);
		log.info("@@@@@한개조회@@@@@"+vo);
	}
	
	@Test
	//데이터 수정 테스트
	public void updateTest() {
		AdminVO vo = new AdminVO();
		vo.setBnum(4L);
		vo.setTitle("제목 수정");
		vo.setContent("내용 수정");
		mapper.update(vo);
		log.info("@@@@@수정@@@@@"+vo);
	}
	
	@Test
	//데이터 삭제 테스트
	public void deleteTest() {
		mapper.delete(5L);
	}
	
	@Test
	//remove가 y인 데이터 전체 조회 테스트
	public void removeList() {
		mapper.removeList().forEach(i -> log.info("@@@@@remove=y@@@@@"+i));
	}
	
	@Test
	//remove를 y로 변경 테스트
	public void updateY() {
		mapper.updateY(6L);
	}
	
	@Test
	public void getList() {
		Criteria cri = new Criteria();
		mapper.getListWithPaging(cri).forEach(i -> log.info("@@@@@전체조회@@@@@"+i));
	}
	
	@Test
	public void insertResponse() {
		RequestVO vo = new RequestVO();
		vo.setTitle("답변제목");
		vo.setContent("답변내용");
		vo.setUser_id("aa");
		vo.setGrpnum(7L);
		mapper.insertResponse(vo);
		log.info("@@@@@등록요청답변@@@@@"+vo);
	}

}
