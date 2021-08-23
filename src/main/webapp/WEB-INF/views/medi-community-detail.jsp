<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./sub/header.jsp" />
<title>감사명상 일기 상세&nbsp;|&nbsp;감사명상</title>
<style>
hr {
	margin : 20px 0;
	border-top: 1px dashed #bbb;
  	border-bottom: 1px dashed #fff;
}
.phrsText{
	font-size:20px;
	font-weight:600;
}
.phrsAuthor{
	font-size:16px;
	font-weight:400;
	font-style:italic;
}
.diaryContent {
	line-height : 40px;
	font-size:30px;

}
.entireArticle {
	
}
.bgArticle {
	position:absolute;
	top:250px;
	left:0;
	width:100%;
	height:100%;
	background-image : url('/images/background/blue-259458.jpg');
	opacity : 0.1;
	
}
.rcmdbtn {
	font-size:24px;
	font-weight:600;
}
</style>
<script>
//추천하기

function diaryRcmd(articleId) {
    //alert(articleId);
	$.ajax({
          type: "GET",
          dataType: "text",
          url: "./DiaryRcmdCall",
          data: { idx : articleId  },
          dataType :"text", // 데이터타입을 text 으로 받아옴
          // 전송 전 작업
          beforeSend: function() {},
          // 요청에 성공하면 함수 실행 data는 응답 데이터가 들어간다
          success: function(data, textStatus) {
              var innerId = "#rcmdCNT";
              //alert(data);
              if (textStatus == 'success') {
            	  $(innerId).text(data);
              };
          },
          // 응답이 종료되면 실행, 성공여부와 상관없이 ajax 완료후 작업 
          complete: function(data) {},
          // 에러가 났을 경우의 작업
          error: function(response, textStatus) {
             alert("오류가 발생했습니다.");
          }
      });
      return false; // 페이지 리로딩을 막는다. 
};




//댓글달기


$(document).ready(function() {
	$("#comments-btn").click(function(){
		if( $("#comments").val() == null || $("#comments").val() == "") {
      		alert("댓글을 입력하세요");	
      		return false;
      	  } 

		  <c:choose>
	          <c:when test="${id eq null }">
	          		alert("댓글을 다시려면 로그인이 필요합니다.");	 
	          </c:when>
	          <c:otherwise>
	          	$("#comments-form").submit();	        		
	          </c:otherwise>
      	  </c:choose>
	});
});
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
			<input type="hidden" id="bgImg">
		</div>
		<section class="cont-wrap horizontal">
			<h1 class="stitle">감사명상 일기 상세</h1>
			<div id="contents" class="container">
				<div class="cont-mid safety-why">
					<!-- 콘텐츠영역 -->
							<article class="bgArticle"></article>
							<article class="board-view entireArticle">
								<h1 class="board-view-title">${diary.author}  님의 ${aCnt}번째 감사일기</h1>
								<div class="tag-sns-wrap clearfix">
									<div class="tag-time">
										<span class="number-tag"><i class="xi-clock-o"></i>
										<fmt:formatDate value="${diary.regdate}" pattern="yyyy년 mm월 dd일 EE요일" /><br></span>
									</div>
									<div class="sns-link">
										<span>조회수 ${diary.viewCnt}</span>
											<span>댓글 수 ${diary.commCnt}</span>
									</div>
								</div>
								<div class="view-content-wrap">
									<div class="view-content">
										<div class="text-center diaryContent">
											 ${diary.diaryId}<br>
											 ${diary.content}
										</div>
																			
										<hr>
										<div style="text-align:center;">
											<h4>긍정도 분석결과 </h4>
											<h2>${diary.pgStat} %</h2>
										</div>   
										
										<hr>
										<div style="text-align:center;">
											<h4>오늘의 명언</h4>
											<span class="phrsText"> ${phrs.phrsText}</span> <br>
	                                        <span class="phrsAuthor">- ${phrs.author} -</span> <br>
	                                    </div>    
										
										
									</div>
								</div>
								<ul class="tag-file-list">
									<li class="list-tag">
											<span>태그</span>
											<ul class="tag-list">
												
												<c:forEach items="${diary.tagList}" var="tag">
			                                    	<li><button type="button" class="tagbox">#${tag}</button></li> 
			                                    </c:forEach>
												
												
											</ul>
										</li>
									<li class="list-tag">
											<span>첨부파일</span>
											<div class="file-list">
												파일 상세
											</div>
										</li>
									</ul>	
									<div class="tag-sns-wrap clearfix"></div>
									
									<article class="board-view text-center">
											<div class="btn-group">
							                    <button type="button" id="recommendation-btn" class="btn rcmdbtn" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="javascript:diaryRcmd(${diary.diaryId});">
							                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
							                            <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"></path>
							                        </svg>
							                        좋아요
							                    </button>
							                    <button type="button" class="btn rcmdbtn" id="rcmdCNT">
							                    		<fmt:formatNumber value="${diary.rcmdCnt}" pattern="###,###,###,###" />
							                    </button>
						                	</div>
										</article>
									
							</article>
							<article>
								  <!--  댓글 입력 창 시작 -->
						            <form name="comments-form" id="comments-form" action="./addDiaryComm" method="post">
							           	 <div class="card">
								                <div class="card-header">
								                
								                <!-- 댓글 로그인 시작 -->
								                 <c:choose>
							                        <c:when test="$ {id eq null }">
							                            <a class="btn btn-sm btn-info" href="./SignIn?idx=$ {cs.idx}" >로그인</a> <span style="width: 10px"></span> 
							                        </c:when>
						
							                        <c:otherwise>
							                            <p>$ {name}($ {id}) 님</p> <span style="width: 10px"></span> 
							                            <input type="hidden" name="idx" value="$ {cs.idx}">
							                            <input type="hidden" name="commenterId" value="$ {id}">
							                        </c:otherwise>
							                    </c:choose>
								                <!--  댓글 로그인 끝  -->   
								                </div>
								                <div style="width:100%;text-align:center;">
																      <div style="display:inline-block;width:50%;text-align: center;">
														
																			                     <div style="display:inline-block;width:50%;">
																			     
																									  <textarea class="form-control" name="comments" id="comments" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px; width:300px;float:right"></textarea>
																		
																								 </div>
																								 <div style="display:inline-block;">
																		
																									  <button class="btn btn-primary" type="button" id="comments-btn" style="height: 100px;float:left;" >댓글 달기</button>
																	
																								</div>	
																</div>	
								                </div>
								                
								            </div> 
								    </form>     
								    <br>   
						            <!--  댓글 입력 창 끝 -->
						            <div style="clear:both"></div>
						            <!--  댓글 반복문 시작  -->
						            <c:forEach items="${dcList}" var="cList" varStatus="status">
							            <div class="card">
							                <div class="card-header">
							                    ${cList.commenterId} 님
							                </div>
							                <div class="card-body">
							                    <blockquote class="blockquote mb-0">
							                        <p> ${cList.comments}</p>
							                        <footer class="blockquote-footer">
							                        	<cite title="Source Title"><fmt:formatDate value="${cList.postDate}" pattern="yyyy.MM.dd hh:mm:ss" /></cite>
							                        
							                         </footer>
							                    </blockquote>
							                </div>
							            </div> 
							            <br>
							        </c:forEach>    
						            <!--  댓글 반복문 끝  -->
							</article>
							<div class="btns txt-right">
								<button type="button" class="btn btn-style01" id="btnList">
									<i class="xi-bars"></i>목록
								</button>
									<button type="button" class="btn btn-style01" id="btnList">
									<i class="xi-bars"></i>수정
								</button>
									</button>
									<button type="button" class="btn btn-style01" id="btnList">
									<i class="xi-bars"></i>삭제
								</button>
								</button>
									<button type="button" class="btn btn-style01" id="btnList">
									<i class="xi-bars"></i>공유취소
								</button>
							</div>

							</div>
							
							</div>
    	</section>
    	<a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
	</main>
    <!-- footer -->
<jsp:include page="./sub/footer.jsp" />