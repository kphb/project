<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 페이지</title>

<style type="text/css">
div#info{text-align: center; padding: 10px;}
div.requestModal {
    position: relative;
    z-index: 1;
    display: none;
}

div.modalBackground {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8);
    z-index: -1;
}

div.modalContent {
    position: fixed;
    top: 15%;
    left: calc(50% - 250px);
    width: 400px;
    height: 470px;
    padding: 40px;
    background: #fff;
    border: 2px solid #666;
}

ul li{padding: 10px;}

div.modalContent button {
    margin: 10px 0;
    background: #fff;
    border: 1px solid #ccc;
}

div.modalContent button#modal_cancel {
    margin-left: 20px;
}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resources/page-style.css">

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
			
				<div id="info">
					<ul>
						<li>
							<b>이름: </b><sec:authentication property="principal.member.user_name"/>
						</li>
						<li>
							<b>아이디: </b><sec:authentication property="principal.username"/>
						</li>
						<li>
							<button type="button" id="changeMember" class="btn">정보 변경하기</button>
						</li>
					</ul>
				</div>
				
				 <div class="requestModal">
			
			        <div class="modalContent">
			        	<ul>
				            <li>
				            	<p><b>변경하려는 정보를 입력해주세요</b></p>
				                <input type="hidden" name="user_id" value="<sec:authentication property='principal.username'/>">
			                </li>
			                <li>
				                <p>이름</p>
				                <input type="text" name="user_name" value="<sec:authentication property='principal.member.user_name'/>">
			                </li>
			                <li>
				                <p>비밀번호</p>
				                <input type="password" name="user_pw">
			                </li>
			                <li>
				                <p>비밀번호 확인</p>
				                <input type="password" name="check_user_pw"> 
				                <button type="button" id="check_user_pw" class="btn">일치여부</button>
				                
				                <input type="hidden" id="pw_check" value="no">
	        					<!-- 비밀번호 일치여부를 위한 input태그 -->
				            </li>
				            <li>
				                <button type="button" id="modal_insert" class="btn">변경</button>
				                <button type="button" id="modal_cancel" class="btn">취소</button>
				            </li>
			            </ul>
			        </div> <!-- modalContent -->
			
			        <div class="modalBackground"></div>
			 
			    </div> <!-- requestModal -->
			    
	    		<script type="text/javascript">
	    			$(document).on("click", "#check_user_pw", function(){
	    				
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
	    		
			        $(document).on("click", "#changeMember", function () {
			            /* $(".requestModal").attr("style", "display:block;"); */
			        	$(".requestModal").fadeIn(200);
			        });
			
			        $(document).on("click", "#modal_insert", function () {
			        	
			        	if($("#pw_check").val() == "no"){
				   			alert("비밀번호 일치여부를 확인해주세요")
				   			return false;
				   		}
			        	else{
			        		 var header = '${_csrf.headerName}';
				            var token = '${_csrf.token}';
				
				            var data = {
				                user_id: $("input[name=user_id]").val(),
				                user_name: $("input[name=user_name]").val(),
				                user_pw: $("input[name=user_pw]").val()
				            };
				
				            $.ajax({
				                url: "/member/changeUser_pw",
				                type: "post",
				                data: data,
				                beforeSend: function (xhr) {
				                    xhr.setRequestHeader(header, token);
				                },
				                success: function () {
				                	alert("변경된 비밀번호로 다시 로그인해주세요")
				                    location.href = "/sign/logout";
				                }
				            })
			        	}
			        });
			
			        $(document).on("click", "#modal_cancel", function () {
			            /* $(".requestModal").attr("style", "display:none;"); */
			        	$(".requestModal").fadeOut(200);
			        });
			    </script>
				
			</div> <!-- container_box -->

		</section> <!-- container -->

		<footer id="footer">
			<div>
				<%@ include file="include/footer.jsp" %>
			</div>
		</footer>

	</div>

</body>

</html>