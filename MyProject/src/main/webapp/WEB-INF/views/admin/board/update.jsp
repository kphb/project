<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.select_img img {width: 200px; height: auto;}
#updateBtn {text-align: center;}
</style>

<title>관리자 페이지</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resources/page-style.css">

<!-- ckeditor cdn -->
<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>

<script type="text/javascript">

	$(document).ready(function () {
		
		//입력값이 공백이면 경고창 띄우기
		$("#submit").click(function () {
			var title = $("#title").val();
			var writer = $("#writer").val();

			if (title == "") {
				alert("제목을 입력해주세요");
				return false; //해당 페이지에 그대로
			}
			else if (writer == "") {
				alert("작성자를 입력해주세요");
				return false;
			}
		})
	})

</script>


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
			<h3>게시글 수정</h3>
			<hr>
			<form action="/admin/board/update" method="post" enctype="multipart/form-data">
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="amount" value="${cri.amount}">
				<input type="hidden" name="type" value="${cri.type}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
			
				<div class="form-inline form-group">
					<label>번호</label>
					<input type="text" name="bnum" value="${board.bnum}" class="form-control" readonly>
				</div>

				<div class="form-inline form-group">
					<label>지역</label>
					<select name="area" class="form-control">
						<option>${board.area}</option>
						<option>서울</option>
						<option>부산</option>
						<option>대구</option>
						<option>인천</option>
						<option>광주</option>
						<option>대전</option>
						<option>울산</option>
						<option>경기</option>
						<option>강원</option>
						<option>충청</option>
						<option>전라</option>
						<option>경상</option>
						<option>제주</option>
					</select>
				</div>

				<div class="form-inline form-group">
					<label>기간</label>
					<input type="date" name="startDate" value="${board.startDate}" class="form-control">
					~ <input type="date" name="endDate" value="${board.endDate}" class="form-control">
				</div>

				<div class="form-group">
					<label>제목</label>
					<input type="text" name="title" value="${board.title}" id="title" class="form-control">
				</div>

				<div class="form-group">
					<label>내용</label>
					<textarea rows="10" name="content" id="content" class="form-control">
			${board.content}
		</textarea>

					<!-- ck에디터 적용 -->
					<script>
						var ckeditor_config = {
							resize_enaleb: false,
							enterMode: CKEDITOR.ENTER_BR,
							shiftEnterMode: CKEDITOR.ENTER_P,
							filebrowserUploadUrl: "/admin/ckUpload"
						};

						//textarea id를 ck에디터로 교체
						//토큰값 전달
						CKEDITOR.replace("content", 
							{filebrowserUploadUrl:'<c:url value="/admin/ckUpload" />?${_csrf.parameterName}=${_csrf.token}'});
					</script>
				</div>

				<div class="form-group">
					<label>작성자</label>
					<div class="form-control">${board.writer}</div>
				</div>

				<div class="form-group">
					<label>이미지</label>
					<input type="file" accept=".jpg, .png" name="file" id="file">
					<!-- jpg, png 파일 확장자만 선택가능 -->

					<div class="select_img"><img src="${board.img}" />
						<input type="hidden" name="img" value="${board.img}" id="img">
						<input type="hidden" name="thumbImg" value="${board.thumbImg}" id="thumbImg">
					</div>

					<script>
						// 파일이 등록되면 
						$("#file").change(function () {
							//현재화면에서 어떤 이미지인지 볼 수 있도록 함
							if (this.files && this.files[0]) {
								//선택한 모든 파일을 나열하는 FileList객체

								var reader = new FileReader;
								//파일을 읽을 수 있도록 도와주는 객체

								reader.onload = function (i) {
									$(".select_img img").attr("src", i.target.result).width(200);
									//선택한 이미지의 크기
								}
								reader.readAsDataURL(this.files[0]);
								//DataURL형식으로 파일 읽기
							}
						});
					</script>

				</div>

				<div class="form-inline form-group">
					<label>등록날짜</label>
					<div class="form-control">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
					</div>
				</div>

				<div class="form-inline form-group">
					<label>수정날짜</label>
					<div class="form-control">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />
					</div>
				</div>

				<div id="updateBtn">
					<input type="submit" value="수정하기" id="submit" class="btn">
				</div>

			</form>
			
			<hr>
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