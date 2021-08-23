<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="content-language" content="kr">
<meta http-equiv="imagetoolbar" content="no">
<title>토닥토닥 - 감성 공유 커뮤니티</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, user-scalable=no">


<link rel="stylesheet"
	href="/css/jquery.mCustomScrollbar.css">


<script src="/js/jquery-2.2.4.min.js"></script>
<script src="/js/common.ccis.js"></script>
<script src="/js/jquery.fullPage.min.js"></script>

<link rel="stylesheet" href="/css/ki-test.css">
<script>




$(document).ready(function(){
	
	//introduce  슬라이드
	$(".introduce .counter").prepend('<strong class="current-index"></strong> / ');
	var introSlider = $(".intro-list").bxSlider({ 
		autoStart		: true,
		auto			    : true,
		autoHover		: true,
		speed			    : 1000,
		pause		 	    : 3000,
		mode			    : 'fade',
		maxSlides		: 1,
		minSlides        : 1,
		moveSlides     : 1,
		pager			    : false,
		responsive		: false,
		autoControls	: true,
		controls		    : true,
		touchEnabled  : navigator.maxTouchPoints > 0,
		onSliderLoad: function(currentIndex){
			$('.introduce .counter .current-index').text(currentIndex + 1);
		},
		onSlideBefore: function($slideElement, oldIndex, newIndex) {
			$('.introduce .counter .current-index').text(newIndex + 1);
		},
	});	  
	$(".intro-list li > a").on("focusin", function(){
		introSlider.stopAuto();
	});
	$(".intro-list li > a").on("focusout", function(){
		introSlider.startAuto();
	});
	$(".introduce .counter").append(introSlider.getSlideCount());

	
	
	
});
</script>


</head>

<body style="overflow: visible; height: initial;"
	class="fp-viewing-firstPage fp-responsive" tabindex="0">
	<div id="wrap">
		<!-- HEADER -->
		<header id="header">
			<h1 class="logo">
				<a href="/"><span class="hidden">토닥토닥</span></a>
			</h1>
			<!--  상단 네비바  -->
			<nav class="nav">
				<ul id="gnb" class="gnb">

					<li id="topNaviCom_MENU00465" class="depth1"><a href="/intro"
						class="topMenu">토닥토닥 소개</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00466"><a href="/intro">토닥토닥은</a></li>
							<li id="topNavi2_MENU00470"><a href="/purpose">운영 취지</a></li>
							<li id="topNavi2_MENU00469"><a href="/contributors">제작
									참여</a></li>
						</ul></li>


					<li id="topNaviCom_MENU00476" class="depth1"><a
						href="/inventory-bdi" id="MENU00476" class="topMenu">심리검사</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00478"><a href="/inventory-bdi">K-BDI
									검사</a></li>
							<li id="topNavi2_MENU00479"><a href="/inventory-ces">K-CES
									검사</a></li>
							<li id="topNavi2_MENU00480"><a href="/inventory-pic">그림
									검사</a></li>
						</ul></li>



					<li id="topNaviCom_MENU00485" class="depth1"><a href="/chore"
						id="MENU00485" class="topMenu">기분좋은 콘텐츠</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00490" class="active"><a href="/chore">기분
									좋은 컨텐츠 소개</a></li>
							<li id="topNavi2_MENU00486"><a href="/chore-story">위로가
									되는 이야기</a></li>
							<li id="topNavi2_MENU00651"><a href="/chore-youtube">영상
									함께 봐요</a></li>
							<li id="topNavi2_MENU00651"><a href="/chore-cooking">요리
									자랑</a></li>
							<li id="topNavi2_MENU00651"><a href="/chore-chat">함께 이야기
									해요</a></li>
						</ul></li>



					<li id="topNaviCom_MENU00489" class="depth1"><a href="/medi"
						id="MENU00489" class="topMenu">감성명상</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00490" class="active"><a href="/medi">감성명상
									소개</a></li>
							<li id="topNavi2_MENU00497"><a href="/medi-step01">감성명상
									쓰기</a></li>
							<li id="topNavi2_MENU00499"><a href="/medi-community">감성명상
									커뮤니티</a></li>
						</ul></li>


					<li id="topNaviCom_MENU00505" class="depth1"><a href="/recm"
						id="MENU00505" class="topMenu">상담소 진료소</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00491" class="active"><a href="/recm">삼담소
									진료소 소개</a></li>
							<li id="topNavi2_MENU00647" class="active"><a
								href="/recm-board">상담소 진료소 목록</a></li>

						</ul></li>

					<li id="topNaviCom_MENU00505" class="depth1"><a href="/mypage"
						id="MENU00505" class="topMenu">마이 페이지</a>
						<ul class="depth2">
							<li id="topNavi2_MENU00491" class="active"><a href="/mypage">나의
									정보</a></li>

							<li id="topNavi2_MENU00512"><a href="/mypage-history">나의
									콘텐츠</a></li>

							<li id="topNavi2_MENU00582"><a href="/mypage-notes">쪽지
									목록</a></li>
						</ul></li>


					<c:choose>
						<c:when test="${userInfo.id eq null }">
							<li id="topNaviCom_MENU00529" class="depth1"><a
								href="/auth-signup" id="MENU00529" class="topMenu">회원가입</a></li>
							<li id="topNaviCom_MENU00529" class="depth1"><a
								href="/auth-signin" id="MENU00529" class="topMenu">로그인</a></li>
						</c:when>
						<c:otherwise>
							<li id="topNaviCom_MENU00529" class="depth1">
								${userInfo.name}(${userInfo.id}) 님</li>
							<li id="topNaviCom_MENU00529" class="depth1"><a
								href="/auth-signout" id="MENU00529" class="topMenu">로그아웃</a></li>

						</c:otherwise>
					</c:choose>

				</ul>
				<!-- gnb -->

				<a href="javascript:;" class="all-menu-close"><i
					class="xi-close"></i><span class="sr-only">전체메뉴닫기</span></a>
			</nav>
			<!--  상단 네비바  -->

			<!-- 	부가 기능 (알림, 검색) -->
			<div class="util">

				<!-- 사이드 알림판 -->
				<div class="side-popup">
					<button type="button" class="popup-notice" data-cnt="3">
						<i class="xi-bell-o"></i> <span class="badge">3</span><span
							class="sr-only">알림판 열기</span>
					</button>
					<div id="popup-layer" class="">
						<strong class="subject">알림판</strong>
						<div class="popup-slide">
							<div class="bx-wrapper" style="max-width: 100%;">
								<div class="bx-viewport" aria-live="polite"
									style="width: 100%; overflow: hidden; position: relative; height: 255px;">
									<ul class="popup-list"
										style="width: auto; position: relative; transition-duration: 0.5s; transform: translate3d(0px, -740px, 0px);">
										<li
											style="float: none; list-style: none; position: relative; width: 350px;">
											
										</li>
									</ul>
								</div>
								
								</div>
							</div>
							<div class="popup-counter">
								<strong class="current-index"></strong>
							</div>
						</div>
		
					</div>
				</div>
				<!-- 사이드 알림판 -->



				<!-- 햄버거 버튼 -->
				<a href="javascript:;" class="all-menu"><i class="xi-bars"></i><span
					class="sr-only">전체메뉴열기</span> </a>
				<!-- 햄버거 버튼 -->
			</div>
			<!-- 	부가 기능 (알림, 검색) -->
		</header>
		<!-- HEADER -->

		<div class="header-dimmed"></div>
		<form id="headerLoginForm" name="headerLoginForm"
			action="/main/member/loginForm?menuId=" method="POST"
			style="display: none;">
			<input type="hidden" name="csSignature"
				value="/UQ6sJHXfB8lppJelkYw/Q=="> <input type="hidden"
				id="rtnUrlLogin" name="rtnUrl" value="">
		</form>
		<script>
			$(document)
					.ready(
							function() {
								$("#popup-layer").hide();
								$(".btn-close")
										.click(
												function() {
													if ($(
															"input:checkbox[name=inputChk]")
															.is(":checked") == true) {
														setCookiePopup(
																"todayCookie",
																"done", 1);
														$("#popup-layer")
																.hide()
													}
												});
								getCookiePopup()
							});

			function setCookiePopup(c, d, a) {
				var b = new Date();
				b.setDate(b.getDate() + a);
				document.cookie = c + "=" + escape(d) + "; path=/; expires="
						+ b.toGMTString() + ";"
			}

			function getCookiePopup() {
				var a = document.cookie;
				if (a.indexOf("todayCookie=done") < 0) {
					$("#popup-layer").addClass("active")
				} else {
					$("#popup-layer").removeClass("active")
				}
			}
		</script>
		<main id="main" class="main">
			<!-- 사이드바 위치 네비 -->
			<nav id="fp-nav" class="section-nav">
				<ul>
					<li class="active"><a href="#section1"><span>01</span> 메인
							화면</a></li>
					<li><a href="#section2"><span>02</span>심리 검사</a></li>
					<li><a href="#section3 "><span>03</span>감성 일기</a></li>
				</ul>
			</nav>
			<!--  1페이지  -->
			<div id="section1" class="section">
				<div class="visual-section">
					<div class="visual-list">
						<div>
							<span class="bg01"></span>
						</div>
						<div>
							<span class="bg02"></span>
						</div>
					</div>
				</div>
				<div class="container">
					<div class="visual-txt">
						<p class="first-txt">
							코로나 시대의 여러분의 마음, <strong>토닥토닥</strong>이 함께 합니다.
						</p>
						<small class="sub-txt">코로나 우울증은 함께 극복할 수 있습니다.</small>
					</div>
					<div class="float-wrap">
						<section class="news-area">
							<h2 class="section-subtit">행복을 결정하는 가장 강력한 요소 중에 하나는 감성입니다.</h2>

							<iframe width="100%" HEIGHT="90%"
								src="https://www.youtube-nocookie.com/embed/WPPPFqsECz0?controls=0"
								title="YouTube video player" frameborder="0"
								allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
								allowfullscreen></iframe>

							<!--  <a href="/board?menuId=MENU00490" class="more">more <i class="xi-long-arrow-right "></i></a> -->
						</section>
						<section class="introduce">

							<h3 class="hidden">소개 섹션</h3>
							<ul class="intro-list">
								<li class="list01"><span class="num">토닥토닥 소개 #01</span>
									<dl>
										<dt>토닥토닥은?</dt>
										<dd>코로나 시대에 우리가 격고 있는 우울한 마음을 함께 해결하고자 다양한 콘텐츠를 제공합니다.</dd>
									</dl> <a href="/board?menuId=MENU00478" class="more">자세히 보기</a></li>
								<li class="list02"><span class="num">위로가 되는 문구 #02</span>
									<dl>
										<dt>위로가 되는 문구</dt>
										<dd>너는 혼자가 아니야</dd>
									</dl> <a href="/board?menuId=MENU00479" class="more">자세히 보기</a></li>

							</ul>
							<div class="counter"></div>


						</section>
						<!-- intro -->
					</div>
					<!-- wrapper -->
				</div>
				<!-- container -->
				<a href="#section2" id="scroll-down" class="scroll-down">SCROLL
					DOWN</a>
			</div>

			<!--  2	페이지 -->

			<section id="section2" class="section">
				<div class="sec2-wrapper">
					<div class="sec2-container">
						<!--                     <h2 class="section-tit">심리 검사</h2>
 -->
						<div class="bdi-intro-area ">
							<h3 class="section-subtit">
								<span>BDI 검사란</span>
							</h3>
							<ul class="bdi-intro-list ">
								<li><a href=""> <span class="thumb"><img
											src="/resources/images/kps/main/facebook_img01.jpg" alt=""></span>
										<span class="desc">블라블라</span> <time class="date">2020.07.02</time>
								</a></li>
								<li><a href=""> <span class="thumb"><img
											src="/resources/images/kps/main/facebook_img02.jpg" alt=""></span>
										<span class="desc">[카드뉴스] 블라블라</span> <time class="date">2020.07.02</time>
								</a></li>
							</ul>
							<a href="#" class="more" target="_blank"><i
								class="xi-plus-min"></i><span class="sr-only">더보기</span></a>
						</div>

						<div class="newletter-area">
							<h3 class="section-subtit">
								<span>도움이 되는 글</span>
							</h3>
							<ul class="newletter-list">
								<li><a
									href="https://www.kinac.re.kr/newsletter/202107/sub_01.html"
									target="_blank" title="새창으로 열림"> <span class="thumb"><img
											src="/resources/images/kps/main/newletter_img01.jpg" alt=""></span>
										<strong class="tit">포커스</strong> <span class="desc">블라블라</span>
								</a></li>
								<li><a
									href="https://www.kinac.re.kr/newsletter/202107/sub_02.html"
									target="_blank" title="새창으로 열림"> <span class="thumb"><img
											src="/resources/images/kps/main/newletter_img02.jpg" alt=""></span>
										<strong class="tit">인사이드</strong> <span class="desc">블라블라</span>
								</a></li>
								<li><a
									href="https://www.kinac.re.kr/newsletter/202107/sub_03.html"
									target="_blank" title="새창으로 열림"> <span class="thumb"><img
											src="/resources/images/kps/main/newletter_img03.jpg" alt=""></span>
										<strong class="tit">피플</strong> <span class="desc">블라블라</span>
								</a></li>
							</ul>
							<a href="#" class="more"><i class="xi-plus-min"></i><span
								class="sr-only">더보기</span></a>
						</div>

						<div class="bdi-inventory-area">
							<h3 class="section-subtit">
								<span>K-BDI 검사 </span>
							</h3>
							<ul class="bdi-inventory-list ">
								<li><iframe src="/inventory-bdi-main" scrolling="no"></iframe></li>
							</ul>
						</div>
					</div>
				</div>
			</section>

			<!--section3 감성일기  -->
			<section id="section3" class="section functions">
				<div class="background"></div>
				<div class="container">

					<h2 class="section-tit">감성명상 일기</h2>
					<div class="float-wrap">

						<!-- 감성일기 명상 -->
						<article class="mediDiary">
							<h3 class="hidden">감성명상 일기</h3>
							<ul class="medi-list">
								<li class="list01">
									<dl>
										<dt>감성명상 일기</dt>
										<dd>일상의 작은 일들에 대해 감성함을 기록하고 긍정적 마음을 키우는 자기관리 프로그램 입니다.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
									</dl> <a href="/board?menuId=MENU00478" class="more">시작하기</a>
								</li>

							</ul>

						</article>

						<!-- 감성일기 커뮤니티 -->
						<article class="mediCommunity">
							<h3 class="hidden">감성 커뮤니티</h3>
							<ul class="comm-list">
								<li class="list01"></span>
									<dl>
										<dt>감성 커뮤니티</dt>
										<dd>다른 멤버들와 감성일기를 공유하고 응원의 댓글을 달 수 있는 공유의 장입니다.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
										<dd>블라블라 소개 글 추가.</dd>
									</dl> <a href="/board?menuId=MENU00478" class="more">시작하기</a></li>

							</ul>

						</article>
					</div>
				</div>
			</section>

			<!-- 3페이지 -->

			<!--  4페이지 -->

			<!--go to Top -->
			<div id="section5" class="section"></div>
			<a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span
				class="sr-only">페이지 맨위로 이동</span></a>

		</main>
		<footer id="footer">
			<div class="footer-address">
				<div class="container">
					<span class="footer-logo"></span>
					<nav class="footer-nav">
						<ul>
							<li><a href="/menu?menuId=MENU00517">개인정보처리방침</a></li>
							<li><a href="/menu?menuId=MENU00518">저작권정책</a></li>
							<li><a href="/menu?menuId=MENU00519">이메일무단수집거부</a></li>
							<li><a href="/i-portal" target="_blank" title="새창으로 열림"
								rel="noopener nore"><i class="xi-key"></i><span
									class="sr-only">i-portal</span></a></li>
						</ul>
					</nav>
					<div class="address">
						<address>34054 대전광역시 유성구 유성대로 1418</address>
						<span>대표번호 <a href="tel:042-860-9700">042-860-9700</a>
						</span> <span>팩스번호 042.860.9900</span> <span class="email">이메일
							kinac@kinac.re.kr</span>
					</div>
					<div class="copyright">Copyright ⓒ 2020 KINAC All rights
						reserved.</div>
				</div>
			</div>
		</footer>


	</div>
	<!-- wrap -->
	<script
		src="https://www.kinac.re.kr/resources/js/jquery.scrollbar.concat.min.js"></script>
	<script
		src="https://www.kinac.re.kr/resources/js/jquery.bxslider.min.js"></script>
	<script src="https://www.kinac.re.kr/resources/js/kps/common.js"></script>
	<script src="https://www.kinac.re.kr/resources/js/kps/main_new.js"></script>
</body>

</html>
