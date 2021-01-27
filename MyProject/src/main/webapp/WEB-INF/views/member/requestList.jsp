<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 페이지</title>

<style type="text/css">
h5{text-align: center;}
div#board{width: 1000px; margin-left: 50px;}
#divSelectDeleteBtn {float: right; margin-bottom: 10px;}
div#content{display: none;}
div#paging{text-align: center;}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resources/page-style.css">

</head>

<body>
	<div id="root">
		<header id="header">
			<div>
				 <%@ include file="include/header.jsp" %>
			</div>
		</header>

		<nav id="nav">
			<div>
				<%@ include file="include/nav.jsp" %>
			</div>
		</nav>

		<section id="container">

			<aside>
				<%@ include file="include/aside.jsp" %>
			</aside>
									
			<div id="container_box">
				<hr>
				<h5>답변이 달린 문의글 삭제 시 답변도 같이 삭제됩니다</h5>
				<hr>
				<div id="board">
				
					<div id="divSelectDeleteBtn">
				 	 	<button type="button" id="selectDeleteBtn" class="btn btn-link btn-sm">
							<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
						</button>
					</div>
				
					<table class="table table-bordered">
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
							<c:forEach items="${list}" var="request">
								<tr>
									<td>
										<c:if test="${request.grpord == 0}">
											<input type="checkbox" id="selectCheck" data-grpnum="${request.grpnum}">
										</c:if>
									</td>
									
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
												
												checkArr.push($(this).attr("data-grpnum"));
												
												$.ajax({
													url:"/member/requestList/selectDelete",
													type:"post",
													data: {chbox:checkArr},
													beforeSend: function(xhr){
														xhr.setRequestHeader(header, token);
													},
													success: function () {
														location.href = "/member/requestList?user_id=<sec:authentication property='principal.username'/>";
													}
												});
											});
										})
									</script>
									
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
											
										</div>
										
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
					
					<sec:authentication property='principal.username' var="id"/>
					
					<div id="paging">
						<ul class="pagination">
							<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
							<c:if test="${pageMaker.prev}">
								<li>
									<a href='<c:url value="/member/requestList?user_id=${id}&page=${pageMaker.startPage-1}"/>'
										aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
	
							<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
								<li>
									<a href='<c:url value="/member/requestList?user_id=${id}&page=${pageNum}"/>'>${pageNum}
									</a>
								</li>
							</c:forEach>
	
							<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li>
									<a href='<c:url value="/member/requestList?user_id=${id}&page=${pageMaker.endPage+1}"/>' aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
						</ul>
					</div> <!-- paging -->
									
				</div> <!-- board -->
				
			</div> <!-- container_box -->

		</section> <!-- container -->

		<footer id="footer">
			<div>
				<%@ include file="include/footer.jsp" %>
			</div>
		</footer>

	</div>

</body>

</html>