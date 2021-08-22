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
        box-shadow: 2px 15px 5px rgba(0, 0, 0, 0.40);
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
    }

    .edit-tools button {
        border: 1px solid #e5e5e5;
        color: #444;
        border-radius: 3px;
        font-family: inherit;
        margin: auto;
        font-size: 0.8rem;
    }

</style>
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
            <section class="cont-wrap horizontal">
                <h1 class="stitle">감사명상 커뮤니티</h1>
                <div id="contents" class="container">
                    <!-- 	작성자 게시글 4개 -->
                    <div class="cont-mid ">
                        
                         
                          <div class="page-count-wrap clearfix" style="margin-top:10px;">
                            <div class="page-count">
                                <div class="page-total">총 <em>16</em>건</div>
                            </div>
                            
                            
                        <div class="category-wrap"> 
                             <div style="font-size:30px;"><em>${author}</em> 님의 최근 감사일기</div>
                         </div>

                        </div>
                            
                        <ul class="pinterest-board row">

                            <c:forEach items="${authorList}" var="post">
                                <li class="col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item">


                                    <div class="postit-container">
                                        <div class="postit yellow">
                                            <p>${post.content}</p>
                                            <span>${post.author}</span>
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

                        <div class="btns txt-center">
                            <button type="button" id="more" class="pinterest-more-btn" onclick="javascript:fnMoreView();"><i class="xi-angle-down-min"></i>더보기</button>
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
                                <div class="input-wrap">
                                    <label for="schText" class="hidden">검색구분</label>

                                    <input type="text" name="schText" id="schText" class="form-control" placeholder="태그를 선택해 주세요" value="" />
                                    <button type="button" name="button" onclick='fn_search();'><i class="xi-search"></i> <span class="hidden">검색</span></button>
                                </div>
                            </div>

                            <div class="category-wrap">
                                <input type="text" class="form-control" value="추천순">
                            </div>
                            
                            <div class="category-wrap">
                                <input type="text" class="form-control" value="댓글순">
                            </div>
                            
                            <div class="category-wrap">
                                <input type="text" class="form-control" value="조회순">
                            </div>
                            
                            <div class="category-wrap">
                                <input type="text" class="form-control" value="최신순">
                            </div>
                            
                        </div>

                        <ul class="pinterest-board row">

                            <c:forEach items="${openedList}" var="post">
                                <li class="col-md-3 col-sm-6 col-xs-12 pinterest-board-img pinterest-item">

                                    <div class="postit-container">
                                        <div class="postit yellow">
                                            <p>${post.content}</p>
                                            <span>${post.author}</span>
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

                        <div class="btns txt-center">
                            <button type="button" id="more" class="pinterest-more-btn" onclick="javascript:fnMoreView();"><i class="xi-angle-down-min"></i>더보기</button>
                        </div>
                    </div>


                </div>
            </section>
            <a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
        </main>
        <!-- footer -->
        <jsp:include page="./sub/footer.jsp" />
