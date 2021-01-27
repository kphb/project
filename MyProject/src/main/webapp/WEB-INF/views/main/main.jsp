<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<style type="text/css">
div#board{width:900px;}
#board{margin-left: 100px;}
#arraySearch{margin-left: 330px;}
#area{display: none;}
div#list{display: inline-block; vertical-align: middle; margin-left: 20px;}
img{width: 190px; height: auto;}
#paging {text-align: center;}
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
			
				<span id="arraySearch">
				
					<select id="array">
						<option value="n">정렬</option>
						<option value="l">최신순</option>
						<option value="h">조회수 높은순</option>
						<option value="r">추천수 높은순</option>
					</select>
					
					<select id="searchType">
						<option value="n" <c:out value="${cri.type == null ? 'selected' : ''}" />>검색조건</option>
						<option value="a" <c:out value="${cri.type eq 'a' ? 'selected' : ''}" />>지역</option>
						<option value="t" <c:out value="${cri.type eq 't' ? 'selected' : ''}" />>제목</option>
						<option value="c" <c:out value="${cri.type eq 'c' ? 'selected' : ''}" />>내용</option>
						<option value="tc" <c:out value="${cri.type eq 'tc' ? 'selected' : ''}" />>제목+내용</option>
					</select>
	
					<input type="text" id="keywordInput"/>
					<select id="area">
						<option>---</option>
						<option>서울</option>
						<option>부산</option>
						<option>대구</option>
						<option>인천</option>
						<option>광주</option>
						<option>대전</option>
						<option>울산</option>
						<option>경기</option>
						<option>강원</option>
						<option>충청</option>
						<option>전라</option>
						<option>경상</option>
						<option>제주</option>
					</select>
	
					<button id="searchBtn" class="btn">검색</button>
					
					<script type="text/javascript">
						//검색버튼 클릭
						$('#searchBtn').click(function() {
							self.location = "main"
								+ '${pageMaker.makeQuery(1)}'
								+ "&array="
								+ $("#array option:selected").val()
								+ "&type="
								+ $("#searchType option:selected").val()
								+ "&keyword="
								+ encodeURIComponent($('#keywordInput').val());
								
						})
					
						//검색조건을 변경할 때
						$("#searchType").change(function(){
							
							//검색조건을 지역으로 선택하면
							if($("#searchType option:selected").val() == "a"){
								
								//지역 셀렉/옵션창을 띄우고 인풋 검색창을 숨김
								$("select#area").css("display","inline-block");
								$("input#keywordInput").attr("type","hidden");
								
								$('#searchBtn').click(function() {
									self.location = "main"
										+ '${pageMaker.makeQuery(1)}'
										+ "&array="
										+ $("#array option:selected").val()
										+ "&type="
										+ $("#searchType option:selected").val()
										+ "&keyword="
										+ encodeURIComponent($('#area option:selected').val());
								})
							}
							//검색조건이 지역이 아니면 지역 셀렉/옵션을 숨기고 인풋 검색창을 띄움
							else{
								$("select#area").css("display","none");
								$("input#keywordInput").attr("type","text");
								
								$('#searchBtn').click(function() {
									self.location = "main"
										+ '${pageMaker.makeQuery(1)}'
										+ "&array="
										+ $("#array option:selected").val()
										+ "&type="
										+ $("#searchType option:selected").val()
										+ "&keyword="
										+ encodeURIComponent($('#keywordInput').val());
										
								})
							}
						})
					</script>
				</span> <!-- arraySearch -->

				<div id="board">
						<c:forEach items="${list}" var="list">
							<hr>
							<ul>
							  <li>
							  	<img alt="" src="${list.thumbImg}">
							  	<div id="list">
							  		<div id="title">
								  		<h4><b><a href="/main/selectOne?bnum=${list.bnum}
										&page=${pageMaker.cri.page}
										&amount=${pageMaker.cri.amount}
										&array=${pageMaker.cri.array}
										&type=${pageMaker.cri.type}
										&keyword=${pageMaker.cri.keyword}">${list.title}</a></b></h4>
							  		</div>
								  	<div>
								  		#${list.area}
								  		#${list.startDate}~${list.endDate}<br><br>
								  		조회수: ${list.cnt}<br>
								  		추천수: ${list.rec}
								  	</div>
							  	</div>
							  </li>
							</ul>
							<hr>
						</c:forEach>
				</div>				

				<div id="paging">
					<ul class="pagination">
						<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.prev}">
							<li>
								<a href='<c:url value="main${pageMaker.makeArraySearch(pageMaker.startPage - 1)}"/>'
									aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
	
						<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							<li>
								<a href='<c:url value="main${pageMaker.makeArraySearch(pageNum)}"/>'>${pageNum}
								</a>
							</li>
						</c:forEach>
	
						<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li>
								<a href='<c:url value="main${pageMaker.makeArraySearch(pageMaker.endPage + 1)}"/>'
									aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				</div> <!-- paging -->
				
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