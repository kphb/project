package com.project.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.PageMaker;
import com.project.domain.RecommendVO;
import com.project.domain.RequestVO;
import com.project.service.AdminService;
import com.project.service.SignService;
import com.project.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Slf4j
public class AdminController {
	
	private AdminService service;
	private SignService sservice;
	//회원id있는지 찾아보려고 아이디중복확인 메소드 이용
	
	//@Autowired와 유사
	//빈의 이름를 사용해서 주입할 빈 객체를 찾음(servlet-context.xml에서 설정)
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//관리자페이지 메인
	@GetMapping("/main")
	public void main() {
		log.info("=====관리자 메인페이지=====");
	}
	
	//관리자페이지 데이터등록
	@GetMapping("/board/insert")
	public void insert() {
		log.info("=====관리자 게시글등록 페이지=====");
	}
	
	//관리자페이지 데이터등록
	@PostMapping("/board/insert")
	public String insert2(AdminVO admin, MultipartFile file, String test) throws Exception {
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		//resources폴더에 imgUpload폴더 생성, 파일이 저장될 기본폴더
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		//위의 폴더를 기준으로 연웡일 폴더 생성
		
		String fileName = null;
		
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
		//파일 인풋박스에 첨부된 파일이 있다면(=첨부된 파일 이름이 있다면)
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			admin.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			//파일경로+파일이름 저장
			admin.setThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			//썸네일파일경로+파일이름 저장
		} else {
			admin.setImg(File.separator + "image" + File.separator + "none.jpg");
			admin.setThumbImg(File.separator + "image" + File.separator + "none.jpg");
			//fileName = uploadPath + File.separator + "images" + File.separator + "none.png"
			//이미지 첨부안하면 해당 값이 데이터에 저장
		}

		//파일용 인풋박스에 등록된 파일의 정보를 가져오고, 
		//UploadFileUtils.java를 통해 폴더를 생성한 후 원본 파일과 썸네일을 저장한 뒤, 
		//이 경로를 데이터 베이스에 전달하기 위해 AdminVO에 입력(set)
		System.out.println("admin객체: "+admin);
		System.out.println("파일정보: "+file);
		service.insert(admin);
		//insert.jsp에서 넘어온 데이터를 insert메소드의 파라미터로 전달
		
		log.info("=====관리자 게시글 등록=====");
		
		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//ck에디터에서 파일 업로드
	@PostMapping("/admin/ckUpload")
	public void postCKEditorImgUpload(HttpServletResponse res, @RequestParam MultipartFile upload) throws Exception {
		System.out.println("ck에디터 진입");
	 
		 //랜덤문자 생성
		 UUID uuid = UUID.randomUUID();
		 
		 OutputStream out = null;
		 PrintWriter printWriter = null;
		   
		 //인코딩
		 res.setCharacterEncoding("utf-8");
		 res.setContentType("text/html;charset=utf-8");
		 
		 try {
		  
			  String fileName = upload.getOriginalFilename(); //파일이름 가져오기
			  byte[] bytes = upload.getBytes();
			  
			  //업로드 경로
			  String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uuid + "_" + fileName;
			  //파일명이 똑같을 경우를 대비해 uuid사용
			  
			  //경로에 파일저장
			  out = new FileOutputStream(new File(ckUploadPath));
			  out.write(bytes);
			  out.flush(); //out에 저장된 데이터를 전송하고 초기화
			  
			  String fileUrl = "/ckUpload/" + uuid + "_" + fileName; //파일 업로드했을때 url
			  printWriter = res.getWriter();
			  
			  //업로드시 메시지출력(json형태여야 서버에 전송됨)
			  printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
			  
			  log.info("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
			 
			  printWriter.flush();
			  
			  log.info("=====관리자 게시글 등록(ck에디터에서 파일업로드)=====");
		 } 
		 
		 catch (IOException e) {
			 e.printStackTrace(); 
		 } 
		 
		 finally {
			  try {
			   if(out != null) { out.close(); }
			   if(printWriter != null) { printWriter.close(); }
			  } catch(IOException e) { e.printStackTrace(); }
		 }	 
		 return;
	}
	
	//관리자페이지 삭제여부(remove)가 'n'인 전체데이터 조회(페이징)
	@GetMapping("board/getList")
	public void getList(Model model, Criteria cri) {
		log.info("=====관리자 전체게시글 조회=====");
		log.info("=====현재페이지: "+cri.getPage()+"페이지=====");
		
		//오늘날짜구하기
		Date now = new Date();
		model.addAttribute("now", now);
		log.info("=====오늘날짜: " +now+"=====");
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    //pageMaker.setTotalCount(service.countList()); //총 데이터 개수를 전달
	    pageMaker.setTotalCount(service.countSearch(cri)); //검색한 데이터 개수를 전달
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//관리자페이지 한개데이터 조회/수정
	@GetMapping({"/board/selectOne", "/board/update"})
	public void selectOne(@RequestParam("bnum") Long bnum, Model model, @ModelAttribute("cri") Criteria cri) {
		
		log.info("=====관리자 "+bnum+"번 게시글 조회/수정=====");
		
		service.plusCnt(bnum);
		//조회수+1
		
		model.addAttribute("board", service.selectOne(bnum));
		//model객체를 이용해 key값 board에 selectOne메소드 저장
		
		model.addAttribute("cri", cri);
		//페이징유지를 위해
	}
	
	//게시글 추천
	@ResponseBody
	@PostMapping(value="/selectOne/insertRec", produces="application/text; charset=utf8")
	public String insertRecommend(RecommendVO rec) {
		
		RecommendVO reco = new RecommendVO();
		reco.setBnum(rec.getBnum());
		reco.setUser_id(rec.getUser_id());
						
		if(service.rec_check(reco) == null) {
			service.rec_insert(rec);
			log.info("=====회원id '"+rec.getUser_id()+"'의 게시글 "+rec.getBnum()+"번 추천=====");
			return "추천완료";
		}
		else {
			return "이미 추천하였습니다";
		}
	}
	
	//게시글 추천수
	@ResponseBody
	@GetMapping("/selectOne/countRec")
	public int countRecommend(@RequestParam("bnum") Long bnum) {
		int count = service.rec_count(bnum);
		log.info("=====게시글 "+bnum+"번 추천수:"+count+"=====");
		return count;
	}

	//관리자페이지 데이터수정
	@PostMapping("board/update")
	public String update(AdminVO admin, MultipartFile file, HttpServletRequest req, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		
		//새로운 파일이 등록되었는지 확인
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			
		  //기존 파일을 삭제
//		  new File(uploadPath + req.getParameter("img")).delete();
//		  new File(uploadPath + req.getParameter("thumbImg")).delete();
		  
		  //새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  admin.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  admin.setThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } 
		else {  //새로운 파일이 등록되지 않았다면
		  //기존 이미지를 그대로 사용
		  admin.setImg(req.getParameter("img"));
		  admin.setThumbImg(req.getParameter("thumbImg"));
		 }
		
		service.update(admin);
		//update.jsp에서 넘어온 데이터를 update메소드의 파라미터로 전달
		
		log.info("=====관리자 게시글 수정=====");
		
		//리다이렉트시 각 정보 포함
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//관리자페이지 삭제여부(remove)가 'y'인 전체데이터 조회
	@GetMapping("board/removeList")
	public void removeList(Model model) {
		log.info("=====관리자 삭제게시글 조회=====");
		model.addAttribute("list", service.removeList());
		//model객체를 이용해 key값 list에 removeList메소드 저장
	}
	
	//관리자페이지 삭제여부를 'y'으로 변경
	@PostMapping("/board/updateY")
	public String updateY(@RequestParam("bnum") Long bnum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		service.updateY(bnum);
		//bnum을 이용해서 삭제여부 'y'로 변경
		
		log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'y'로 변경=====");
		
		//리다이렉트시 각 정보 포함
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//관리자페이지 선택한 게시글 삭제여부를 'y'으로 변경
	@ResponseBody
	@PostMapping("/getList/selectDelete")
	public void selectDelete(@RequestParam(value="chbox[]") List<String> chArr) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			service.updateY(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'y'로 변경=====");
		}
	}
	
	//관리자페이지 선택한 게시글 삭제여부를 'n'으로 변경(복원)
	@ResponseBody
	@PostMapping("/getList/selectRestore")
	public void selectRestore(@RequestParam(value="chbox[]") List<String> chArr) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			service.updateN(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'N'로 변경=====");
		}
	}
	
	//관리자페이지 선택한 게시글 데이터 삭제
	@ResponseBody
	@PostMapping("/getList/selectDelete2")
	public void selectDelete2(@RequestParam(value="chbox[]") List<String> chArr) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			service.deleteRec(bnum); //게시글의 추천데이터도 삭제
			service.delete(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제=====");
		}
	}
	
	/////회원 관련////
	
	//관리자페이지 회원정보 조회
	@GetMapping("/member/memberList")
	public void memberList(Model model, Criteria cri) {
		log.info("=====관리자: 회원정보 조회=====");
		log.info("=====현재페이지: "+cri.getPage()+"페이지=====");
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.memberCount()); //총 데이터 개수를 전달
		
		model.addAttribute("member", service.memberListWithPaging(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//관리자페이지 회원삭제
	@ResponseBody
	@PostMapping("/member/memberList/remove")
	public void memberListRemove(@RequestParam(value="chbox[]") List<String> chArr) {
		
		for(String i : chArr) {
			service.autoRemove(i); //연결된 user_id 먼저 삭제
			service.memberRemove(i); //user_id 삭제
			log.info("=====관리자: 회원id '"+i+"' 탈퇴=====");
		}
	}
	
	//관리자페이지 회원 등록요청 조회
	@GetMapping("/member/request")
	public void request(Model model, Criteria cri) {
		log.info("=====관리자: 등록요청 조회=====");
		log.info("=====현재페이지: "+cri.getPage()+"페이지=====");
		
		//오늘날짜구하기
		Date now = new Date();
		model.addAttribute("now", now);
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.requestCount()); //총 데이터 개수를 전달
		
		model.addAttribute("request", service.requestList(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//관리자페이지 회원 id 여부
	@ResponseBody
	@GetMapping("/member/request/check_id")
	public boolean check_id(String user_id) {
		return sservice.checkUser_id(user_id);
	}
	
	//관리자페이지 회원 등록요청 답글
	@ResponseBody
	@PostMapping("/member/request/insertResponse")
	public void insertResponse(RequestVO request) {
		
		service.updateResponse(request.getGrpnum()); //답글달때마다 grpord변경
		service.insertResponse(request); //답글달기
		
		log.info("=====관리자: "+request.getGrpnum()+"번 등록요청 답변완료=====");
	}
	
	//관리자페이지 회원 등록요청 답글수정
	@ResponseBody
	@PostMapping("/member/request/updateResponse")
	public void updateResponse(RequestVO request) {
		
		service.updateResponseContent(request); //답글수정
		
		log.info("=====관리자: "+request.getRnum()+"번 답변수정=====");
	}
	
	//관리자페이지 회원 선택한 요청글 삭제
	@ResponseBody
	@PostMapping("/request/selectRequestDelete")
	public void selectRequestDelete(@RequestParam(value="chbox[]") List<String> chArr) {
		
		Long rnum;
		Long grpnum;
		
		for(String i : chArr) {   
			rnum = Long.parseLong(i);
			grpnum = Long.parseLong(i);
			service.deleteRequest(grpnum); //답글달린 요청글 삭제
			service.deleteResponse(rnum); //답글삭제
			log.info("=====관리자: "+rnum+"번 요청글 삭제=====");
		}
	}
	
}
