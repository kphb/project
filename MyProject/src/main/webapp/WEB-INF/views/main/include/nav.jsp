<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#logoutBtn{margin-bottom: 5px;}
</style>
</head>
<body>

<ul>
	
	 <sec:authorize access="isAnonymous()">
		<li><a href="/sign/customLogin">로그인</a></li>
		<li><a href="/sign/signUp">회원가입</a></li>
	 </sec:authorize>
	 
	 <h4>
		<sec:authorize access="isAuthenticated()">
			'<sec:authentication property='principal.username'/>'님 안녕하세요
		</sec:authorize>
	 </h4>
	 
	 <sec:authorize access="hasRole('ROLE_ADMIN')">
		<li><a href="/admin/main">관리자 페이지</a></li>
	 </sec:authorize>
	 	 	 
	 <sec:authorize access="hasRole('ROLE_MEMBER')">
		<li><a href="/member/main">회원 페이지</a></li>
	 </sec:authorize>
	
	 <sec:authorize access="isAuthenticated()">
	 	<li>
	 		<form action="/logout" method="post">
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			    <button class="btn btn-link" id="logoutBtn">로그아웃</button>
			</form>
	 	</li>
	 </sec:authorize>
</ul>
<hr>
</body>
</html>