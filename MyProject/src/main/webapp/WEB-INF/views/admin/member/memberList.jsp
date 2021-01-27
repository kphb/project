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
#delBtn {float: right; margin-bottom: 10px;}
 #paging {text-align: center;}
 
</style>

<title>관리자 페이지</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

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
			<h3>회원 정보</h3>
			<hr>
			<h5>회원정보를 삭제해도 해당 회원의 추천이나 Q&A는 삭제되지 않습니다</h5>
			<hr>
				<div id="board">
				
					<div id="delBtn">
						<button type="button" id="selectDeleteBtn" class="btn">삭제</button>
					</div>
				
					<table class="table table-bordered table-hover">
						<thead>
							<tr class="active">
								<th><input type="checkbox" id="allCheck"></th>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이름</th>
								<th>가입일</th>
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
							<c:forEach items="${member}" var="member">
							
								<!-- 회원권한인 사용자만 출력하고 삭제할 수 있도록 함 -->
								<c:if test="${member.auth eq 'ROLE_MEMBER'}">
									<tr>
										<td><input type="checkbox" id="selectCheck" data-id="${member.user_id}"></td>
										<td>
											<c:out value="${member.user_id}" />
										</td>
										<td>
											<c:out value="${member.user_pw}" />
										</td>
										<td>
											<c:out value="${member.user_name}" />
										</td>
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}" />
										</td>
									</c:if>
							</c:forEach>
						</tbody>
						
						<script>
							//게시글 개별선택하면 allCheck의 체크해제
							$("input#selectCheck").click(function () {
								$("#allCheck").prop("checked", false);
							})
							
							//선택한 회원 삭제		
							$("#selectDeleteBtn").click(function () {
								var confirm_val = confirm("정말 삭제하시겠습니까?");
								
								if(confirm_val){
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';

									var checkArr = new Array();

									$("input#selectCheck:checked").each(function () {
										checkArr.push($(this).attr("data-id"));
									});

									$.ajax({
										url: "/admin/member/memberList/remove",
										type: "post",
										data: { chbox: checkArr },
										beforeSend: function (xhr) {
											xhr.setRequestHeader(header, token);
										},
										success: function () {
											location.href = "/admin/member/memberList";
										}
									})
								}
							})
						</script>

					</table>
				</div>
				
				<div id="paging">
					<ul class="pagination">
						<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.prev}">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageMaker.startPage-1}"/>'
									aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>

						<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageNum}"/>'>${pageNum}
								</a>
							</li>
						</c:forEach>

						<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageMaker.endPage+1}"/>' aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
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