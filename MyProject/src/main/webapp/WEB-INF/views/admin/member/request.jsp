<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
 h5{text-align: center;}
 #divSelectDeleteBtn {float: right; margin-bottom: 10px;}
 div#content, div#response, div#updateResponse{display: none;}
 .spanBtn{display: inline-block;}
 #paging {text-align: center;}
</style>

<title>관리자 페이지</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<link rel="stylesheet" href="/resources/page-style.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


</head>
<body>
<div id="root">
	<header id="header">
		<div>
			<%@ include file="../include/header.jsp" %>
		</div>
	</header>

	<nav id="nav">
		<div>
			<%@ include file="../include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
		<aside>
			<%@ include file="../include/aside.jsp" %>
		</aside>
		<div id="container_box">
			 <h3>Q&A</h3>
			 <hr>
			 <h5>내용을 보려면 제목을 클릭하세요</h5>
			 <h5>원글을 삭제하면 답변도 삭제됩니다</h5>
			 <h5>회원이 탈퇴해도 글은 남아있지만 더이상 답변할 수 없습니다</h5>
			 <hr>
			 
		 	 <div id="board">
		 	 	<div id="divSelectDeleteBtn">
			 	 	<button type="button" id="selectDeleteBtn" class="btn btn-link btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
					</button>
				</div>
		 	 	
				<table class="table table-bordered table-hover">
					<thead>
						<tr class="active">
							<th><input type="checkbox" id="allCheck"></th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록날짜</th>
						</tr>
					</thead>
					
					<script>
						//게시글 전체선택
						$("#allCheck").click(function () {
							if ($("#allCheck").prop("checked")) {
								$("input#selectCheck").prop("checked", true);
							} else {
								$("input#selectCheck").prop("checked", false);
							}
						})
					</script>

					<tbody>
						<c:forEach items="${request}" var="request">
							<tr>
								
								<td>
									<input type="checkbox" id="selectCheck" data-rnum="${request.rnum}" data-grpnum="${request.grpnum}">
								</td>
								<td>
									<a id="title_${request.rnum}_btn">${request.title}</a>
									
									<fmt:formatDate pattern="yyyy-MM-dd" value="${request.regDate}" var="a" />
									<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" var="b" />
									<c:if test="${a eq b}">
										<span class="label label-primary">new</span>
									</c:if>
									
									<div id="content" class="content_${request.rnum}">
									
										 <br><b>내용</b><br>
										 <span id="${request.rnum}_content">
											 <textarea rows="4" cols="80" readonly>${request.content}</textarea>
										 </span>
										
										<c:if test="${request.grpord == 0}">
											<button type="button" id="response_${request.rnum}_btn" class="btn">답변하기</button>
										</c:if>
										
										<div id="response" class="response_${request.rnum}">
											<input type="hidden" id="response_${request.rnum}_grpnum" value="${request.grpnum}">
											<input type="hidden" id="response_${request.rnum}_title" value="RE: ${request.title}">
											<input type="hidden" id="response_${request.rnum}_user_id" value="${request.user_id}">
											<textarea rows="4" cols="80" id="response_${request.rnum}_content"></textarea>
											
											<button type="button" id="submit_${request.rnum}_btn" class="btn">등록</button>
											<button type="button" id="reset_${request.rnum}_btn" class="btn">취소</button>
										</div>
										
										<c:if test="${request.grpord > 0}">
											<button type="button" id="update_${request.rnum}_btn" class="btn">수정하기</button>
										</c:if>
										
										 <div id="updateResponse" class="updateResponse_${request.rnum}">
										 	<input type="hidden" id="updateResponse_${request.rnum}_rnum" value="${request.rnum}">
										 	<textarea rows="4" cols="80" id="updateResponse_${request.rnum}_content">${request.content}</textarea>
										 	
										 	<button type="button" id="updateSubmit_${request.rnum}_btn" class="btn">수정</button>
											<button type="button" id="updateReset_${request.rnum}_btn" class="btn">취소</button>
										 </div>
										
									</div>
									
									<script>
										//게시글 개별선택하면 allCheck의 체크해제
										$("input#selectCheck").click(function () {
											$("#allCheck").prop("checked", false);
										})
										
										//선택한 게시글 삭제
										$("#selectDeleteBtn").click(function(){
											var header = '${_csrf.headerName}'; 
											var token = '${_csrf.token}';
											
											var checkArr = new Array();

											$("input#selectCheck:checked").each(function () {
												
												if($("input[data-rnum='${request.rnum}']") == $("input[data-grpnum='${request.grpnum}']")){
													checkArr.push($(this).attr("data-grpnum"));
													
													$.ajax({
														url:"/admin/request/selectRequestDelete",
														type:"post",
														data: {chbox:checkArr},
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
														},
														success: function () {
															location.href = "/admin/member/request";
														}
													});
												}
												else{
													checkArr.push($(this).attr("data-rnum"));
													
													$.ajax({
														url:"/admin/request/selectRequestDelete",
														type:"post",
														data: {chbox:checkArr},
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
														},
														success: function () {
															location.href = "/admin/member/request";
														}
													});
												}
											});
										})
									</script>
									<script>
										$(document).ready(function(){
											
											var flag = true;
											
											//제목 클릭
											$("#title_${request.rnum}_btn").click(function(){
												if(flag){
													$("div.content_${request.rnum}").css("display","block");	
												}
												else{
													$("div.content_${request.rnum}").css("display","none");
												}
												flag = !flag;
											})
											
											//답변하기 클릭
											/* $("#response_${request.rnum}_btn").click(function(){
												$("div.response_${request.rnum}").css("display","block");
												$("#response_${request.rnum}_btn").css("display","none");
											}) */
											
											//취소버튼 클릭
											$("#reset_${request.rnum}_btn").click(function(){
												$("#response_${request.rnum}_btn").css("display","inline-block");
												$("div.response_${request.rnum}").css("display","none");
											})
											
											//등록버튼 클릭
											$("#submit_${request.rnum}_btn").click(function(){
												var header = '${_csrf.headerName}'; 
												var token = '${_csrf.token}';
												
												var grpnum = $("input#response_${request.rnum}_grpnum").val();
												var title = $("input#response_${request.rnum}_title").val();
												var content = $("textarea#response_${request.rnum}_content").val();
												var user_id = $("input#response_${request.rnum}_user_id").val();
												
												var data = {
														grpnum:grpnum,
														title:title,
														content:content,
														user_id:user_id
												};
												
												$.ajax({
													url: "/admin/member/request/insertResponse",
													type: "post",
													data: data,
													beforeSend: function(xhr){
														xhr.setRequestHeader(header, token);
													},
													success: function(){
														location.href = "/admin/member/request";
													}
												})
											})
											
											//수정하기 클릭
											$("#update_${request.rnum}_btn").click(function(){
												$("div.updateResponse_${request.rnum}").css("display","block");
												$("#${request.rnum}_content").css("display","none");
												$("#update_${request.rnum}_btn").css("display","none");
											})
											
											//취소버튼 클릭
											$("#updateReset_${request.rnum}_btn").click(function(){
												$("#update_${request.rnum}_btn").css("display","inline-block");
												$("#${request.rnum}_content").css("display","block");
												$("div.updateResponse_${request.rnum}").css("display","none");
											})
											
											//수정버튼 클릭
											$("#updateSubmit_${request.rnum}_btn").click(function(){
												var header = '${_csrf.headerName}'; 
												var token = '${_csrf.token}';
												
												var rnum = $("input#updateResponse_${request.rnum}_rnum").val();
												var content = $("textarea#updateResponse_${request.rnum}_content").val();
												
												var data = {
														rnum:rnum,
														content:content
												};
												
												$.ajax({
													url: "/admin/member/request/updateResponse",
													type: "post",
													data: data,
													beforeSend: function(xhr){
														xhr.setRequestHeader(header, token);
													},
													success: function(){
														location.href = "/admin/member/request";
													}
												})
											})
										})
									</script>
									
								</td>
								<td>
									<c:choose>
										<c:when test="${request.grpord > 0}">
											관리자
										</c:when>
										<c:when test="${request.grpord == 0}">
											<c:out value="${request.user_id}" />
											
											<script type="text/javascript">
												$("#response_${request.rnum}_btn").click(function(){
													$.ajax({
														url: "/admin/member/request/check_id",
														type: "get",
														dataType: "json",
														data: {"user_id" : "${request.user_id}"},
														success: function(data){
															console.log(data);
															if(data == true){
																$("div.response_${request.rnum}").css("display","block");
																$("#response_${request.rnum}_btn").css("display","none");
															}
															else if(data == false){
																alert("탈퇴한 회원입니다")
															}
														}
													})
												})
											</script>
											
										</c:when>
									</c:choose>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${request.regDate}" />
								</td>
							<tr>
						</c:forEach>
					</tbody>

				</table>
				
				<div id="paging">
					<ul class="pagination">
						<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.prev}">
							<li>
								<a href='<c:url value="/admin/member/request?page=${pageMaker.startPage-1}"/>'
									aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>

						<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							<li>
								<a href='<c:url value="/admin/member/request?page=${pageNum}"/>'>${pageNum}
								</a>
							</li>
						</c:forEach>

						<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li>
								<a href='<c:url value="/admin/member/request?page=${pageMaker.endPage+1}"/>' aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				</div>
				
			</div>
			
		</div>
	</section>
	
	<footer id="footer">
		<div>
			<%@ include file="../include/footer.jsp" %>
		</div>
	</footer>

</div>

</body>
</html>