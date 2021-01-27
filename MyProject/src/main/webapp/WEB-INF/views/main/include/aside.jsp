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

<link rel="stylesheet" href="/resources/requestModal-style.css">

</head>
<body>

<ul class="board-aside">

  	<li><a href="/main/main">전체보기</a></li>
  	
  	<li>
  		<sec:authorize access="hasRole('ROLE_MEMBER')">
  			<hr>
			<a id="requestBtn">문의하기</a>
		    <div class="requestModal">
		
		        <div class="modalContent">
		
		            <div>
		                <input type="text" name="title" placeholder="제목을 입력해주세요">
		                <textarea class="modal_repCon" name="content"
		                    placeholder="문의하실 내용을 입력해주세요"></textarea>
		                <input type="hidden" name="user_id"
		                    value="<sec:authentication property='principal.username' />">
		            </div>
		
		            <div>
		                <button type="button" class="modal_insert" class="btn">등록</button>
		                <button type="button" class="modal_cancel" class="btn">취소</button>
		            </div>
		
		        </div>
		
		        <div class="modalBackground"></div>
		
		    </div>
		</sec:authorize>
	
		<script type="text/javascript">
	        $(document).on("click", "#requestBtn", function () {
	            /* $(".requestModal").attr("style", "display:block;"); */
	        	$(".requestModal").fadeIn(200);
	        });
	
	        $(document).on("click", ".modal_insert", function () {
	            var header = '${_csrf.headerName}';
	            var token = '${_csrf.token}';
	
	            var data = {
	                title: $("input[name=title]").val(),
	                content: $("textarea[name=content]").val(),
	                user_id: $("input[name=user_id]").val()
	            };
	
	            $.ajax({
	                url: "/main/insertRequest",
	                type: "post",
	                data: data,
	                beforeSend: function (xhr) {
	                    xhr.setRequestHeader(header, token);
	                },
	                success: function () {
	                	alert("문의하신 내용은 회원페이지에서 확인해주세요")
	                	$(".requestModal").fadeOut(200);
	                }
	            })
	        });
	
	        $(document).on("click", ".modal_cancel", function () {
	            /* $(".requestModal").attr("style", "display:none;"); */
	        	$(".requestModal").fadeOut(200);
	        });
	    </script>
  	</li>
	    
</ul>

</body>
</html>