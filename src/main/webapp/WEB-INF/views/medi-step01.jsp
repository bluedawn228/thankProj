<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="./sub/header.jsp" />
<title>감사명상 일기&nbsp;|&nbsp;감사명상</title>

<style>
.tb-emotion{
	text-align : center;
	
}
.tb-emotion td {
	padding:20px;
}
.tb-emotion td span {
	font-size:60px;
}


.emoticon_wrapper {
width:100%;
margin: 0 auto;
text-align : center;
}
.emoticon {
	font-size:60px;
}

.emoticon.selectionE {
	transform: scale(1.5);
}

.selectionM {
	transform: scale(1.5);
	box-shadow: 5px 10px 10px rgba(0, 0, 0, .6);
}

.tag{
	width:auto;
	height : 30px;
	border : 1px solid #eee;
	border-radius : 10px;
	background : white;
	color : #000;
	text-align : center;
	font-weight:400;
}

#bg-upload {
	width:80%;
	font-size: 20px;
	vertical-align : middle;
	border:none;
}


.postit {
  font-family: 'Open Sans Condensed';
  font-size: .9em;
  position: absolute;
  padding: 20px 15px;
  top: 10px;
  left: -120px;
  background: #FCF0AD;
  
  width: 150px;
  height: 150px;
  z-index: 5;
  transform: rotate(6deg);
  box-shadow: -1px 1px 7px rgba(0, 0, 0, .6);
}

.postit-title{
  margin: .1em 0;
  font-family: 'Open Sans Condensed', sans-serif;
  font-weight: 700;
  font-size: 1.5em;
  letter-spacing: -2px;
  text-transform: uppercase;
  text-align: center;
  color: #746e5e;
  text-shadow: 1px 1px 1px #fff, -1px 0px 0px rgba(0,0,0,.5);
}
.video-wrapper{
	width:100%;
	text-align: center;
}

.video-area{
	margin: 0 auto;
	display:inline-block;
}

.paper-area {
	margin: 0 auto;
	-webkit-font-smoothing: antialiased;
	font-smoothing: antialiased;
	box-sizing: border-box; 
}

.step02 img:active {
	box-shadow:5px 5px 5px 5px;
}
.step03 {
	background-image:url(https://raw.github.com/subtlepatterns/SubtlePatterns/gh-pages/retina_wood.png);
  	background-attachment:fixed;
}

#type {
  text-transform: uppercase;
  font-size: 1.2em;
  margin-top: 20px;
  margin-left: 12px;
  padding: 5px 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  cursor: pointer;
  background: #f2c730;
  background: -webkit-linear-gradient(top, #f2c70a 0%,#eaac0b 100%);
  font-family: 'Open Sans Condensed';
}
#type:hover {
  background: #eaac0b;
}

.notebody {
	position: relative;
	background-color: #f5f5f5;
	width: 50%;
	margin: 50px auto;
	padding: 0;
	filter: drop-shadow(5px 5px 5px grey);
}

.notelist {
	color: #555;
	font-size: 18px;
	padding: 0 !important;
	width: 100%;
	font-family: courier, monospace;
	border: 1px solid #dedede;
}

.notelist li {
	list-style: none;
	border-bottom: 1px dotted #ccc;
	text-indent: 25px;
	line-height: 18px;
	height: auto;
	padding: 10px;
	text-transform: capitalize;
}

.notelist li:hover {
	background-color: #f0f0f0;
	-webkit-transition: all 0.2s;
	-moz-transition: all 0.2s;
	-ms-transition: all 0.2s;
	-o-transition: all 0.2s;
}

.notelines {
	border-left: 1px solid #ffaa9f;
	border-right: 1px solid #ffaa9f;
	width: 2px;
	float: left;
	height: 390px;
	margin-left: 40px;
}

.noteformwrapper {
	position: absolute;
	width: 100%;
	height: 100%;
	margin: 0 auto;
	padding: 0;
}

.content {
	width: 100%;
	border: 0px;
	height: 390px;
	font-size: 18px;
	line-height: 215%;
	padding-top: 0px;
	padding-left: 48px;
	overflow-x: hidden;
	margin-top:px;
	background-color: transparent;
}

</style>
<script>

$(document).ready(function(){
	const emoticons = document.querySelectorAll('.emoticon');
	emoticons.forEach(emoticon => {
		emoticon.addEventListener('click', () => {
			resetEmoticons()
			emoticon.classList.add('selectionE')
	    })
	});

	function resetEmoticons() {
	    emoticons.forEach(emoticon => {
	        emoticon.classList.remove('selectionE')
	    });
	}
	
	
	const medies = document.querySelectorAll('.medi');
	medies.forEach(medi => {
		medi.addEventListener('click', () => {
			resetMedies()
			medi.classList.add('selectionM')
	    })
	});

	function resetMedies() {
		medies.forEach(medi => {
			medi.classList.remove('selectionM')
	    });
	}
	
});

function selectEmotion(num,econ) {
	//alert(num);
	$("#selectedEmotion").val(num);
	$("#diaryEmoticon").text(econ);

}

function selectMedi(num) {
	//alert(num);
	$("#selectedMedi").val(num);

}

function showNext(step) {

	
	if (step == "step01") {
			var em = $("#selectedEmotion").val();
			if (em == null || em == "") {
				alert("오늘의 감정을 선택해주세요");
			} else {
				$(".step01").hide();
				$(".step02").show();
			}
	} else if (step == "step02"){
		var md = $("#selectedMedi").val();
		
		if (md == null || md == "") {
			alert("명상 영상을 선택해주세요");
			return;
		} else {
			$(".step02").hide();
			$(".step03").show();
			$("#player").empty();
		}
		  
	   	  
	      // 2. This code loads the IFrame Player API code asynchronously.
	      var tag = document.createElement('script');

	      tag.src = "https://www.youtube.com/iframe_api";
	      var firstScriptTag = document.getElementsByTagName('script')[0];
	      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
		
	} else if (step == "step03"){
		$(".step03").hide();
		$(".step04").show();
		
		
		
	} else if (step == "step04"){
		var lasttottime = $("#mediPlayTime").val();
		if( lasttottime == null || lasttottime =="" ){
			lasttottime= new Date().getTime() - starttime;
			($("#mediPlayTime").val(lasttottime))
		}
			
		alert($("#mediPlayTime").val());
		$("#mediForm").submit();
		//alert("1");
	}

}


function showPrevious(step) {
	
	if (step == "step02") {
		$(".step02").hide();
		$(".step01").show();
	} else if (step == "step03") {
		$(".step03").hide();
		$(".step02").show();
	}
	
}
var gKey;
var tottime = 0;
var starttime ;


function mediSelection(key){
	gKey=key;
	//$(this).css('box-shadow','5px 10px 10px 5px');
	$("#selectedMedi").val(key);
	//$("#mediFrame").empty();
	//$("#mediFrame").append(
	//	'<iframe width="560" height="315" src="https://www.youtube.com/embed/'+key+' " title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' 
	//);
	

     
}

// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '360',
    width: '640',
    videoId: gKey,
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
  event.target.playVideo();
}

// 5. The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;
function onPlayerStateChange(event) {
/*   if (event.data == YT.PlayerState.PLAYING && !done) {
    setTimeout(stopVideo, 6000);
    done = true;
  } */
  
  if (event.data == YT.PlayerState.PLAYING ) {
      	starttime = new Date().getTime();

    } else if (event.data == YT.PlayerState.PAUSED ) {
  	  	tottime += new Date().getTime() - starttime;
  	  	 $("#mediPlayTime").val(tottime);
  	  	alert(typeof tottime);
    } else if  (event.data == YT.PlayerState.ENDED ) {
  	    tottime += new Date().getTime() - starttime;
  	    $("#mediPlayTime").val(tottime);
  	    console.log(tottime);
    }
} 
function stopVideo() {
  player.stopVideo();
}

function unicodeToChar(text){
	   return text.replace(/\\u[\dA-F]{4}/gi, function(match){
	      return String.fromCharCode(parseInt(match.replace(/\\u/g, ''), 16));});
	}
</script>

  <script>
  
 
    </script>

<style>
.toggleArea .tit{display:inline-block;vertical-align:middle;margin:0 2px 2px 0}
.toggleArea .switch {position: relative;display: inline-block;width: 60px;height: 30px;vertical-align:middle;margin:0}
.toggleArea input {color : white; z-index:9999}
.toggleArea .switch input {display:none;}
.toggleArea .slider {display:inline-block;position: absolute;cursor: pointer;top: 0;left: 0;right: 0;bottom: 0;background-color: #ccc;border-radius:30px;-webkit-transition: .4s;transition: .4s;}
/*.toggleArea .slider:before {position: absolute;content: "";height: 26px;width: 26px;left: 2px;bottom: 2px;background-color: white;-webkit-transition: .4s;transition: .4s;}*/
.toggleArea .slider:before {position: absolute;content: "";height: 0;width: 0;left: 2px;bottom: 2px;-webkit-transition: .4s;transition: .4s;}
.toggleArea input:focus + .slider {box-shadow: 0 0 1px #2196F3;}
.toggleArea input:checked + .slider{background:#00bd85}
.toggleArea input:checked + .slider:before{-webkit-transform: translateX(30px);-ms-transform: translateX(30px);transform: translateX(30px);}
/* Rounded sliders */
.toggleArea .slider.round{border-radius:30px;    }
.toggleArea .slider.round:before{border-radius:50%;}
.toggleArea p{display:inline-block;width:40px;font-size:15px;font-weight:bold;color:#ccc;vertical-align:middle;margin:0 0 2px 0}
.toggleArea p.on{color:#019a6d}
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
			<h1 class="stitle">감사명상 일기 작성</h1>
			<div id="contents" class="container">
				<div class="cont-mid ">
					<div class="">
						
						<div class="web step01">
							<section class="txt">
							<h2 ><strong>오늘 기분은 어떠셨나요?</strong></h2>
							</section>
							<table class="tb-emotion">
								<tr class="tr-emotion">
									<td><div class="emoticon" onclick='javascript:selectEmotion(1,"&#128525;");'>&#128525;</div><br>행복함</td>
									<td><div class="emoticon "  onclick='javascript:selectEmotion(2,"&#128523;");'>&#128523;</div><br>신이남</td>
									<td><div class="emoticon "  onclick='javascript:selectEmotion(3,"&#128524;");'>&#128524;</div><br>감사함</td>
								</tr>
								
								<tr class="tr-emotion">
									<td><div class="emoticon"  onclick='javascript:selectEmotion(4,"&#128578;");'>&#128578;</div><br>차분함</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(5,"&#128538;");'>&#128538;</div><br>만족함</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(6,"&#128564;");'>&#128564;</div><br>피로</td>
								</tr>
								
								<tr class="tr-emotion">
									<td><div class="emoticon"  onclick='javascript:selectEmotion(7,"&#128551;");'>&#128551;</div><br>불확실함</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(8,"&#128554;");'>&#128554;</div><br>지루함</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(9,"&#128552;");'>&#128552;</div><br>불안함</td>
								</tr>
								<tr class="tr-emotion">
									<td><div class="emoticon"  onclick='javascript:selectEmotion(10,"&#128545;");'>&#128545;</div><br>분노</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(11,"&#128548;");'>&#128548;</div><br>스트레스 받음</td>
									<td><div class="emoticon"  onclick='javascript:selectEmotion(12,"&#128557;");'>&#128557;</div><br>슬픔</td>
								</tr>								
							</table>
							
							<div class="btns text-center">
								<a href="#" class="btn btn-style01" onClick='showNext("step01")'><span>다음</span> </a>
							</div>
							
						</div><!--//web-->
						
						<div class="web step02" style="display:none;">
							<ul class="signature row">
								<li class="col-xs-12 col-sm-6">
									<section style="padding-left:150px;;width:100%;border:none;height:50px;"><h2 ><strong>컨셉별 명상음악</strong></h2></section>
									<table>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/AtLmxxnfFAI/mqdefault.jpg" width="100%" height="200px"  onclick="mediSelection('AtLmxxnfFAI');">
										</td>
										<td>
											잔잔한 명상음악
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/21KEonvUpj4/mqdefault.jpg" width="100%" height="200px" onclick="mediSelection('21KEonvUpj4');">
										</td>
										<td>
											경쾌한 명상음악
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/iLfbs7eV9dA/mqdefault.jpg" width="100%" height="200px"  onclick="mediSelection('iLfbs7eV9dA');">
										</td>
										<td>
											산뜻한 명상음악
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/2N4eTTipm9I/mqdefault.jpg" width="100%" height="200px"  onclick="mediSelection('2N4eTTipm9I');">
										</td>
										<td>
											웅장한 명상음악
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/hlWiI4xVXKY/mqdefault.jpg" width="100%" height="200px"  onclick="mediSelection('hlWiI4xVXKY');">
										</td>
										<td>
											평온한 명상음악
										</td>
									</tr>
	
									</table>
								</li>
								<li class="col-xs-12 col-sm-6">
									<section style="padding-left:150px;;width:100%;border:none;height:50px;"><h2 ><strong>기분별 명상음악</strong></h2></section>
									<table>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/pRDCtT-uOOQ/mqdefault.jpg" width="100%" height="200px" onclick="mediSelection('pRDCtT-uOOQ');">
										</td>
										<td>
											스트레스 받을 때
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/su14Bo0-uMI/mqdefault.jpg" width="100%" height="200px" onclick="mediSelection('su14Bo0-uMI');">
										</td>
										<td>
											우울할 때
										</td>
									</tr>
									<tr>
										<td>
										<img class="medi" src="https://img.youtube.com/vi/su14Bo0-uMI/mqdefault.jpg" width="100%" height="200px" onclick="mediSelection('su14Bo0-uMI');">
										</td>
										<td>
											불안할 때
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/-bGZS8wr-mU/mqdefault.jpg" width="100%" height="200px"  onclick="mediSelection('-bGZS8wr-mU');">
										</td>
										<td>
											화가날 때
										</td>
									</tr>
									<tr>
										<td>
											<img class="medi" src="https://img.youtube.com/vi/HJ17Oc9I2R8/mqdefault.jpg" width="100%" height="200px" onclick="mediSelection('HJ17Oc9I2R8');">
										</td>
										<td>
											무기력할 때
										</td>
									</tr>
	
									</table>
								</li>
							</ul>
							<div class="btns text-center">
								<a href="#" class="btn btn-style02" onClick='showPrevious("step02")'><span>이전</span> </a>
								<a href="#" class="btn btn-style01" onClick='showNext("step02")'><span>다음</span> </a>
							</div>
						</div>	
 							
						<form name="mediForm" id="mediForm" action="/medi-step02" method="post">
						<section class="web step03" style="display:none;">
							<ul class="signature row">
								<li class="col-xs-12 col-sm-12">
									<!-- 	비디오 플레이어 -->
									<section class="video-wrapper"  >
										<section class="video-area"  id="player"></section>
									</section>
	
									
									   
									
									<section class="paper-area">
										<section class="emoticon_wrapper">
											<span id="diaryEmoticon" class="emoticon"></span>
										</section>
										<section>
											<!-- <img class="pen" src="http://www.mofanning.com/imgs/ink_pen.png"/> -->
												<p class="postit-title">&mdash;오늘의 감사 내용을 적어 보세요&mdash;</p>
												<section class="stack">
												  <section class="postit">
												    <p>음성으로 작성하기</p>
												    <button id="type">녹음</button>
												  </section>
												  
												   <section class="notebody">

									                <section class="noteformwrapper">

									                        <textarea class="content"  name="content" id="" title="" placeholder="마음을 전하세요" value=""></textarea>
									     
									                </section>
		
									                <section class="notelines"></section>
									
									                <ul class="notelist" id="List">
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                    <li>&nbsp;</li>
									                </ul>
									
									            </section>
											</section>	
									
									<section class="tag-wrapper text-center" style="margin: 30px 0;">
										
										<section class="toggleArea"><!--<span class="tit">자동갱신</span>  -->
											<!-- <input id="toggleAuto" type="checkbox" checked data-toggle="toggle" data-style="ios"> -->
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="일" />
											<span class="slider round">일</span> 
											</label>
											<!-- <p style="display:none;">OFF</p><p class="on">ON</p> -->
									
											<!-- <input id="toggleAuto" type="checkbox" checked data-toggle="toggle" data-style="ios"> -->
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="학교" />
											<span class="slider round">학교</span> 
											</label>
											<!-- <p style="display:none;">OFF</p><p class="on">ON</p> -->
									
											<!-- <input id="toggleAuto" type="checkbox" checked data-toggle="toggle" data-style="ios"> -->
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="가족" />
											<span class="slider round">가족</span> 
											</label>
											<!-- <p style="display:none;">OFF</p><p class="on">ON</p> -->
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="친구" />
											<span class="slider round">친구</span> 
											</label>
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="여행" />
											<span class="slider round">여행</span> 
											</label>
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="자기 돌봄" />
											<span class="slider round">자기 돌봄</span> 
											</label>
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="관계" />
											<span class="slider round">관계</span> 
											</label>
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="음식" />
											<span class="slider round">음식</span> 
											</label>
											
											<label class="switch">
											<input id="toggleAuto" name="tags"  type="checkbox" value="건강" />
											<span class="slider round">건강</span> 
											</label>
											
											
										</section>	
									</section>
									
									
									<section class="file-wrapper text-center"  style="margin: 30px 0;">
										<input type="file" id="bg-upload">
									</section>	
									</section>
									</section>
								</li>
								
							</ul>
							
							<input type="hidden"  id="selectedEmotion" name="emcId" value="">
							<input type="hidden" id="selectedMedi" name="mvId" value="">
							<input type="hidden" id="userId" name="author" value="test">
							<input type="hidden" id="mediPlayTime" name="mvDrt" >
						
							
							<div class="btns text-center">
								<!-- <a href="#" class="btn btn-style02" onClick='showPrevious("step03")'><span>이전</span> </a> -->
								<a href="#" class="btn btn-style01" onClick='showNext("step03")'><span>다음</span> </a>
							</div>
						</section>	
 						</form>
							
 							<div class="web step04" style="display:none;">
							<ul class="signature row">
								<li class="col-xs-12 col-sm-12">
									<section class="txt">
											<h2 ><strong>이렇게 긍정적인 기분을 인지한 나 자신에게 감사해보세요</strong></h2>
									</section>
									<section class="txt">
											<h2 ><strong>감사 노트 기록</strong></h2>
											<p>감사하는 습관은 긍정적인 마음을 갖게 해주고 힘든 시기를 이겨낼 수 있는 회복 탄력성을 길러줍니다.</p>
											
									</section>
									
								</li>
								
							</ul>
							
							<div class="btns text-center">
								<a href="#" class="btn btn-style01" onClick='showNext("step04")'><span>결과 확인하기</span> </a>
							</div>
						</div>		
 							
 							


							
						<div class="pad">
	
						</div><!--//mobile-->
					</div></div>

<script>

$(document).ready(function(){
    $("iframe").load(function(){
        $(this).contents().on("mousedown, mouseup, click", function(){
            alert("Click detected inside iframe.");
        });
    });
});


</script></div>
    	</section>
    	<a href="#uppermost" class="go-top"><i class="xi-arrow-up"></i><span class="sr-only">페이지 맨위로 이동</span></a>
	</main>
    <!-- footer -->
<jsp:include page="./sub/footer.jsp" />
