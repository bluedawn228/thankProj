<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./sub/header.jsp" />
<title>감사명상 일기&nbsp;|&nbsp;감사명상</title>

<style>
    .animation-bar {
        position: relative;
        display: block;
        padding: 5px;
        font-size: 16px;
        line-height: 16px;
        border-radius: 30px;
        background: rgba(0, 0, 0, 0.1);
        box-shadow: inset 1 1px 2px rgba(0, 0, 0, 0.25), 0 1px rgba(255, 255, 255, 0.8);

    }

    .animation-bar span {
        position: relative;
        display: inline-block;
        vertical-align: middle;
        height: 20px;
        border-radius: 10px 0 0 10px;
        overflow: hidden;
        background-color: #00e6e7;
        background-size: 100%;
        background-image: linear-gradient(to bottom, #00b3b4, #008081);
        animation: progress-bar 6s 1 ease;
    }

    .animation-bar .pglabel {
        position: relative;
        display: inline-block;
        vertical-align: top;
        height: 0px;
        background-size: 100%;
        /*  animation : progress-bar-label 6s infinite ease;*/
    }

    .animation-bar .pglabel::before {
        position: absolute;
        right: 0;
        bottom: 100%;
        display: inline-block;
        width: 0;
        height: 0;
        padding: 0;
        margin: 0;
        border: 10px solid transparent;
        border-right-width: 0;
        border-bottom-width: 0;
        border-top-color: rgba(0, 0, 0, 1);
        content: "";
    }

    .animation-bar .pglabel::after {
        position: absolute;
        right: 0;
        bottom: calc(100% + 5px);
        z-index: 1;
        display: inline-block;
        content: attr(data-label);
        padding: 5px;
        border-radius: 3px;
        font-size: 0.8em;
        background-color: rgba(0, 0, 0, 1);
        color: #fff;

    }

    .animation-bar span::after {
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        content: "";
        background-size: 100%;
        background-image: linear-gradient(45deg, #fff 25%,
                rgba(0, 0, 0, 0) 25%,
                rgba(0, 0, 0, 0) 50%,
                #fff 50%,
                #fff 75%,
                rgba(0, 0, 0, 0) 75%,
                rgba(0, 0, 0, 0));
        background-size: 30px 30px;
        opacity: 0.3;
        animation: progress-bar-after 0.5s infinite linear;
    }


    @keyframes progress-bar {
        0% {
            width: 0%;
        }

    }

    @keyframes progress-bar-after {
        0% {
            background-position: 0 100%;
        }

        100% {
            background-position: 30px 100%;
        }
    }

    @keyframes progress-bar-label {
        0% {
            width: 0%;
        }

        100% {
            width: 100%
        }
    }

    .web {
        width: 100%;
        text-align: center;
        border: 1px #eee solid;
        box-shadow: 5px 10px 10px rgba(0, 0, 0, .6);
    }

    .upperWrapper {
        width: 100%;
        display: block;
        border-right-width: 10px;
        border-right-color: rgba(0, 0, 0, 1);

    }

    .upperWrapper .diaryContent {
        width: 48%;
        display: inline-block;
        margin: 0 auto;
        line-height: 200%;
        /* 	  border:1px green dotted; */

    }

    .upperWrapper .diaryContent .emc {
        width: 48%;
        display: inline-block;

    }

    .upperWrapper .diaryContent .emc span {
        font-size: 80px;
    }

    .upperWrapper .diaryContent .emc .emc-text {
        font-size: 30px;
        font-weight: 600;
    }

    .upperWrapper .diaryContent .reg {
        width: 48%;
        display: inline-block;
        text-align: center;

    }

    .upperWrapper .diaryContent .regDate {
        padding-top: 50px;
        width: 98%;
        display: inline-block;
        text-align: center;
        font-size: 22px;

    }

    .upperWrapper .diaryContent .regAuthor {
        padding: 30px 0;
        width: 98%;
        display: inline-block;
        text-align: center;
        font-size: 26px;


    }

    .upperWrapper .diaryContent .regDuration {
        width: 98%;
        display: inline-block;
        text-align: center;
        font-size: 22px;

    }



    .upperWrapper .pharseContent {
        padding: 20px;
        width: 98%;
        display: inline-block;
        text-align: center;

    }

    .upperWrapper .pharseContent span {
        text-align: center;
        padding: 30px 0;

    }


    .upperWrapper .pharseContent .phrsText {
        padding: 100px 0;
        width: 60%;
        line-height: 30px;
        font-size:  20px;

    }

    .upperWrapper .pharseContent .phrsAuthor {
        margin-top: 50px;
        line-height: 14px;
        font-size: 14px;
        font-style:italic;

    }

    .upperWrapper .sentimentResult {
        width: 48%;
        padding: 100px;
        text-align: left;
        line-height: 200%;
        margin: 0 auto;
        display: inline-block;
        vertical-align: top;
        /*  border:1px orange dotted; */

    }

    .upperWrapper .sentimentResult .pgStat {
        width: 100%;
        margin: 0 auto;
        text-align: center;

    }

    .upperWrapper .sentimentResult .pgStat span {
        ;
        font-size: 40px;
        line-height: 80px;
        font-weight: 700;
    }



    .lowerWrapper {
        width: 100%;
        text-align: center;
        display: block;
        /* border:1px red solid; */
    }



    .lowerWrapper .innerContent {
    	margin: 20px 0;
        padding: 50px 0;
        width: 98%;
        display: inline-block;
        line-height: 60px;
        font-size: 30px;
        font-weight:800;
        text-align: center;
        border: 1px #eee solid;
        border-radius: 30px;

    }

    .lowerWrapper .innerTags {
        margin: 20px 0;
        padding: 10px 0;
        width: 98%;
        display: inline-block;
        text-align: center;
        font-size: 20px;
        font-weight:800;
        border: 1px #eee solid;
        border-radius: 30px;

    }
	.tagbox {
		text-align:center;
		padding: 5px 20px;
		width:auto;
		border : 1px solid #eee;
		border-radius : 30px;
		background-color:#eee;
		box-shadow:  3px 3px 5px 1px teal;
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
                <h1 class="stitle">감사명상 일기 결과</h1>
                <div id="contents" class="container">
                    <div class="cont-mid ">

                        <div class="web">
                            <input type="hidden" id="progress" value="${md.pgStat}">
                            <input type="hidden" id="diaryId" value="${md.diaryId}">
                            <div class="upperWrapper">
                                <div class="diaryContent">
                                    <div class="emc">
                                        <span class="emc-data"> ${md.emcData}</span><br>
                                        <span class="emc-text"> ${md.emcText}</span>
                                    </div>
                                    <div class="reg">
                                        <span class="regDate">
                                            <fmt:formatDate value="${md.regdate}" pattern="yyyy년 mm월 dd일 EE요일" /><br>
                                            <fmt:formatDate value="${md.regdate}" pattern="hh시 mm분" />
                                        </span>
                                        <span class="regAuthor"><strong>${md.author}</strong> 님의 감사일기</span>
                                        <span class="regDuration">명상 시간 : ${mvDT}</span>

                                    </div>

                                    <div class="pharseContent">

                                        <span class="phrsText"> ${phrs.phrsText}</span> <br>
                                        <span class="phrsAuthor">- ${phrs.author} -</span> <br>
                                    </div>


                                </div>
                                <div class="sentimentResult">
                                    <div class="pgStat">
                                        <span>긍정도<br> ${md.pgStat}%</span>
                                    </div>

                                    <div class="animation-bar ">
                                        <span id="progressbar" style="width:10%"></span>
                                        <div class="pglabel" data-label="${md.pgStat}"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="lowerWrapper">


                                <div class="innerContent">
                                    ${md.content}<br>
                                </div>
                                <div class="innerTags">
                                    <c:forEach items="${md.tagList}" var="tag">
                                    	<button type="button" class="tagbox">${tag}</button> 
                                    </c:forEach>

                                </div>
                            </div>
							<div class="btns text-center">
								<a href="#" class="btn btn-style01" onClick=''><span style="color:white;font-weight:400;">감사일기 공유 및 이동</span> </a>
								&nbsp;&nbsp;&nbsp;
								<a href="#" class="btn btn-style02" onClick=''><span><strong>공유 안하고 이동</strong></span> </a>
							</div>

                        </div>
                        <!--//web-->

                    </div>

                </div>
            </section>
            <a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
        </main>
        <!-- footer -->
        <script>
            const pValue = Math.floor(document.querySelector('#progress').value);
            document.querySelector('#progressbar').style.width = pValue + '%';

        </script>

        <jsp:include page="./sub/footer.jsp" />
