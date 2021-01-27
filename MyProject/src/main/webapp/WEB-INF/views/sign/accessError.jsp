<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>접근이 거부되었습니다.</h2>
<h3><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h3>
</body>
</html>
