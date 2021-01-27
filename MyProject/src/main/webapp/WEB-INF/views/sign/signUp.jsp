<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<style type="text/css">
div#title{margin-top: 70px;}
div#form{margin-left: 600px;}
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
	<h1>회원가입 페이지</h1>
</div>
<hr>
<form action="/sign/signUp" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<!-- 시큐리티 설정 후 post방식으로 전송시 토큰값을 전달하지 않으면 접근제한됨 -->
    
   <div id="form">
   	<ul>
	    <li>
	    	<p>아이디</p>
	        <input type="text" name="user_id" id="user_id" placeholder="아이디를 입력해주세요">
	        <button type="button" id="check_id" class="btn">중복확인</button>
	        
	        <input type="hidden" id="id_check" value="no">
	        <!-- 중복확인 여부를 위한 input태그 -->
			
			<script type="text/javascript">
				$("#check_id").click(function(){
					$.ajax({
						url: "/sign/check_id",
						type: "get",
						dataType: "json",
						data: {"user_id" : $("#user_id").val()},
						success: function(data){
							console.log(data);
							if(data == true){
								alert("이미 사용중인 아이디입니다")
								$("#user_id").val("");
								$("#user_id").focus();
							}
							else if(data == false){
								alert("사용가능한 아이디입니다")
								$("#id_check").attr("value","yes")
								//중복확인 후 사용가능한 아이디일 경우 속성값 변경
								$("#user_pw").focus();
							}
						}
					})
				})
			</script>
	    </li>
	  
	    <li>
	    	<p>비밀번호</p>
	        <input type="password" name="user_pw" id="user_pw" placeholder="비밀번호를 입력해주세요">
	    </li>
	    
	    <li>
	    	<p>비밀번호 확인</p>
			<input type="password" name="check_user_pw" placeholder="비밀번호를 입력해주세요">
			<button type="button" id="check_user_pw" class="btn">일치여부</button>
			
			<input type="hidden" id="pw_check" value="no">
	        <!-- 비밀번호 일치여부를 위한 input태그 -->
			
			<script type="text/javascript">
				$(document).on("click", "#check_user_pw", function(){
					var user_pw = $("input[name=user_pw]").val();
					var check_user_pw = $("input[name=check_user_pw]").val();
					if(user_pw == check_user_pw){
						alert("비밀번호가 일치합니다")
						$("#pw_check").attr("value","yes")
						//일치여부 확인 후 속성값 변경
					}
					else{
						alert("비밀번호가 불일치합니다")
						$("#pw_check").attr("value","no")
						//일치여부 확인 후 속성값 변경
					}
				})
			</script>
	    </li>
	    
	    <li>
	    	<p>이름</p>
	        <input type="text" name="user_name" id="user_name" placeholder="이름을 입력해주세요">
	    </li>
	    
	    <li>
	    	<p>유형</p>
	    	<input type="radio" name="auth" id="admin">관리자
	    	<input type="radio" name="auth" id="member">회원
	    	
	    	<script type="text/javascript">
	    	
	    		//관리자or회원 유형을 선택하면 value값 입력 
	    		$("input[name=auth]").change(function(){
	    			if($("#admin").prop("checked")){
	    				$("#admin").val("ROLE_ADMIN");
	    				$("#member").val("");
	    			}
	    			else if($("#member").prop("checked")){
	    				$("#member").val("ROLE_MEMBER");
	    				$("#admin").val("");
	    			}
	    		})
	    	</script>
	    </li>
	    
	    <li>
	    	<input type="submit" id="signUpBtn" value="가입하기" class="btn">
	    </li>
	    </ul>
	    
	    <script type="text/javascript">
		    	$("#signUpBtn").click(function(){
					
			   		if($("#user_id").val() == ""){
			   			alert("아이디를 입력해주세요")
			   			$("#user_id").focus();
			   			return false;
			   		}
			   		else if($("#user_pw").val() == "") {
			   			alert("비밀번호를 입력해주세요")
			   			$("#user_pw").focus();
			   			return false;
			   		}
			   		else if($("input[name=check_user_pw]").val() == "") {
			   			alert("비밀번호를 입력해주세요")
			   			$("input[name=check_user_pw]").focus();
			   			return false;
			   		}
			   		else if($("#user_name").val() == "") {
			   			alert("이름을 입력해주세요")
			   			$("#user_name").focus();
			   			return false;
			   		}
			   		else if(!$("input[name=auth]:checked").val()) {
			   			alert("권한을 선택해주세요")
			   			return false;
		   			}
			   		else if($("#id_check").val() == "no"){
			   			alert("아이디 중복확인을 해주세요")
			   			return false;
			   		}
			   		else if($("#pw_check").val() == "no"){
			   			alert("비밀번호 일치여부를 확인해주세요")
			   			return false;
			   		}
			})
	    	</script>
   	</div> 

</form>
<hr>
</body>
</html>