<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<style type="text/css">
div#title{margin-top: 50px;}
ul{list-style: none;}
ul li{padding: 10px;}
div#findPw{display: none;}
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
	<h1>비밀번호 찾기</h1>
</div>
<hr>
<form action="/sign/changeUser_pw" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    
    <div id="form" class="text-center">
	    <ul>
	    	<li>
	    		<p><b>본인의 아이디와 이름을 입력해주세요</b></p>
	    	</li>
		    <li>
		    	<p>아이디</p>
		        <input type="text" name="user_id"> 
		    </li>
		    <li>
		    	<p>이름</p>
		        <input type="text" name="user_name">
		    </li>
		    <li>
		    	<button type="button" id="check_member" class="btn">조회</button>
		    	
		    	<script type="text/javascript">
					$("#check_member").click(function(){
						var user_id = $("input[name=user_id]").val();
						var user_name = $("input[name=user_name]").val();
						
						$.ajax({
							url: "/sign/check_member",
							type: "get",
							dataType: "json",
							data: {
								"user_id":user_id,
								"user_name":user_name
								},
							success: function(data){
								console.log(data);
								if(data == true){
									alert("존재하는 회원이 맞습니다");
									$("#check_member").css("display","none");
									$("#findPw").css("display","block")
									
								}
								else if(data == false){
									alert("존재하는 회원이 아닙니다");
									return false;
								}
							}
						})
					})
				</script>
		    </li>
		    <div id="findPw">
			    <li>
			    	<p><b>새 비밀번호를 입력해주세요</b></p>
			    </li>
			    <li>
	               <p>비밀번호</p>
	               <input type="password" name="user_pw">
	            </li>
	            <li>
		             <p>비밀번호 확인</p>
		             <input type="password" name="check_user_pw"> 
	             </li>
	             <li>
		             <button type="button" id="check_user_pw" class="btn">일치여부</button>
		             
		             <!-- 비밀번호 일치여부를 위한 input태그 -->
		             <input type="hidden" id="pw_check" value="no">
		             
		             <script type="text/javascript">
		            	 $("#check_user_pw").click(function(){
		    				
		    				var user_pw = $("input[name=user_pw]").val();
		    				var check_user_pw = $("input[name=check_user_pw]").val();
		    				
		    				//두 개의 비밀번호가 같거나 비밀번호가 공백이 아닐 시
		    				if(user_pw == check_user_pw && user_pw != ""){
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
			    	<button type="button" id="change_pw" class="btn">비밀번호 변경하기</button>
			    	
			    	<script type="text/javascript">
			    		$("#change_pw").click(function(){
			    			if($("#pw_check").val() == "no"){
			    				alert("비밀번호 일치여부를 확인해주세요");
			    				return false;
			    			}
			    			else{
			    				alert("비밀번호가 변경되었습니다")
			    				$("form").submit();
			    			}
			    		})
			    	</script>
			    </li>
		    </div>
	    </ul>
    </div>
   
</form>
<hr>
</body>
</html>