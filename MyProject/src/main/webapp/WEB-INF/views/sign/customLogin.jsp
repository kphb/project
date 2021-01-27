<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>

<style type="text/css">
div#title{margin-top: 120px;}
ul{list-style: none;}
ul li{padding: 10px;}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
<div id="title" class="text-center">
<p><a href="/main/main">메인 페이지</a></p>
	<h1>로그인 페이지</h1>
	<h3><c:out value="${error}"/></h3>
</div>
<hr>
<form action="/login" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    
    <div id="form" class="text-center">
	    <ul>
		    <li>
		    	<p>아이디</p>
		        <input type="text" name="user_id">
		    </li>
		    <li>
		    	<p>비밀번호</p>
		        <input type="password" name="user_pw">
		    </li>
		    <li>
		    	<input type="checkbox" name="remember-me">자동로그인
		        <input type="submit" value="로그인" class="btn">
		    </li>
		    <hr>
		    <li>
		    	<p><a href="/sign/findPassword">비밀번호를 잊어버리셨나요?</a></p>
		    	<p><a href="/sign/signUp">회원가입</a></p>
		    </li>
	    </ul>
    </div>
   
</form>
</body>
</html>