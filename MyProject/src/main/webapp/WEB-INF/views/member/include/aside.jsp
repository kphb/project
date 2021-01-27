<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
</head>
<body>

<ul class="board-aside">
  	<li><a href="/member/requestList?user_id=<sec:authentication property='principal.username'/>">문의 내역</a></li>
</ul>

</body>
</html>