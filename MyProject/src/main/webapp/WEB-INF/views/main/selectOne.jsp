<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">

				<style type="text/css">
					div#board{width:900px; margin-left: 100px;}
					div#title{text-align: center; margin-top: 50px; margin-bottom: 50px;}
					h4{color: gray;}
					span#Rec{margin-left: 20px;}
					div#cnt{float: right;}
					div#content{padding: 60px;}
				</style>

				<title>축제글 조회</title>

				<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

				<!-- 합쳐지고 최소화된 최신 CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

				<!-- 부가적인 테마 -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

				<!-- Board CSS -->
				<link rel="stylesheet" href="/resources/page-style.css">

				<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

				<script type="text/javascript">

					//url복사
					function copy(url) {
						var t = document.createElement("textarea");
						document.body.appendChild(t);
						t.value = url;
						t.select();
						document.execCommand('copy');
						document.body.removeChild(t);
					}

					//url공유
					$(document).ready(function () {
						$(".dropdown-menu li a").click(function () {
							shareAct(this);
						});
					});

					function shareAct(a) {
						var snsCode = $(a).attr('id');
						var cUrl = document.location.href;

						switch (snsCode) {
							case "twitter":
								cUrl = 'https://twitter.com/intent/tweet?text=공유하기:&url=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
							case "facebook":
								cUrl = 'http://www.facebook.com/sharer/sharer.php?u=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
							case "kakao":
								cUrl = 'https://story.kakao.com/share?url=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
						}
					}

					//게시글 추천수
					function countRec() {
						var bnum = ${ board.bnum }
						$.getJSON("/main/selectOne/countRec?bnum=" + bnum, function (count) {
							var cnt = "";
							$(count).each(function () {
								cnt += "<span>" + this + "</span>";
							})
							$(".countRec").html(cnt);
						})
					}

				</script>


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
							<ul class="board-aside">
						      <li><a href="/main/main?page=${cri.page}&amount=${cri.amount}&array=${cri.array}&type=${cri.type}&keyword=${cri.keyword}">목록보기</a></li>
						    </ul>
						</aside>

						<div id="container_box">

							<div id="board">

								<input type="hidden" name="bnum" id="bnum" value='${board.bnum}'>

								<div id="title">
										<h1><b>${board.title}</b></h1><br>
										<h4>${board.area }</h4>
										<h4>${board.startDate }~${board.endDate }</h4>
								</div>
								
								<ul>
									<li>
										
										<!-- url공유 드롭다운 -->
										<div class="btn-group">
											<button type="button" id="btnUrl" class="btn dropdown-toggle" data-toggle="dropdown"
												aria-expanded="false">
												<span class="glyphicon glyphicon-link" aria-hidden="true"></span>
												<span class="caret"></span> <!-- 드롭다운 버튼 -->
											</button>
											<ul class="dropdown-menu" role="menu">
												<li><a id="copy">URL 복사</a></li>
												<li><a id="twitter">트위터 공유</a></li>
												<li><a id="facebook">페이스북 공유</a></li>
												<li><a id="kakao">카카오스토리 공유</a></li>
											</ul>
										</div>
										<script>
											$("a#copy").click(function () {
												var url = document.location.href;
												copy(url);
												alert("URL이 복사되었습니다")
											})
										</script>
										<!-- url공유 드롭다운 -->
										
										<!-- 추천버튼 -->
										<span id="Rec">
											<sec:authorize access="isAnonymous()">
												<button type="button" id="btnRecommendAnonymous" class="btn">
													<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
												</button>
		                            					</sec:authorize>
										
											<sec:authorize access="isAuthenticated()">
												<button type="button" id="btnRecommendAuthenticated" class="btn">
													<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
												</button>
												<input type="hidden" id="user_id" value="<sec:authentication property='principal.username' />">
		                            					</sec:authorize>
											
											<!-- 게시글 추천수 -->
											<span class="countRec">
												<script>countRec();</script>
											</span>
											
											<!-- 게시글 추천 -->
											<script>
												$("#btnRecommendAnonymous").click(function(){
													alert("로그인 후 이용해주세요");
													return false;
												});
											
												$("#btnRecommendAuthenticated").click(function () {
													var header = '${_csrf.headerName}'; 
													var token = '${_csrf.token}';
													
													var bnum = $("#bnum").val();
													var user_id = $("#user_id").val();

													var data = { bnum: bnum, user_id: user_id };
																											
													$.ajax({
														url: "/main/selectOne/insertRec",
														type: "post",
														data: data,
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
														},
														success: function (str) {
															alert(str);
															countRec();
														}
													});
												});
											</script>
										</span>
										<!-- 추천버튼 -->
										
										<div id="cnt"><h4>조회수: ${board.cnt }</h4></div>
									</li>
								</ul>
								
								<hr>
								
								<div id="content">${board.content }</div>

							</div> <!-- board -->

						</div> <!-- container_box -->
					</section>

					<footer id="footer">
						<div>
							<%@ include file="include/footer.jsp" %>
						</div>
					</footer>

				</div>

			</body>

			</html>