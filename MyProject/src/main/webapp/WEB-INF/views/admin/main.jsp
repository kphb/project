<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
 body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
 ul { padding:0; margin:0; list-style:none;  }
 a {  text-decoration: none; }

 div#root { width:90%; margin:0 auto; }
 
 header#header { font-size:60px; padding:20px 0; }
 header#header h1 a { color:#000; font-weight:bold; }
 
 nav#nav { padding:10px; text-align:right; }
 nav#nav ul li { display:inline-block; margin-left:10px; }

 section#container { padding:20px 0; }
 section#container::after { content:""; display:block; clear:both; }
 aside { float:left; width:200px; }
 div#container_box { float:right; width:calc(100% - 200px - 20px); }
 
 aside ul li { text-align:center; }
 aside ul li a { display:block; width:100%; padding:10px 0;}
 aside ul li a:hover { background:#eee; }
 
 footer#footer { background:#f9f9f9; padding:20px; }
 footer#footer ul li { display:inline-block; margin-right:10px; }
 
 #moveBtn{position:fixed; right: 3%; bottom: 5%;}
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


</head>
<body>
<div id="root">
	<header id="header">
		<div>
			<%@ include file="include/header.jsp" %>
		</div>
	</header>

	<nav id="nav">
		<div>
			<%@ include file="include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
		<aside>
			<%@ include file="include/aside.jsp" %>
		</aside>
		<div id="container_box">
			관리자 페이지
		</div>
	</section>
	
	<footer id="footer">
		<div>
			<%@ include file="include/footer.jsp" %>
		</div>
	</footer>
	
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

</div>

</body>
</html>