<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="./sub/header.jsp" />
<title>커뮤니티&nbsp;|&nbsp;감성명상</title>
<style>
.postit-container {
	display: flex;
}

.postit {
	box-sizing: border-box;
	margin: 25px;
	min-width: 250px;
	max-width: 250px;
	height: 250px;
	padding: 35px 5px 5px 5px;
	border: 1px solid #E8E8E8;
	font-family: 'Jua', 'Gamja Flower', 'Montserrat', cursive;
	font-size: 20px;
	text-align: center;
	border-bottom-right-radius: 60px 5px;
	position: relative;
	display: flex;
	flex-direction: column;
	box-shadow: 5px 10px 10px rgba(0, 0, 0, .6);
}

.postit-container:hover {
	transform: scale(1.2);
	/* box-shadow: 5px 10px 10px rgba(0, 0, 0, .6); */
}

.postit:after {
	content: "";
	position: absolute;
	z-index: -1;
	right: -0px;
	bottom: 20px;
	width: 200px;
	height: 25px;
	background: rgba(0, 0, 0, 0.2);
	box-shadow: 5px 15px 15px rgba(0, 0, 0, 0.40);
	transform: matrix(-1, -0.1, 0, 1, 0, 0);
}

.yellow {
	background: linear-gradient(135deg, #ffff88 81%, #ffff88 82%, #ffff88 82%, #ffffc6
		100%);
}

.pink {
	background: linear-gradient(135deg, #ff879b 81%, #ff879b 82%, #ffc7d0 100%);
}

.green {
	background: linear-gradient(135deg, #b1ff87 81%, #b1ff87 82%, #dbffc7 100%);
}

p {
	margin: 0;
	width: 100%;
	height: 100%;
}

.edit-tools {
	width: 100%;
	margin-bottom: 12px;
	font-family: 'Gamja Flower', cursive;
	display: flex;
}

.edit-tools select {
	border: 1px solid #e5e5e5;
	color: #444;
	border-radius: 3px;
	font-family: inherit;
	margin: auto;
}

.edit-tools input {
	border: 1px solid #e5e5e5;
	color: #444;
	border-radius: 3px;
	font-family: inherit;
	margin: auto;
	background-color: #fff;
}

.edit-tools button {
	padding: 5px 10px;
	border: 1px solid #e5e5e5;
	color: #444;
	border-radius: 10px;
	font-family: inherit;
	margin: auto;
	font-size: 0.8rem;
	background-color: #fff;
}

.postContent {
	/* 특정 단위로 텍스트를 자르기 위한 구문 */
	white-space: normal;
	display: -webkit-box;
	-webkit-line-clamp: 2; /* 텍스트를 자를 때 원하는 단위 ex) 3줄 */
	-webkit-box-orient: vertical;
	overflow: hidden;
	font-family: 'Gamja Flower', cursive;
}

body {
	background: #FFDAB9;
	background-image:
		url(https://raw.github.com/subtlepatterns/SubtlePatterns/gh-pages/retina_wood.png);
	-webkit-font-smoothing: antialiased;
	font-smoothing: antialiased;
}

.pinterest-more-btn {
	background-color: #fff;
}

.alert {
	position: fixed;
	bottom: 50px;
	left: 50%;
	width: 400px;
	height: 80px;
	margin: 400px 0 0 -200px;
	padding: 20px;
	border: 3px solid #ccc;
	background: #f7e426;
	border-radius: 20px;
	text-align: center;
}
</style>
<script>
	function viewDetail(id) {
		location.href = "/medi-community-detail?diaryId=" + id;
	}

	//무한 스크롤 
	// 이전 스크롤 좌표
	var lastScrollTop = 0;
	var easeEffect = 'easeInQuint';

	// 스크롤 이벤트 최초 발생
	$(window)
			.scroll(
					function() {
						//alert("왔다");

						// 현재 스크롤 좌표
						var currentScrollTop = $(window).scrollTop();

						/*  
						================= 다운 스크롤인 상태	================
						 */
						if (currentScrollTop - lastScrollTop > 0) {

							// 현재 스크롤의 top 좌표가 > 게시글을 불로온 화면 height - 윈도우의 창 height 되는 순간
							if ($(window).scrollTop() >= ($(document).height() - $(
									window).height())) {

								//다음 페지이 값을 가져온다.( 다음 페이지 조회를 위해 +1 해줬다.)
								// val()은 스트링 이므로 숫자로 변환~
								//alert(pageValue);
								var pageValue = Number($("#pageValue").val()) + 1;
								//alert(pageValue);
								var author = $("#authorId").val();

								// 12개의 데이터를 더 받아온다.
								$
										.ajax({
											type : 'POST',
											url : '/medi-community-mypage',
											contentType : "application/json",
											dataType : 'json',
											data : JSON.stringify({
												"page" : pageValue,
												"author" : author
											}),
											success : function(data) {
												//alert(data);
												var str = "";

												if (data != "") {

													$(data)
															.each(
																	function(
																			index,
																			item) {

																		str += "<li class='col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item'> "
																				+ "    <div class='postit-container' onclick=\"javascprit:viewDetail('"
																				+ this.diaryId
																				+ "')\"> "

																		
																		if ( this.opened == '1')  {
																			str+= "		<div class='postit yellow'> "
																		} else {
																			str+= "    	<div class='postit green'> "
																		}

																		 str+= "            <p class='postContent'>"
																				+ this.content
																				+ "</p> "
																				+ "            <span style='margin-bottom:12px;'>"
																				+ this.author
																				+ " 님</span> "
																				+ "            <div class='edit-tools'> "
																				
																				+ "<button>"
																		if ( this.opened == '1')  {
																			str+="		공개"
																		} else {
																			str+="		비공개"
																		}
																				str+="</button>"

																				+ "                <button>조회수 "
																				+ this.viewCnt
																				+ "</button> "
																				+ "                <button>댓글 수 "
																				+ this.commCnt
																				+ "</button> "
																				+ "            </div> "
																				+ "            <div class='edit-tools'> "
																				+ "                <button>좋아요 "
																				+ this.rcmdCnt
																				+ "</button> "
																				+ "                <button>긍정 "
																				+ this.pgStat
																				+ "</button> "
																				+ "            </div> "
																				+ "        </div> "
																				+ "    </div> "
																				+ "</li> ";
																		console
																				.log(str);
																	}); //each

													// 새로 받아온 데이터를 붙여준다.	
													$(".scrollLocation")
															.append(str);

												} // if : data != null
												else {
													autoClosingAlert(
															$("#warningMessage"),
															2000);
													//alert("더 이상 데이터가 없습니다.");
												} //else

												$("#pageValue").val(pageValue);
											} //success
										}); //ajax

							} // if : 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간

							// 현재 스크롤 좌표를 이전 스크롤 좌표에 할당
							lastScrollTop = currentScrollTop;
						} // 다운 스크롤 상태

					}); // $(window).scroll(function()

	function autoClosingAlert(selector, delay) {
		$(selector).show();

		setTimeout(function() {
			$(selector).fadeOut('fast')
		}, delay);
	} //autoClosingAlert
</script>
</head>

<body>

	<a id="uppermost2" href="#contents" class="skip-to">본문 바로가기</a>
	<a id="uppermost" href="#gnb" class="skip-to">주메뉴 바로가기</a>
	<!-- wrap -->
	<div id="wrap">
		<jsp:include page="./sub/navigation.jsp" />
		<main id="main" class="main">
			<div id="spot" class="sub1">
				<input type="hidden" id="pageValue" value="${page}"> <input
					type="hidden" id="authorId" value="${author}">
			</div>
			<section class="cont-wrap horizontal wood">
				<h1 class="stitle">감성명상 커뮤니티</h1>
				<div id="contents" class="container">
					<!-- 	작성자 게시글 12개 씩 -->
					<div class="cont-mid ">


						<div class="page-count-wrap clearfix" style="margin-top: 10px;">
							<div class="page-count">
								<div class="page-total">
									총 <em>${authorCnt }</em>건
								</div>
							</div>


							<div class="category-wrap">
								<div style="font-size: 30px;">
									<strong><em>${author}</em> 님의 감성일기</strong>
								</div>
							</div>

						</div>

						<ul class="pinterest-board row scrollLocation">

							<c:forEach items="${mdList}" var="post">
								<li
									class="col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item">

									<div class="postit-container"
										onclick="javascprit:viewDetail('${post.diaryId}')">
										
										<!-- 공개일기면 노란색, 비공개 일기면 초록색-->	
                                        <c:choose>
                                        
                                        	<c:when test="${post.opened eq '1'}" >
                                        		<div class="postit yellow">
                                        	</c:when>
                                        
	                                        <c:otherwise>
	                                        	<div class="postit green">
	                                        </c:otherwise>
                                        </c:choose>
										
										
											<p class="postContent">${post.content}</p>
											<span style="margin-bottom: 12px;">${post.author} 님</span>
											<div class="edit-tools">
												<button>
												<c:choose>
													<c:when test="${post.opened eq '1'}">
														공개
													</c:when>
													<c:otherwise>
														비공개
													</c:otherwise>
												</c:choose>		
												</button>
												<button>조회수 ${post.viewCnt}</button>
												<button>댓글 수 ${post.commCnt}</button>
											</div>
											<div class="edit-tools">
												<button>좋아요 ${post.rcmdCnt}</button>
												<button>긍정 ${post.pgStat}</button>
												<!--  <button>응원 댓글 쓰기</button> -->
											</div>
										</div>
									</div>

								</li>
							</c:forEach>
						</ul>
					</div>



				</div>
			</section>
			<a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span
				class="sr-only">페이지 맨위로 이동</span></a>
		</main>

		<!-- 스크롤 경고 창 -->
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>어쩌죠... 더 이상 데이터가 없네요. 지금 감성일기를 작성해보시는 건 어떨까요?</strong>
		</div>

		<!-- footer -->
		<jsp:include page="./sub/footer.jsp" />