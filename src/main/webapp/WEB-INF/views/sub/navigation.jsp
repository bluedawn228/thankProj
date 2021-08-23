<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
					<li id="topNavi2_MENU00469"><a href="/contributors">제작 참여</a>
					</li>
				</ul></li>


			<li id="topNaviCom_MENU00476" class="depth1"><a
				href="/inventory-bdi" id="MENU00476" class="topMenu">심리검사</a>
				<ul class="depth2">
					<li id="topNavi2_MENU00478"><a href="/inventory-bdi">K-BDI
							검사</a></li>
					<li id="topNavi2_MENU00479"><a href="/inventory-ces">K-CES
							검사</a></li>
					<li id="topNavi2_MENU00480"><a href="/inventory-pic">그림 검사</a></li>
				</ul></li>



			<li id="topNaviCom_MENU00485" class="depth1"><a href="/chore"
				id="MENU00485" class="topMenu">기분 좋은 콘텐츠</a>
				<ul class="depth2">
					<li id="topNavi2_MENU00490" class="active"><a href="/chore">기분
							좋은 컨텐츠 소개</a></li>
					<li id="topNavi2_MENU00486"><a href="/chore-story">위로가 되는
							이야기</a></li>
					<li id="topNavi2_MENU00651"><a href="/chore-youtube">영상 함께
							봐요</a></li>
					<li id="topNavi2_MENU00651"><a href="/chore-cooking">요리 자랑</a></li>
					<li id="topNavi2_MENU00651"><a href="/chore-chat">함께 이야기해요</a></li>
				</ul></li>



			<li id="topNaviCom_MENU00489" class="depth1"><a href="/medi"
				id="MENU00489" class="topMenu">감성명상</a>
				<ul class="depth2">
					<li id="topNavi2_MENU00490" class="active"><a href="/medi">감성명상
							소개</a></li>
					<li id="topNavi2_MENU00497"><a href="/medi-step01">감성명상 일기</a></li>
					<li id="topNavi2_MENU00499"><a href="/medi-community">감성명상
							커뮤니티</a></li>
				</ul></li>


			<li id="topNaviCom_MENU00505" class="depth1"><a href="/poi"
				id="MENU00505" class="topMenu">상담소 진료소</a>
				<ul class="depth2">
					<li id="topNavi2_MENU00491" class="active"><a href="/poi">추천
							방법</a></li>
					<li id="topNavi2_MENU00647" class="active"><a
						href="/POIBoardSort/listAll">상담소 진료소 추천 목록</a></li>

				</ul></li>

			<li id="topNaviCom_MENU00505" class="depth1"><a href="/mypage"
				id="MENU00505" class="topMenu">마이 페이지</a>
				<ul class="depth2">
					<li id="topNavi2_MENU00491" class="active"><a href="/mypage">나의
							정보</a></li>

					<li id="topNavi2_MENU00512"><a href="/mypage-history">나의
							콘텐츠</a></li>

					<li id="topNavi2_MENU00582"><a href="/mypage-notes">쪽지 목록</a>
					</li>
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

		<a href="javascript:;" class="all-menu-close"><i class="xi-close"></i><span
			class="sr-only">전체메뉴닫기</span></a>
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
	$(document).ready(function() {
		$(".btn-close").click(function() {
			if ($("input:checkbox[name=inputChk]").is(":checked") == true) {
				setCookiePopup("todayCookie", "done", 1);
				$("#popup-layer").hide()
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
