<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/logout" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <button id="btn">로그아웃</button>
</form>
<script type="text/javascript">
	//로그아웃 페이지 접속 시 자동으로 버튼누름
	window.onload = function () {
		let btn = document.getElementById('btn').click();
	}
</script>
</body>
</html>