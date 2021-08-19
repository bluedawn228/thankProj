<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./sub/header.jsp" />
<title>요리 자랑&nbsp;|&nbsp;기분 좋은 콘텐츠</title>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-53480561-1');
</script>
<script>

function pickedIDX(articleId) {
    //alert($(this));
    
	$.ajax({
          type: "GET",
          dataType: "text",
          url: "./CookingShowRecommendation",
          data: { idx : articleId  },

          // 전송 전 작업
          beforeSend: function() {},

          // 요청에 성공하면 함수 실행 data는 응답 데이터가 들어간다
          success: function(data, textStatus) {

              var innerId = "#recommendation-cnt-"+articleId ;
              //alert(data);
              if (textStatus == 'success') {
            	  $(innerId).text(data);

              };
          },

          // 응답이 종료되면 실행, 성공여부와 상관없이 ajax 완료후 작업 
          complete: function(data) {},

          // 에러가 났을 경우의 작업
          error: function(response, textStatus) {
              //$("#exampleModal").show();
              $(".modal-title").html("알림");
              $(".modal-body").html("오류가 발생했습니다.");

          }
      });
      return false; // 페이지 리로딩을 막는다. 
	
}

    $(document).ready(function() {
        $("#cookingshow-add-btn").click(function() {

            //alert("와따");
            location.href = "./chore-add-cooking";

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
		<div id="spot" class="sub6">
			<div id="snb">
				<h2 class="snb-title sr-only">요리 자랑</h2>
				<nav>
					<ul class="depth2" id="subNavi">
						</ul>
				</nav>
			</div>
			<div class="cont-top">


			</div>
		</div>
		<section class="cont-wrap horizontal">
			<h1 class="stitle">요리 자랑</h1>
			<div id="contents" class="container">
				<div class="cont-mid ">



	<div class="btns text-right">
			<a href="#" class="btn btn-style01" id="cookingshow-add-btn" >나도 자랑 하기</a>
		</div>
			<!-- 카이날리지 추가 -->
				<div class="page-count-wrap clearfix">
						<div class="page-count">
							<div class="page-total">총 <em>75</strong></em>건</div>
						</div>
						<div class="category-wrap">
							<div class="input-wrap">
								<input type="text" name="schText" id="schText" class="form-control" placeholder="검색어를 입력해 주세요" value="" title="검색어입력" />
								<button type="button" name="button" id="btnSearch" >
									<i class="xi-search"></i>
									<span class="hidden">검색하기</span>
								</button>
							</div>
						</div>
					</div>


	<ul class="pinterest-board pinterest-board02 clearfix imgcut row ">
					
					<!-- 카드 게시글 	 -->
					<c:forEach items="${csList}" var="List" varStatus="status">
					
					<li class="col-md-3 col-sm-6 col-xs-6 pinterest-board-img pinterest-item" style="border-radius:20px;">
					 	<a href="#" onclick="javascript:location.href='./CookingShowDetail?idx=${List.idx}'">
							<div class="img" style="overflow: hidden;">

								<img src="/uploads/cooking/${List.filename}" alt="${List.title}" class="photo"  onclick="javascript:location.href='./CookingShowDetail?idx=${List.idx}'" /> 

							</div> <!-- img -->
							<div class="txt">
								<strong>${List.name} 님(${List.authorid}) <br> ${List.title}</strong>
								
								
                                        
								<div class="tag-time">
									
										<small class="text-muted">
                                            <fmt:formatDate value="${List.postdate}" pattern="yyyy.MM.dd" />
                                            <c:choose>
                                                <c:when test="${List.modifydate ne null }">
                                                    (
                                                    <fmt:formatDate value="${List.modifydate}" pattern="yyyy.MM.dd" />)
                                                </c:when>
                                            </c:choose>


                                        </small>
									
									</div>
									<div style="display:inline-box;float:right;">        
                                             <fmt:formatNumber value="${List.recommendation}" pattern="###,###,###,###" />
                          			</div>       
									<div style="display:inline-box;float:right;margin-right:10px;">
                                            <div  id="recommendation-btn"  data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="javascript:pickedIDX(${List.idx});">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
												  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"></path>
												</svg>
                                                좋아요
                                            </div>
                                     </div>       
                                    
                         
							</div> <!-- txt -->
						</a>
					</li>
					  </c:forEach>
					
					
				</ul>

	<div class="btns txt-center">
			<button id="more" type="button" class="pinterest-more-btn" onclick='javascript:fnMoreView();'>
				<i class="xi-angle-down-min"></i>더보기
			</button>
		</div>
</div>
    	</section>
    	<a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
	</main>
    <!-- footer -->
<jsp:include page="./sub/footer.jsp" />
