<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<ul class="board-aside">
	<li><h4><b>게시글</b></h4></li>
  <li><a href="/admin/board/insert">게시글 등록</a></li>
  <li><a href="/admin/board/getList">게시글 목록</a></li>
  <li><a href="/admin/board/removeList">삭제 게시글</a></li>
</ul>
<hr>
<ul class="board-aside">
	<li><h4><b>회원</b></h4></li>
  <li><a href="/admin/member/memberList">회원 정보</a></li>
  <li><a href="/admin/member/request">Q&A</a></li>
</ul>

</body>
</html>