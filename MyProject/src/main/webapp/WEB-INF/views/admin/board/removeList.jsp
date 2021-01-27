<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
h5 {text-align: center;}
#delBtn,#resBtn {float: right;}
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
			<h3>삭제 게시글</h3>

			<hr>

			<h5>게시글을 조회하려면 복원하세요</h5>
			<h5>여기서 게시글을 삭제하면 다시 조회할 수 없습니다</h5>

			<hr>

			<div id="board">

				<div id="delBtn">
					<button type="button" id="selectDeleteBtn" class="btn btn-link btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
					</button>

					<script>
						//선택한 게시글 삭제
						$("#selectDeleteBtn").click(function () {
							var confirm_val = confirm("정말 삭제하시겠습니까?");

							if (confirm_val) {
								var header = '${_csrf.headerName}'; 
								var token = '${_csrf.token}';
								
								var checkArr = new Array();

								$("input#selectCheck:checked").each(function () {
									checkArr.push($(this).attr("data-bnum"));
								});

								$.ajax({
									url: "/admin/getList/selectDelete2",
									type: "post",
									data: { chbox: checkArr },
									beforeSend: function(xhr){
										xhr.setRequestHeader(header, token);
									},
									success: function () {
										location.href = "/admin/board/removeList";
									}
								})
							}
						})
					</script>
				</div>

				<div id="resBtn">
					<button type="button" id="selecRestoreBtn" class="btn btn-link btn-sm">
						<span class="glyphicon glyphicon-refresh" aria-hidden="true">복원</span>
					</button>

					<script>
						//선택한 게시글 복원
						$("#selecRestoreBtn").click(function () {
							var header = '${_csrf.headerName}'; 
							var token = '${_csrf.token}';
							
							var checkArr = new Array();

							$("input#selectCheck:checked").each(function () {
								checkArr.push($(this).attr("data-bnum"));
							});

							$.ajax({
								url: "/admin/getList/selectRestore",
								type: "post",
								data: { chbox: checkArr },
								beforeSend: function(xhr){
									xhr.setRequestHeader(header, token);
								},
								success: function () {
									location.href = "/admin/board/removeList";
								}
							})
						})
					</script>
				</div>

				<table class="table table-striped table table-bordered">
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck">번호</th>
							<th>지역</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
							<th>복원</th>
							<th>삭제</th>
						</tr>
					</thead>

					<div>
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
					</div>

					<tbody>
						<c:forEach items="${list}" var="board">
							<tr>
								<td>
									<input type="checkbox" id="selectCheck" data-bnum="${board.bnum}">
									<c:out value="${board.bnum}" />
								</td>
								<td>
									<c:out value="${board.area}" />
								</td>
								<td>
									<c:out value="${board.title}" />
								</td>
								<td>
									<c:out value="${board.writer}"></c:out>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />
								</td>
								<td>
									<div>
										<button type="button" id="res_${board.bnum}_btn" data-bnum="${board.bnum}"
											class="btn btn-info btn-sm">복원</button>

										<script>
											//게시글 복원
											$("#res_${board.bnum}_btn").click(function () {
												var header = '${_csrf.headerName}'; 
												var token = '${_csrf.token}';
												
												var checkArr = new Array();

												checkArr.push($(this).attr("data-bnum"));

												$.ajax({
													url: "/admin/getList/selectRestore",
													type: "post",
													data: { chbox: checkArr },
													beforeSend: function(xhr){
														xhr.setRequestHeader(header, token);
													},
													success: function () {
														location.href = "/admin/board/removeList";
													}
												})
											})
										</script>
									</div>
								</td>
								<td>
									<div>
										<button type="button" id="del_${board.bnum}_btn" data-bnum="${board.bnum}"
											class="btn btn-danger btn-sm">삭제</button>

										<script>
											//게시글 삭제
											$("#del_${board.bnum}_btn").click(function () {
												var confirm_val = confirm("정말 삭제하시겠습니까?");

												if (confirm_val) {
													var header = '${_csrf.headerName}'; 
													var token = '${_csrf.token}';
													
													var checkArr = new Array();

													checkArr.push($(this).attr("data-bnum"));

													$.ajax({
														url: "/admin/getList/selectDelete2",
														type: "post",
														data: { chbox: checkArr },
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
														},
														success: function () {
															location.href = "/admin/board/removeList";
														}
													})
												}
											})
										</script>
									</div>
								</td>
						</c:forEach>
					</tbody>

					<div>
						<script>
							//게시글 개별선택하면 allCheck의 체크해제
							$("input#selectCheck").click(function () {
								$("#allCheck").prop("checked", false);
							})
						</script>
					</div>

				</table>
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