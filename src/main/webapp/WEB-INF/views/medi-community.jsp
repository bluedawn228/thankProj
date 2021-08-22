<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./sub/header.jsp" />
<title>커뮤니티&nbsp;|&nbsp;감사명상</title>
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
        font-family: 'Reenie Beanie', cursive;
        font-size: 25px;
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
        background: linear-gradient(135deg, #ffff88 81%, #ffff88 82%, #ffff88 82%, #ffffc6 100%);
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
        font-family: 'Open Sans', sans-serif;
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
        background-color : #fff;
    }

    .edit-tools button {
    	padding : 5px 10px;
        border: 1px solid #e5e5e5;
        color: #444;
        border-radius: 10px;
        font-family: inherit;
        margin: auto;
        font-size: 0.8rem;
        background-color : #fff;
    }
    .postContent{
     /* 특정 단위로 텍스트를 자르기 위한 구문 */
		white-space: normal;
		display: -webkit-box;
		-webkit-line-clamp: 2; /* 텍스트를 자를 때 원하는 단위 ex) 3줄 */
		-webkit-box-orient: vertical;
		overflow: hidden;  
    }
	body {
	  background: #FFDAB9;
  	  background-image:url(https://raw.github.com/subtlepatterns/SubtlePatterns/gh-pages/retina_wood.png);
       -webkit-font-smoothing: antialiased;
      font-smoothing: antialiased;
	}
	
	.pinterest-more-btn{
		background-color:#fff;
	}
</style>
<script>

function viewDetail(id){
	location.href="/medi-community-detail?diaryId="+id;
}
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

            </div>
            <section class="cont-wrap horizontal wood">
                <h1 class="stitle">감사명상 커뮤니티</h1>
                <div id="contents" class="container">
                    <!-- 	작성자 게시글 4개 -->
                    <div class="cont-mid ">
                        
                         
                          <div class="page-count-wrap clearfix" style="margin-top:10px;">
                            <div class="page-count">
                                <div class="page-total">총 <em>16</em>건</div>
                            </div>
                            
                            
                        <div class="category-wrap"> 
                             <div style="font-size:30px;"><strong><em>${author}</em> 님의 최근 감사일기</strong></div>
                         </div>

                        </div>
                            
                        <ul class="pinterest-board row">

                            <c:forEach items="${authorList}" var="post">
                                <li class="col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item">

                                    <div class="postit-container" onclick="javascprit:viewDetail('${post.diaryId}')">
                                        <div class="postit yellow">
                                            <p class="postContent">${post.content}</p>
                                            <span style="margin-bottom:12px;">${post.author}</span>
                                            <div class="edit-tools">
                                                <button>조회수 ${post.viewCnt}</button>
                                                <button>좋아요 ${post.rcmdCnt}</button>
                                                <button>댓글 수 ${post.commCnt}</button>
                                            </div>
                                            <div class="edit-tools">
                                                <button>긍정 ${post.pgStat}</button>
                                                <button>응원 댓글 쓰기</button>
                                            </div>
                                        </div>
                                    </div>

                                </li>
                            </c:forEach>
                        </ul>

                        <div class="btns txt-center" style="margin: -20px 0">
                            <button type="button" id="more" class="pinterest-more-btn" onclick="javascript:alert('마이페이지');"><i class="xi-angle-down-min"></i>더보기</button>
                        </div>


                    </div>

<hr>
                    <!--  공개 게시글 12개  -->
                    <div class="cont-mid ">

                        <div class="page-count-wrap clearfix" style="margin-top:-100px;">
                            <div class="page-count">
                                <div class="page-total">총 <em>16</em>건</div>
                            </div>

                            <div class="category-wrap">
                          
                                   	<div style="font-size:30px;"><strong>최근 공개 감사일기</strong></div>
                       
                            </div>
                            
                        </div>

                        <ul class="pinterest-board row">

                            <c:forEach items="${openedList}" var="post">
                                <li class="col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item">

                                    <div class="postit-container" onclick="alert('${post.diaryId}')">
                                        <div class="postit yellow">
                                            <p class="postContent">${post.content}</p>
                                            <span style="margin-bottom:12px;">${post.author}</span>
                                            <div class="edit-tools">
                                                <button>조회수 ${post.viewCnt}</button>
                                                <button>좋아요 ${post.rcmdCnt}</button>
                                                <button>댓글 수 ${post.commCnt}</button>
                                            </div>
                                            <div class="edit-tools">
                                                <button>긍정 ${post.pgStat}</button>
                                                <button>응원 댓글 쓰기</button>
                                            </div>
                                        </div>
                                    </div>

                                </li>
                            </c:forEach>
                        </ul>

                        <div class="btns txt-center" style="margin: -20px 0;">
                            <button type="button" id="more" class="pinterest-more-btn" onclick="javascript:alert('공개 게시글 목록');"><i class="xi-angle-down-min"></i>더보기</button>
                        </div>
                    </div>


                </div>
            </section>
            <a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
        </main>
        <!-- footer -->
        <jsp:include page="./sub/footer.jsp" />
