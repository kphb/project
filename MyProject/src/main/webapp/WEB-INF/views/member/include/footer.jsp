<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul>
	<li>사이트소개</li>
	<li>이용약관</li>
</ul>

<div id="moveBtn">
    <button type="button" id="upBtn" class="btn btn-lg">
        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
    </button>
    <script>
        $("#upBtn").click( function() {
            $('html, body').animate({scrollTop:0}, 400);
            return false;
        });
    </script>
</div>

</body>
</html>