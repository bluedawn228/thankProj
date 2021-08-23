/*-------------------------------------------------
Common Javascript
Version : 1.0
author : choi tae-seok
create date : 2014. 08. 19.
last update : 2014. 08. 19.
-------------------------------------------------*/

/* ie 버그로 인하여 강제로 탭키 가도록 설정
-------------------------------------------------*/ 
jQuery(document).ready(function(){
	if(is_IE()){ 
		jQuery("#gnb").prop("tabindex", "0");
		jQuery("#main").prop("tabindex", "0");
		jQuery("#contents").prop("tabindex", "0");
	 }
}); 
// IE 인지를 반환(IE 라면 true 아니면 false)
function is_IE() {
	if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || navigator.appName.charAt(0) == "M"){
		return true ;
	}else{
		return false ;
	}
} 

 /*********************************************************************
  * 팝업 호출
  *
  * 사용 : gfnOpenWin("url", "name", "style", 100, 200);
  * 입력 : 호출url, 팝업이름, 스타일지정시, width값, height값
 **********************************************************************/
function gfnOpenWin(href,name,strStyle,width,height)
{
	var sleft = (screen.width - width) / 2;
	var stop = (screen.height - height) / 2;

	var style = "left="+sleft+",top="+stop+",width="+width+",height="+height+","+strStyle;
	window.open(href,name,style);
}

 /*********************************************************************
  * 사이트 콤보 조회 함수
  *
  * 사용 : gfnSiteComboList($("#siteId"), "all", "전체", "SITE00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnSiteComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listSite",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();

 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}

 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.SITEID, text: item.KNAME
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect);
 			}
 		}
 	});
 }

 /*********************************************************************
  * 사이트 콤보 조회 함수 - 권한이 있는 사이트만 조회
  *
  * 사용 : gfnSiteAdminComboList($("#siteId"), "all", "전체", "SITE00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnSiteAdminComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listAdminSite",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();

 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}

 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.SITEID, text: item.KNAME
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect);
 			}
 		}
 	});
 }

 /*********************************************************************
  * 코드 콤보 조회 함수
  *
  * 사용 : gfnCodeComboList($("#"), "SearchType", "all", "전체", "1", "900D");
  * 입력 : selectObject, higherCode, 기본값사용시 value, 기본값사용시 text, 선택 할 value, 제외시킬 값 기준+Up/Down(null 처리 가능)
  **********************************************************************/
 function gfnCodeComboList(selectObject, strHigh, strValue, strText, strSelect, strRange){

	 var condition = null;
	 var strVal = null;

	 if(strRange != null && strRange != "" && typeof strRange != "undefined"){
		 condition = strRange.substring(strRange.length-1, strRange.length);
		 strVal = strRange.substring(0, strRange.length-1);
	 }

	 $.ajax({
		 url: gContextPath+"/mgr/listCode",
		 data: "higherCode="+strHigh,
		 async: false,
		 success:function(data, textStatus, jqXHR) {
			 selectObject.find("option").remove();

			 if(strText != "" && strText != null){
				 selectObject.append($("<option>", {
					 value:strValue, text: strText
				 }));
			 }

			 if(data != null) {
				 $.each(data, function(i, item) {

					 // &amp; 기호 치환
					 if(item.KNAME.indexOf('&amp;') > 0){
						 item.KNAME = item.KNAME.replace('&amp;', '&');
					 }

					 if(condition == null || condition == ""){
						 selectObject.append($("<option>", {
							 value: item.CODE, text: item.KNAME
						 }));
					 } else {
						 if(condition == 'U'){
							 if(item.code >= strVal){
								 selectObject.append($("<option>", {
									 value: item.CODE, text: item.KNAME
								 }));
							 }
						 }else{
							 if(item.code < strVal){
								 selectObject.append($("<option>", {
									 value: item.CODE, text: item.KNAME
								 }));
							 }

						 }
					 }
				 });
			 }

			 if(strSelect != "" && strSelect != null){
				 selectObject.val(strSelect);

				 if(selectObject.val() == null){
					 selectObject.val(strValue);
				 }

				 //selectObject.selectmenu("refresh");
			 }
		 }
	 });
 }


 /*********************************************************************
  * 코드 조회 함수
  *
  * 사용 : gfnCodeList("SearchType", "all", "전체", "1", "900D");
  * 입력 : selectObject, higherCode, 기본값사용시 value, 기본값사용시 text, 선택 할 value, 제외시킬 값 기준+Up/Down(null 처리 가능)
  **********************************************************************/
 function gfnCodeList(strHigh){
	 var codeData;
	 $.ajax({
		 url: gContextPath+"/mgr/listCode",
		 data: "higherCode="+strHigh,
		 async: false,
		 success:function(data, textStatus, jqXHR) {
			 if(data != null) {
				 codeData = data;
			 }
		 }
	 });

	 return codeData;
 }

 /*********************************************************************
  * 카테고리 콤보 조회 함수
  *
  * 사용 : gfnCateComboList($("#"), "BOARD00002", "all", "전체", "1");
  * 입력 : selectObject, boardId, 기본값사용시 value, 기본값사용시 text, 선택 할 value
  **********************************************************************/
 function gfnCateComboList(selectObject, strMenuId, strValue, strText, strSelect){
	 $.ajax({
		 url: gContextPath+"/mgr/listCate",
		 data: "boardId="+strMenuId+"&menuId="+strMenuId,
		 cache: false,
		 success:function(data, textStatus, jqXHR) {
			 selectObject.find("option").remove();

			 if(strText != "" && strText != null){
				 selectObject.append($("<option>", {
					 value:strValue, text: strText
				 }));
			 }

			 var text = "";
			 if(data != null) {
				 $.each(data, function(i, item) {
					 selectObject.append($("<option>", {
						 value: item.CATEGORYID, text: item.CATEGORYNAME
					 }));

					 // 셀렉트 text
					 if(strSelect != "" && strSelect != null){
						 if(strSelect == item.CATEGORYID) text = item.CATEGORYNAME;
					 }
				 });
			 }

			 if(strSelect != "" && strSelect != null){
				 selectObject.val(strSelect);
				 // 셀렉트box 스타일 적용에 경우
				 selectObject.next('span').children('.ui-selectmenu-text').text(text);
			 }

		 }
	 });
 }

 /*********************************************************************
  * 그룹 콤보 조회 함수
  *
  * 사용 : gfnGroupComboList($("#groupId"), "", "그룹 선택", "GROUP00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnGroupComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listGroup",
 		cache: false,
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();

 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}
 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.GROUPID, text: item.KNAME
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect);
 			}
 		}
 	});
 }

 /**************************************************************************************************************
  * 회원정보조회 팝업
  *
  * 사용 : gfnMemberPopupList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M']
  **************************************************************************************************************/
 function gfnMemberPopupList(kindType, outDataForm, type){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }

 /**************************************************************************************************************
  * 회원정보조회 팝업 멀티출력
  *
  * 사용 : gfnMemberPopupMultiList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M'], parentInputId
  **************************************************************************************************************/
 function gfnMemberPopupMultiList(kindType, outDataForm, type, parentInputId){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&parentInputId="+parentInputId+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }

 /**************************************************************************************************************
  * 통합VOC 담당자 조회 팝업 멀티출력
  *
  * 사용 : gfnMemberPopupMultiList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M'], parentInputId, parentInputName
  **************************************************************************************************************/
 function gfnVocMemberPopupMultiList(kindType, outDataForm, type, parentInputId, parentInputName){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&parentInputId="+parentInputId+"&parentInputName="+parentInputName+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }

 /*********************************************************************
  * 전체선택함수
  *
  * 사용 : selectAll($("#"), "seq");
  * 입력 : selectObject, 선택되게할 Name
  **********************************************************************/
function selectAll(selectObject, ckName){
	 if (selectObject.is(":checked")) {
		 $("input[name='"+inputName+"']:checkbox").prop("checked", true);
	 } else {
		 $("input[name='"+inputName+"']:checkbox").prop("checked", false);
	 }
}

/*********************************************************************
 * gfnSelectAllCalss 전체선택함수 -- input에 class명으로 체크
 *
 * 사용 : gfnSelectAllCalss($("#"), "calss");
 * 입력 : selectObject, 선택되게할 Name
 **********************************************************************/
function gfnSelectAllCalss(className, bChk){
	$("."+className).prop("checked", bChk);
}

/********************************************************************************************************
 * gfnCodeCheckList 코드 체크박스 조회함수
 *
 * 사용 : gfnCodeCheckList($("#"), "interest", "interest", strCheckList);
 * 입력 : 체크박스가 추가될 위치 selectObject, higherCode, 체크박스 이름, 체크될 값 배열(null 가능)
 *******************************************************************************************************/
function gfnCodeCheckList(selectObject, strHigh, ckName, strCheckList){
    $.ajax({
        url: gContextPath+"/mgr/listCode",
        data: "higherCode="+strHigh,
        async: false,
        success:function(data, textStatus, jqXHR) {

        	selectObject.find("input").remove();
        	selectObject.find("label").remove();

        	if(data != null) {
	        	$.each(data, function(i, item) {
	        		if(strCheckList == null || strCheckList == ""){
	    					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.CODE+"' />").appendTo(selectObject);
	        				$("<label for='"+ckName+i+"'>"+item.KNAME+"</label>").appendTo(selectObject);

		        	} else {
	        				if(strCheckList[i] == item.CODE ){
	        					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.CODE+"' checked='checked' />").appendTo(selectObject);
	        				} else{
	        					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.CODE+"' />").appendTo(selectObject);
	        				}
	        				$("<label for='"+ckName+i+"'>"+item.KNAME+"</label>").appendTo(selectObject);
		        	}
	        	});
        	}
        }
    });
}

/********************************************************************************************************
 * gfnCodeCheckList2 코드 체크박스 조회함수 ('#'구분자로 나누어진 코드데이터값을 코드값과 매칭하여 체크박스 생성 및 체크여부 처리하여 제공)
 *
 * 사용 : gfnCodeCheckList2($("#"), "interest", "interest", strCheckList);
 * 입력 : 체크박스가 추가될 위치 parentObject, higherCode, 체크박스 이름, 체크될 값 배열(null 가능)
 *******************************************************************************************************/
function gfnCodeCheckList2(parentObject, higherCode, inputName, rawData){
	var rawDatas = fnStrSplit(rawData, "#");
	var html = "";

	$.ajax({
        url: gContextPath+"/mgr/listCode",
        data: "higherCode="+higherCode,
        async: false,
        cache: false,
        success:function(codeList, textStatus, jqXHR) {

        	parentObject.find("input").remove();
        	parentObject.find("label").remove();

        	if(codeList != null) {
        		for (var i = 0; i < codeList.length; i++) {
        			var check = "";
        			for (var j = 0; j < rawDatas.length; j++) {
        				if(codeList[i].CODE == rawDatas[j]){
        					check = " checked='checked'";
        				}
        			}
        			html += "<input type='checkbox' id='"+inputName+i+"' name='"+inputName+"' value='"+codeList[i].CODE+"'"+check+"/><label for='"+inputName+codeList[i].CODE+"'>"+codeList[i].KNAME+" </label>";
        		}
        	}
    		 $(parentObject).append(html);
        }
    });
}

/**************************************************************************************************************
 * 이미지풀조회 팝업
 *
 * 사용 : gfnImagePoolPopupList("kindType", "outDataForm", "type")
 * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M']
 **************************************************************************************************************/
function gfnImagePoolPopupList(keyword1){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listImagePoolPopup?menuId=MENU01301&=schType=0&schText=" + keyword1, "이미지풀정보", "scrollbars=no, width=700, height=570");
	 //[운영메뉴ID:MENU01301] MENU01212
}

/*******************************************************************************
 * [ Validate ] 숫자만 입력
 *
 * 입력 : 폼 객체 허용 : 0~9 사용 : onkeyup="validateOnlyNumber(this)"
 ******************************************************************************/
function validateOnlyNumber(from) {
	for ( var i = 0; i < from.value.length; i++) {
		var str = from.value.charCodeAt(i);
		if (str < 48 || str > 57) {
			// alert("숫자만 입력하실수 있습니다. ");
			from.value = from.value.replace(from.value.charAt(i),"");
			// from.select(); //내용선택
			return false;
		}
	}
	return true;
}

function validateCheckSpecialChar(from)
{
	 var num ="{}[]()<>?|~`!@#$%^&*+\"'\\/ ";    //입력을 막을 특수문자 기재.

	 for (var i=0; i<from.value.length; i++)
	 {
		 if(-1 != num.indexOf(from.value.charAt(i))){
			 alert("특수문자는 입력하실 수 없습니다.");
			 from.value =  from.value.replace(from.value.charAt(i),"");
			 return false;
		 }
	 }

	 return true;
}

/*******************************************************************************
 * fnStrSplit 문자 자르는 함수
 *
 * 사용 : fnStrSplit("1###2", "###");
 * 입력 : str, 자를 문자열
 ******************************************************************************/
function fnStrSplit(str, strSplit) {
	var s = str;
	var arrayString;

	arrayString = s.split(strSplit);

	return arrayString;
}

/*******************************************************************************
 * 선택된 체크박스에 패턴추가 함수
 *
 * 사용 : gfnRtSelectCheck(chkName, pattern);
 * 입력 : 체크박스 이름, 선택값 뒤 추가될 패턴
 ******************************************************************************/
function gfnRtSelectCheck(chkName, pattern){
	var patternLen = pattern.length;
	var result="";
	var isCount = 0;

	$('input:checkbox[name="'+chkName+'"]').each(function(){
	    if(this.checked){
	    	isCount ++;
	        result = result + this.value + pattern;
	    }else{
	        result = result + pattern;
	    }
	});

	return result.substring(0, result.length-patternLen);
}

/* 입력 버튼 클릭시 */
function gfnReplyInsert(selectObject, linkId){
	var text = selectObject.val();
	$('#replyArea').val("");
	var param = {linkId : linkId, inCondition : "입력", replyDesc : text };

	$.ajax({
		type : "POST",
		async : false,
		url: gContextPath+"/mgr/contentMgr/replyAct",
		data: param,
		success:function(data, textStatus, jqXHR) {
			if(data == "NOUSER"){
				alert("로그인이 필요합니다.");
				location.reload();
			}else{
				gfnReplyList($('#reply'), linkId);
			}
	    }
    });
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 삭제
 *
 * 사용 : gfnReplyDelete(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyDelete(replyId, linkId){

	var param = {replyId : replyId, inCondition : "삭제", linkId : linkId };
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			type : "POST",
			async : false,
			url : gContextPath+"/mgr/contentMgr/replyAct",
			data : param,
			success:function(){
				var count = $('li[value='+replyId+']').parent().parent().find('#replyCount').text();
				$('li[value='+replyId+']').parent().parent().find('#replyCount').text(count-1);
				$('li[value='+replyId+']').remove();
			}
		});
	}
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 수정 폼 생성
 *
 * 사용 : gfnReplyUpdate(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyUpdate(replyId, linkId){

	var txt = $('li[value='+replyId+'] > p').html();
	txt = replaceAll(txt, "<br>", "\n");


	$('li[value='+replyId+'] > p').remove();
	$('li[value='+replyId+']').append('<textarea id="editArea" style="width:100%; height: 56px; min-width: 643px;">');
	$('li[value='+replyId+'] > #editArea').html(txt);

	/*
	//저장 버튼 추가 할 시
	$('li[value='+replyId+']').append('<button type="button">');
	$('li[value='+replyId+'] > button').text("저장");
	*/

	var script = "javascript:gfnReplyUpdateAct("+replyId+","+linkId+")";
	$('li[value='+replyId+'] > div > .btn > button[value=modify]').attr('onclick', script);
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 수정 처리
 *
 * 사용 : gfnReplyUpdateAct(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyUpdateAct(replyId, linkId){
	var text = $('#editArea').val();

	var param = {'linkId' : linkId, 'replyId' : replyId, 'inCondition' : "수정", 'replyDesc' : text };

	$.ajax({
		type : "POST",
		async : false,
		url: gContextPath+"/mgr/contentMgr/replyAct",
		data: param,
		success:function(data, textStatus, jqXHR) {
			if(data == "NOUSER"){
				alert("로그인이 필요합니다.");
				location.reload();
			}else{
				$('li[value='+replyId+'] > textarea').remove();

				$('li[value='+replyId+']').last().append('<p>');
				var str = text;
				str = replaceAll(str, "\n", "<br />");
				$('li[value='+replyId+'] > p').last().html(str);
			}
			//gfnReplyList($('#reply'), linkId);
	    }
    });

	var script = "javascript:gfnReplyUpdate("+replyId+","+linkId+")";
	$('li[value='+replyId+'] > div > .btn > button[value=modify]').attr('onclick', script);
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 리스트 가져오기
 *
 * 사용 : gfnReplyList(selectObject, linkId)
 * 입력 : 추가될 위치, 현재 글 linkId
 ******************************************************************************/
function gfnReplyList(selectObject, linkId){
	selectObject.empty();
    $.ajax({
        url: gContextPath+"/mgr/contentMgr/replyList",
        data: "linkId="+linkId,
        success:function(data, textStatus, jqXHR) {

            if(data != null) {
            	selectObject.parent().find('#replyCount').text(data.length);

                $.each(data, function(i, item) {
                	var html = "";
                	html += '<li value='+item.replyId+'>';
                	html += '<p class="reply-info"><span class="writer">'+item.dmlUserName+'</span>'+item.insTime;
                	if(item.isMyReply == "Y"){
                		/*selectObject.append('<button type="button" value="modify" onclick="javascript:gfnReplyUpdate('+item.replyId+','+item.linkId+');">수정</button>');*/
                		html += '<a href="javascript:gfnReplyDelete('+item.replyId+','+item.linkId+');" class="btn-delete"><em class="hidden">삭제</em></a>';
                	}
                	html += '</p>';
                	html += '<p class="replay"></p>';
                	html += '</li>';

                	selectObject.append(html);
                	var str = item.replyDesc;
                	str = replaceAll(str, "\n", "<br />");
                	selectObject.find('li > p').last('.replay').html(str);
                });
            }
        }
    });
}

/*********************************************************************
 * 프린트 div 영역 지정 출력
 *
**********************************************************************/
var win=null;
function printIt(contextPath)  {
	win = window.open('','','width=1024,height=900');
	self.focus();
	win.document.open();
	win.document.write('<'+'html'+'><'+'head'+'><'+'style'+'>');
	win.document.write('body, td { font-size: 10pt;}');
	win.document.write('body, th { font-size: 10pt;}');
	win.document.write('<'+'/'+'style'+'><link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/ips/basic.css" /><'+'/'+'head'+'><'+'body'+'>');
	win.document.write($("#contentArea").html());
	win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
	win.document.close();
	setTimeout(function(){
		win.print();
		win.close();
	}, 1000);
}

/*********************************************************************
 * 프린트 div content 영역 출력
 *
**********************************************************************/
function printContent(contextPath)  {
	var $divContent = $('#contents').clone();
	var menuId = $('#menuId').val();
	var step = $('#step').val();

	win = window.open('','','width=1024,height=900');
	self.focus();
	win.document.open();
	win.document.write('<'+'html'+'><'+'head'+'><'+'style type="text/css" media="print" '+'>');
	win.document.write('body, td { font-size: 10pt;}');
	win.document.write('body, th { font-size: 10pt;}');
	win.document.write('.content-footer { display:none; }');
	win.document.write('@media print { .content-footer { display:none; } }');
	win.document.write('@page{ size:auto; margin:8mm;} ');
	win.document.write('<'+'/'+'style'+'>');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cluster/sub.css" />');
	win.document.write('<'+'/'+'head'+'><'+'body id="print"'+'>');
	win.document.write($divContent.html());
	win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
	win.document.close();

	setTimeout(function sTo(){
		win.print();
		win.close();
		}, 1000);
}

function printCpsContent(contextPath)  {
	var $divContent = $('#contents').clone();
	var menuId = $('#menuId').val();
	var step = $('#step').val();

	win = window.open('','','width=1024,height=900');
	self.focus();
	win.document.open();
	win.document.write('<'+'html'+'><'+'head'+'><'+'style type="text/css" media="print" '+'>');
	win.document.write('.cont-mid {width: 21cm!important;min-height: 29.7cm;padding: 2cm!important;margin: 0 auto;background:#eee;}');
	win.document.write('body, td { font-size: 10pt;}');
	win.document.write('body, th { font-size: 10pt;}');
	win.document.write('.content-footer { display:none; }');
	win.document.write('@media print { .content-footer { display:none; } }');
	win.document.write('@page {size: A4;margin: 0;} ');
	win.document.write('<'+'/'+'style'+'>');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/sub.css" />');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/jquery.mCustomScrollbar.min.css" />');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/xeicon.css" />');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/slick.css" />');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/layout.css" />');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/cps/common.css" />');
	win.document.write('<'+'/'+'head'+'><'+'body id="print"'+'>');
	win.document.write($divContent.html());
	win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
	win.document.close();

	setTimeout(function sTo(){
		win.print();
		win.close();
		}, 1000);
}

//쿠키값 설정
function setCookie(name, value, expiredays)
{
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape(value) + "; path="+gContextPath+"; expires=" + today.toGMTString() + ";";
}

function setCookieWithSamePath(name, value, expiredays)
{
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + today.toGMTString() + "; secure";
}
//쿠키값 가져오기
/*function getCookie(key)
{
	var cook = document.cookie + ";";
	var idx = cook.indexOf(key,0);

	var val = "";

	if(idx!=-1)
	{
		cook = cook.substring(idx,cook.length);
		begin = cook.indexOf("=",0) + 1;
		end = cook.indexOf(";",begin);
		val = unescape(cook.substring(begin,end));
	}

	return val;
}*/
//내가 찾은 검색어 쿠키값 설정
function getCookie(key)
{
	var cook = document.cookie + ";";
	var idx = cook.indexOf(key,0);
	var val = "";

	if(idx!=-1)
	{
		cook = cook.substring(idx,cook.length);
		begin = cook.indexOf("=",0) + 1;
		end = cook.indexOf(";",begin);

		//key 값과 cookie의 key 값이 일치 할 경우에만
		if(key == cook.substring(0,begin-1)){
			val = unescape(cook.substring(begin,end));
		}
	}

	return val;
}


function replaceAll(sValue, param1, param2) {
	return sValue.split(param1).join(param2);
}


/*******************************************************************************
 * 선택된 게시글(메뉴) 스크랩하기
 *
 * 사용 : gfnMyScrapInsert(menuid, linkId)
 * 입력 : 현재메뉴 menuid, 현재 글 linkId
 ******************************************************************************/
//스크랩중복체크 후 인서트
function gfnMyScrapInsert(menuid,linkid){

	if(menuid.length < 9 ){

		alert("스크랩할 수 없습니다.");
		return;
	}

	$.ajax({
 		url: gContextPath+"/main/mypage/check",
 		data: {'menuId' : menuid, 'schText' : linkid},
 		cache: false,
 		success:function(rtn) {

 	 		fnScrapInsert(menuid,linkid,rtn);
 		}
 	});

}

//마이스크랩등록
function fnScrapInsert(menuid,linkid,rtn){

	if(rtn>0)
	{
		alert("이미 스크랩되어 있습니다.");
		return false;
	}else{
		if(confirm("해당 게시물(메뉴)를 스크랩 하시겠습니까?")) {

			$.ajax({
			url: gContextPath+"/main/mypage/insert",
 			data: {'menuId' : menuid, 'schText' : linkid},
 			cache: false,
 			success:function(val) {
 					alert("해당 게시물(메뉴)이 스크랩되었습니다.");
 				}
			});
		}else{
			alert("취소되었습니다.");
		}
	}

}

/********************************************************************************************************
 * gfnCodeRadioList 코드 라디오버튼 조회함수
 *
 * 사용 : gfnCodeRadioList($("#"), "interest", "answerWay", "", "", "01");
 * 입력 : 추가될 위치 selectObject, higherCode, 라디오버튼 이름, 기본값 사용시 value, 기본값 사용시 text, 선택 할 value
 *******************************************************************************************************/
function gfnCodeRadioList(selectObject, strHigh, objName, strValue, strText, strSelect){
    $.ajax({
        url: gContextPath+"/mgr/listCode",
        data: "higherCode="+strHigh,
        async: false,
        success:function(data, textStatus, jqXHR) {

        	selectObject.find("input").remove();
        	selectObject.find("label").remove();

        	if(data != null) {
	        	$.each(data, function(i, item) {
					$("<input type='radio' id='"+objName+i+"' name='"+objName+"' value='"+item.CODE+"' />").appendTo(selectObject);
					$("<label for='"+objName+i+"'>"+item.KNAME+"</label>").appendTo(selectObject);
	        	});
        	}

        	if(strSelect != "" && strSelect != null){
        		$('input[name='+objName+']').each(function(){
        			if($(this).val() == strSelect){
        				$(this).attr('checked', 'checked');
        			}
        		});
        	}
        }
    });
}

function padDigit(num){
	if(num < 10){
		return "0"+num;
	}else{
		return num;
	}
}

/*********************************************************************
 * 통합검색 함수
 *
 * 사용 : gfnSearch();
 * 입력 :
 *
**********************************************************************/
function gfnSearch(gubun){
	if($.trim($('#search_keyword').val()) == ""){
		alert("검색어를 입력해 주세요...");
		$("#search_keyword").val("");
		$("#search_keyword").focus();
		return false;
	}

    var li_str_len     = $.trim($('#search_keyword').val()).length; // 이벤트가 일어난 컨트롤의 value 값 길이
	if(li_str_len < 2){
		alert("두 글자이상 입력바랍니다.");

		$("#search_keyword").val("");
		$("#search_keyword").focus();
		return false;
	}

	if($("#search-check").is(":checked")){
		var lastQuery = document.unifiedSearchForm.query.value;
		document.unifiedSearchForm.query.value = lastQuery + ' ' + $("#search_keyword").val();
	}else{
		document.unifiedSearchForm.query.value = $('#search_keyword').val();
	}

	document.unifiedSearchForm.gubun.value = gubun;
	document.unifiedSearchForm.submit();

}

function gfnTotalSearch(gubun){
	if($.trim($('#total-search-txt').val()) == ""){
		alert("검색어를 입력해 주세요...");
		$("#total-search-txt").val("");
		$("#total-search-txt").focus();
		return false;
	}

    var li_str_len     = $.trim($('#total-search-txt').val()).length; // 이벤트가 일어난 컨트롤의 value 값 길이
	if(li_str_len < 2){
		alert("두 글자이상 입력바랍니다.");

		$("#total-search-txt").val("");
		$("#total-search-txt").focus();
		return false;
	}

	if($("#total-search-check").is(":checked")){
		var lastQuery = document.totSearchForm.query.value;
		document.totSearchForm.query.value = lastQuery + ' ' + $("#total-search-txt").val();
	}else{
		document.totSearchForm.query.value = $('#total-search-txt').val();
	}

	document.totSearchForm.gubun.value = gubun;
	document.totSearchForm.submit();
}

function goCategorySearch(objId,str){
	document.totSearchForm.categoryQuery.value = objId;
	document.totSearchForm.categoryUse.value = str;
	document.totSearchForm.submit();
}

function goRecommandSearch(objId){
	document.totSearchForm.query.value = objId;
	document.totSearchForm.submit();
}

function gfnAjaxError(){
	alert("경로가 정확하지 않거나 오류가 발생하였습니다.");
	return;
}

//메일보내기
function gfnToMail(rtnLoction, KNAME, url){
/*	var pop_title = "mail_pop";
	window.open("", pop_title,'width=600px,height=550px,scrollbars=yes,status=no');

	var frmData = document.frmData;
	frmData.menuName.value=rtnLoction;
	frmData.KName.value=KNAME;
	frmData.linkUrl.value=url;
	frmData.target = pop_title;
	frmData.action = "/main/footerMail";
	frmData.submit();*/
	window.open('/main/footerMail?menuName='+encodeURIComponent(rtnLoction)+'&KName='+encodeURIComponent(KNAME)+'&linkUrl='+encodeURIComponent(url) ,'mail_pop', 'width=700px,height=450px,scrollbars=yes,status=no');
}

//트위터보내기
function twitter(){
	var shareUrl = "https://twitter.com/share?url=" + encodeURIComponent(document.URL);
	window.open(shareUrl, 'share_twitter', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');
}

function facebook(){
	var url = "https://www.facebook.com/sharer.php?u=" + encodeURIComponent(document.URL);
	window.open(url, 'share_facebook', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');
}

//id통합창 띄우기
function gfnOpenIdSynthesis(){

	var currentPage = document.location.href;

	window.open('/main/member/idSynthesis?rtnUrl='+encodeURIComponent(currentPage) ,'IdSynthesis_pop', 'width=865px,height=800px,scrollbars=yes,status=no');
}

/**************************************************************************************************************
 * Editor 팝업
 *
 * 사용 : gfnEditorPopup("opener")
 * 입력 :
 **************************************************************************************************************/
function gfnEditorPopup(eId){

	 //Editor 팝업
	 window.open(gContextPath+"/mgr/editorPopup?editorId="+eId, "Editor", "scrollbars=no, width=800, height=640");
}


/**************************************************************************************************************
 * 뉴스레터 보기
 *
 * 사용 : gfnOpenNewsLetter("주소")
 * 입력 :
 **************************************************************************************************************/
function gfnOpenNewsLetter(strUrl){
	var strStyle = "scrollbars=yes";
	gfnOpenWin(strUrl, "viewNewsLetter", strStyle, 870, 1000);
}

/**************************************************************************************************************
 * 뉴스레터 신청
 *
 * 사용 : gfnRequestNewsLetter()
 * 입력 :
 * input : appSiteId, appEmail 필요
 **************************************************************************************************************/
function gfnRequestNewsLetter(email)
{
	var regExp = /(\S+)@(\S+)\.(\S+)/;
	var flag = regExp.test(email);
	if(flag){
		$.ajax({
			url: gContextPath+"/newsLetter/requestNewsLetter",
			data: {'siteId' : 'SITE00002', 'appEmail' : email},
			cache: false,
			async: false,
	 		success:function(result, textStatus, jqXHR) {
	 			if(result != null) {
	 				if(result == "SUCCESS"){
	 					alert("신청되었습니다.");
	 				}else if(result == "OVERLAP"){
	 					alert("이미 뉴스레터 수신이 신청되어있습니다.");
	 				}else{
	 					//$(".view").text(result);
	 					alert("신청 중 오류가 발생하였습니다.");
	 				}
	 			}
	 		}
		});
	}else{
		alert("이메일 형식이 잘못되었습니다.");
	}
	return false;
}

/**************************************************************************************************************
 * KINAC 뉴스레터 구독 신청
 *
 * 사용 : gfnRequestNewsLetter()
 * 입력 :
 * input : appSiteId, appEmail 필요
 **************************************************************************************************************/
function gfnKinacNewsApply(email, kname){
	var regExp = /(\S+)@(\S+)\.(\S+)/;
	var flag = regExp.test(email);

	if(flag){
		$.ajax({
			url: gContextPath+"/main/newsLetterSubscribe/requestNewsLetter",
			data: {'appEmail' : email, 'KName' : kname},
			cache: false,
			async: false,
	 		success:function(result, textStatus, jqXHR) {
	 			if(result != null) {
	 				if(result == "SUCCESS"){
	 					alert("신청되었습니다.");
	 				}else if(result == "OVERLAP"){
	 					alert("이미 뉴스레터 구독신청이 되어있습니다.");
	 				}else{
	 					//$(".view").text(result);
	 					alert("신청 중 오류가 발생하였습니다.");
	 				}
	 			}
	 		}
		});
	}else{
		alert("이메일 형식이 잘못되었습니다.");
	}
	return false;
}

/**************************************************************************************************************
 * 이용약관 전체선택 공통
 *
 * 사용 : gfnOpenNewsLetter()
 * 입력 :
 **************************************************************************************************************/
function gfnAllPolicyCheck()
{
	var choicePolicyChk = $("input:checkbox[name='allcheck']").is(":checked");

	if(choicePolicyChk)
	{
		$(".agree1").prop("checked", true);
		$(".agree2").prop("checked", true);
	}else{

		$(".agree1").removeAttr('checked');
		$(".agree2").removeAttr('checked');
	}
}

/**************************************************************************************************************
 * 이용약관 전체선택 공통
 *
 * 사용 : gfnNotAgreeCheck()
 * 입력 :
 **************************************************************************************************************/
function gfnNotAgreeCheck()
{
	$("#allcheck").removeAttr('checked');
}

/**************************************************************************************************************
 * 날짜 공통함수
 *
 * 사용 :
 * 입력 :
 **************************************************************************************************************/
function gfnIsHoliday(yyyy, mm, dd){
	//검사년도
	var yyyymmdd = yyyy+""+mm+""+dd;
	//var yyyy = "";
	var holidays = new Array();
	var holidaysName = new Array();
	var holidayName = "";
	// 음력 공휴일 양력으로 바꾸어서 입력

	// 양력 공휴일 일력
	holidays[0] = yyyy+"0101"; //양력설날
	holidays[1] = yyyy+"0301"; //삼일절
	//holidays[2] = yyyy+"0405"; //식목일
	holidays[2] = yyyy+"0505"; //어린이날
	holidays[3] = yyyy+"0606"; //현충일
	holidays[4] = yyyy+"0815"; //광복절
	holidays[5] = yyyy+"1003"; //개천절
	holidays[6] = yyyy+"1009"; //한글날
	holidays[7] = yyyy+"1225"; //성탄절

	var tmp01 = lunerCalenderToSolarCalenger(yyyy+"0101");
	var tmp02 = lunerCalenderToSolarCalenger(yyyy+"0815");

	holidays[8] = Number(tmp01) -1;  //음력설 첫쨋날
	holidays[9] = tmp01; 	 //음력설 둘쨋날
	holidays[10] =Number(tmp01) +1; //음력설 셋쨋날
	holidays[11] = Number(tmp02) -1; //음력추석 첫쨋날
	holidays[12] = tmp02; 	 //음력추석 둘쨋날
	holidays[13] = Number(tmp02) +1; //음력추석 셋쨋날
	holidays[14] = lunerCalenderToSolarCalenger(yyyy+"0408"); //석가탄신일

	holidaysName[0] = "신정";
	holidaysName[1] = "삼일절";
	//holidaysName[2] = "식목일";
	holidaysName[2] = "어린이날";
	holidaysName[3] = "현충일";
	holidaysName[4] = "광복절";
	holidaysName[5] = "개천절";
	holidaysName[6] = "한글날";
	holidaysName[7] = "성탄절";
	holidaysName[8] = "구정 첫쨋날";
	holidaysName[9] = "구정 둘쨋날";
	holidaysName[10] = "구정 셋쨋날";
	holidaysName[11] = "추석 첫쨋날";
	holidaysName[12] = "추석 둘쨋날";
	holidaysName[13] = "추석 셋쨋날";
	holidaysName[14] = "석가탄신일";

	for(var i=0; i<holidays.length; i++){
		if(holidays[i] == yyyymmdd){
			holidayName = holidaysName[i];
			//return true;
		}
	}
	return holidayName;
}

function get_year(src) {
	 if ((src < 1841) || (src > 2043 )) {
	  alert('연도 범위는 1841 ~ 2043 까지입니다.');
	  return;
	 } else {
	  return src;
	 }
	}

	/**
	 * 달이 12보다 크거나 1보다 작은지 검사한다.
	 * 날짜가 잘못된 경우에는 경고창 후 멈춘다.
	 *
	 * @param int
	 * @return int
	 */
	function get_month(src) {
	 if ((src < 1) || (src > 12 )) {
	  alert('월 범위는 1 ~ 12 까지입니다.');
	  return;
	 } else {
	  return src;
	 }
	}

	/**
	 * 날짜가 1일보다 크고 src보다 작은 경우는 날짜를 반환한다.
	 * 날짜가 잘못된 경우에는 경고창 후 멈춘다.
	 *
	 * @param int
	 * @param int
	 * @return int
	 */
	function get_day(src,day) {
	 if ((src < 1) || (src > day )) {
	  alert('일 범위가 틀립니다.');
	  return;
	 } else {
	  return src;
	 }
	}

/**
 * 음력을 양력으로 바꾸어서 반환한다.
 *
 * @param string
 * return string
 */
function lunerCalenderToSolarCalenger (input_day) {
 var kk = [[1, 2, 4, 1, 1, 2, 1, 2, 1, 2, 2, 1],   /* 1841 */
     [2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 4, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 5, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 3, 2, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 5, 2],   /* 1851 */
     [2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 5, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [2, 1, 6, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],   /* 1861 */
     [2, 1, 2, 1, 2, 2, 1, 2, 2, 3, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 4, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
     [1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 5, 2, 1],
     [2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2],   /* 1871 */
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 4, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 4, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 5, 2, 2, 1, 2, 1],   /* 1881 */
     [1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 3, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 5, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],   /* 1891 */
     [1, 1, 2, 1, 1, 5, 2, 2, 1, 2, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 5, 1, 2, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],   /* 1901 */
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2],   /* 1911 */
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],   /* 1921 */
     [2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
     [1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],   /* 1931 */
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1],   /* 1941 */
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
     [2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],   /* 1951 */
     [1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],   /* 1961 */
     [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2],   /* 1971 */
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1],
     [2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1],
     [2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],   /* 1981 */
     [2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],   /* 1991 */
     [1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2],   /* 2001 */
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 5, 2, 2, 1, 2, 1, 2, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],   /* 2011 */
     [2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],   /* 2021 */
     [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
     [1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
     [1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1],   /* 2031 */
     [2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 5, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 4, 1, 1, 2, 1, 2, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
     [2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],   /* 2041 */
     [1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]];

 var gan = new Array("甲","乙","丙","丁","戊","己","庚","辛","壬","癸");
 var jee = new Array("子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥");
 var ddi = new Array("쥐","소","범","토끼","용","뱀","말","양","원숭이","닭","개","돼지");
 var week = new Array("일","월","화","수","목","금","토");

 var md = new Array(31,0,31,30,31,30,31,31,30,31,30,31);

 var year =input_day.substring(0,4);
 var month =input_day.substring(4,6);
 var day =input_day.substring(6,8);

 // 음력에서 양력으로 변환
 var lyear, lmonth, lday, leapyes;
 var syear, smonth, sday;
 var mm, y1, y2, m1;
 var i, j, k1, k2, leap, w;
 var td, y;
 lyear = get_year(year);        // 년도 check
 lmonth = get_month(month);     // 월 check

 y1 = lyear - 1841;
 m1 = lmonth - 1;
 leapyes = 0;
 if (kk[y1][m1] > 2)  {
     if (document.frmTest.yoon[0].checked) {
     leapyes = 1;
     switch (kk[y1][m1]) {
        case 3:
        case 5:
          mm = 29;
          break;
        case 4:
        case 6:
          mm = 30;
          break;
      }
     } else {
     switch (kk[y1][m1]) {
       case 1:
       case 3:
       case 4:
         mm = 29;
         break;
       case 2:
       case 5:
       case 6:
         mm = 30;
         break;
     } // end of switch
    } // end of if
 } // end of if

   lday = get_day(day, mm);

   td = 0;
   for (i=0; i<y1; i++) {
   for (j=0; j<12; j++) {
      switch (kk[i][j]) {
        case 1:
          td = td + 29;
          break;
        case 2:
          td = td + 30;
          break;
        case 3:
          td = td + 58;    // 29+29
          break;
        case 4:
          td = td + 59;    // 29+30
          break;
        case 5:
          td = td + 59;    // 30+29
          break;
        case 6:
          td = td + 60;    // 30+30
          break;
        } // end of switch
   } // end of for
 } // end of for

 for (j=0; j<m1; j++) {
  switch (kk[y1][j]) {
    case 1:
      td = td + 29;
      break;
    case 2:
      td = td + 30;
      break;
    case 3:
      td = td + 58;    // 29+29
      break;
    case 4:
      td = td + 59;    // 29+30
      break;
    case 5:
      td = td + 59;    // 30+29
      break;
    case 6:
      td = td + 60;    // 30+30
      break;
  } // end of switch
  } // end of for

  if (leapyes == 1) {
  switch(kk[y1][m1]) {
    case 3:
    case 4:
      td = td + 29;
      break;
    case 5:
    case 6:
      td = td + 30;
      break;
   } // end of switch
  } // end of switch

  td =  td + parseFloat(lday) + 22;
  // td : 1841 년 1 월 1 일 부터 원하는 날짜까지의 전체 날수의 합
  y1 = 1840;
  do {
  y1 = y1 +1;
  if  ((y1 % 400 == 0) || ((y1 % 100 != 0) && (y1 % 4 == 0))) {
    y2 = 366;
  }
  else {
    y2 = 365;
  }
  if (td <= y2) {
    break;
  }
  else {
    td = td- y2;
  }
  } while(1); // end do-While

 syear = y1;
 md[1] = parseInt(y2) -337;
 m1 = 0;
 do {
 m1= m1 + 1;
 if (td <= md[m1-1]) {
  break;
 }
 else {
  td = td - md[m1-1];
 }
 } while(1); // end of do-While

 smonth = parseInt(m1);
 sday = parseInt(td);

 // 월이 한자리인경우에는 앞에 0을 붙혀서 반환
 if ( smonth < 10 ) {
  smonth = "0" + smonth;
 }
 // 일이 한자리인경우에는 앞에 0을 붙혀서 반환
 if ( sday < 10 ) {
  sday = "0" + sday;
 }

 return new String( syear + smonth + sday );
}

//날짜 포맷변환  00000000 => 0000-00-00
function gfnDateYYYYMMDDFormat(object){

	var num, year, month, day;

	var input = "#"+object;

	num = $(input).val();

	if(num.length == 0){
		return;
	}

	while(num.search("-") != -1){

		num = num.replace("-","");
	}

	if(isNaN(num)){
		alert("숫자로만 작성하셔야 합니다.");
		$(input).focus();
		return;
	}

	if(num != 0 && num.length == 8){

		year = num.substring(0,4);
		month = num.substring(4,6);
		day = num.substring(6);

		if(isValidDay(year,month,day)==false){

			num = "";
			alert("유효하지 않는 날짜입니다. 다시 한번 확인하시고 입력해주세요.");
			$(input).val(num);
			$(input).focus();
			return;
		}

		num = year+"-"+month+"-"+day;

	}else{
		num = "";
		alert("날짜 입력형식 오류입니다. 다시 한번 확인하시고 입력해 주세요");
		$(input).val(num);
		$(input).focus();
		return;
	}

	$(input).val(num);
}

//유효한 날짜인지 체크
function isValidDay(yyyy, mm, dd){

	var m = parseInt(mm,10) -1;
	var d = parseInt(dd,10);
	var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);

	if((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0){

		end[1]=29;
	}

	return(d >=1 && d <= end[m]);
}

/**************************************************************************************************************
 * 동적사이트 메인 뉴스레터 받아오기
 *
 * 사용 : gfnNewsLetter()
 * 입력 :
 * input : strSiteId, strDivId 필요
 **************************************************************************************************************/
function gfnNewsLetter(strSiteId, strDivId){
	var strNewsLetterId = "";
	var strPubNo = "";
	var strPubDate = "";

	var strHtml = "";

	$.ajax({
 		url: gContextPath+"/newsLetterJson",
 		data: {'siteId' : strSiteId},
 		success:function(result) {
 			if(result != "" ) {
 				strNewsLetterId = result.newsLetterId;
 				strPubNo = result.pubNo;
 				strPubDate = result.pubDate;
 			}
		 	strHtml = gfnMakeNewsLetter(strSiteId, strNewsLetterId, strPubNo, strPubDate);
		 	$(strDivId).append(strHtml);
 		},
 		error:function(result, textStatus, error){
		 	strHtml = gfnMakeNewsLetter(strSiteId, strNewsLetterId, strPubNo, strPubDate);
		 	$(strDivId).append(strHtml);
 		}
 	});
}

function gfnMakeNewsLetter(strSiteId, strNewsLetterId, strPubNo, strPubDate){
	var strHtml = "";

	strHtml += "<h2 class=txt_title>금주의 뉴스레터</h2>";
	strHtml += "<div class=letter_view>";

	if(strNewsLetterId == ""){
		strHtml += "	<p class=link><a onclick='alert(\"등록된 뉴스레터가 없습니다.\");' title='뉴스레터 보기(팝업창)' href='#'>뉴스레터 view</a></p>";
		strHtml += "	<p class=vol>뉴스레터가 없습니다.</p>";
	}else{
		strHtml += "	<p class=link><a onclick=gfnOpenNewsLetter('/newsLetter/preView?newsLetterId="+strNewsLetterId+"') title='뉴스레터 보기(팝업창)' href='#'>뉴스레터 view</a></p>";
		strHtml += "	<p class=vol><strong>제"+strPubNo+"호</strong> 발행일 "+strPubDate+"</p>";
	}

	strHtml += "</div>";
	strHtml += "<div class=application>";
	strHtml += "	<form id=search_form onsubmit='return gfnRequestNewsLetter();' method=post name=news_form action=''>";
	strHtml += "		<fieldset>";
	strHtml += "			<legend>뉴스레터신청</legend>";
	strHtml += "			<input id=appSiteId type=hidden value="+strSiteId+" name=appSiteId />";
	strHtml += "			<input id=appEmail title=이메일입력 size=11 name=appEmail placeholder='이메일 입력' />";
	strHtml += "			<button class=btn_search type=submit>신청</button>";
	strHtml += "		</fieldset> ";
	strHtml += "	</form>";
	strHtml += "</div>";

	return strHtml;
}

function gfnPersonInfoLog(strMenuId, strInRecUserId, strInGubun, strInRecDesc, fileGubun){
	//개인정보접속기록 로그
	$.ajax({
		url: gContextPath+"/mgr/personInfoInsert",
		data: {'menuId' : strMenuId , 'inRECUserID' :  strInRecUserId, 'inGubun' :  strInGubun, 'inRECDesc' : strInRecDesc, 'fileGubun' : fileGubun},
		async: false,
		success:function(data, textStatus, jqXHR) {
		}
	});
}

function gfnKeywordSearch(strMenuId){
	var strStyle = "scrollbars=yes";
	var strUrl = "/mgr/contentMgr/selectKeywordSearchPopup?menuId="+strMenuId;

	gfnOpenWin(strUrl, "키워드검색", strStyle, 750, 710);

}

/*********************************************************************
 * 로그인  호출
 *
 * 사용 : gfnOpenLogin();
 * 입력 :
**********************************************************************/
function gfnOpenLogin()
{

	//$(".login_layerPopup").show();
	$(".login_layerPopup").css("display","none");
	$(".login_layerPopup").fadeIn('slow');
}

/*********************************************************************
 * 유해어 체크
 *
 * 사용 : gfnTabooWordCheck();
 * 입력 :
**********************************************************************/
function gfnTabooWordCheck(objs)
{
	var chkCnt = 0;
	var chkKNameArray = new Array();
	var kNameArray = new Array();
	var kNameArray = new Array();

	$.each(objs.split('§§'), function(index, obj){
		$.ajax({
			url: gContextPath+"/tabooWord",
			async: false,
			cache: false,
			success:function(data, textStatus, jqXHR) {
				if(data != null){
					$.each(data, function(j){
						if($("#"+obj).val() != undefined){
							if($("#"+obj).val().indexOf(data[j].KNAME) > -1){
								chkCnt += 1;
								chkKNameArray.push(data[j].KNAME);
							}
						}
					});
				}
			}
		});
	});

	$.each(chkKNameArray, function(i, el){
		if($.inArray(el, kNameArray) == -1) kNameArray.push(el);
	});


	return [chkCnt+"건의 유해어가 검출되었습니다.\n"+kNameArray, chkCnt];
}

/*******************************************************************************
 * 페이지 확대축소
 *
 * 사용 : zomms(nowZoom)
 * 입력 : 확대, 축소 값
 ******************************************************************************/
function zooms(nowZoom) {
	var docbody = document.body;
	header.style.zoom = nowZoom;// IE
	body.style.zoom = nowZoom;// IE
	footer.style.zoom = nowZoom;  // IE
	docbody.style.webkitTransform = 'scale('+nowZoom+')';  // Webkit(chrome)
	docbody.style.webkitTransformOrigin = '0 0';
	docbody.style.mozTransform = 'scale('+nowZoom+')';  // Mozilla(firefox)
	docbody.style.mozTransformOrigin = '0 0';
	docbody.style.oTransform = 'scale('+nowZoom+')';  // Opera
	docbody.style.oTransformOrigin = '0 0';
}

/*******************************************************************************
 * 특정기호로 구분되어진 데이터값을 코드목록과 매칭해 코드한글명 1줄로 append ( ex) '1#3#5' -> '문화, 예술, 공연')
 *
 * 사용 : gfnCodeKnameAppend(sign, data, higherCode, appendObjId)
 * 입력 : 구분기호, 변환할 데이터목록, 매칭할 상위코드명, 결과가 입력될 객체id명
 ******************************************************************************/
function gfnCodeKnameAppend(sign, data, higherCode, appendObjId){
	var dataArr = data.split(sign);
	var codeList = gfnCodeList(higherCode);
	for (var i = 0; i < dataArr.length; i++) {
		for (var j = 0; j < codeList.length; j++) {
			if(dataArr[i]==codeList[j].CODE){
				var value = codeList[j].KNAME;
				if(i < (dataArr.length-1) && dataArr[i] != ""){
					value = value + ", ";
				}
				$("#"+appendObjId).append(value);
			}
		}
	}
}

function htmlTagReplace(str){
	str = str.replace(/\s+/, "");
	str = str.replace(/\s+$/g, "");
	str = str.replace(/\n/g, "");
	str = str.replace(/\r/g, "");
	str = str.replace(/(<([^>]+)>)/gi, "");
	return str;
}


/*********************************************************************
 * 에디터 설정
 *
**********************************************************************/
function gfnInitEditor(objId, objPosition){
	// 다음에디터 설정
	$.ajax({
        url : gContextPath + "/resources/component/daumeditor-7.5.9/editor.html",
        success : function(data){
        	data = data.replace(/images\/icon\/editor\/skin\/01\/btn_drag01.gif/g, gContextPath + "/resources/component/daumeditor-7.5.9/images/icon/editor/skin/01/btn_drag01.gif");
        	data = data.replace(/images\/icon\/editor\/loading2.png/g, gContextPath + "/resources/component/daumeditor-7.5.9/images/icon/editor/loading2.png");
        	data = data.replace(/images\/icon\/editor\/pn_preview.gif/g, gContextPath + "/resources/component/daumeditor-7.5.9/images/icon/editor/pn_preview.gif");

        	$("#editor_frame").html(data);
            var config = {
            		txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
            		txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
            		txService: 'sample', /* 수정필요없음. */
            		txProject: 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
            		initializedId: "", /* 대부분의 경우에 빈문자열 */
            		wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
            		form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */
            		txIconPath: gContextPath + "/resources/component/daumeditor-7.5.9/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
            		txDecoPath: gContextPath + "/resources/component/daumeditor-7.5.9/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
            		canvas: {
                        exitEditor:{
                            /*
                            desc:'빠져 나오시려면 shift+b를 누르세요.',
                            hotKey: {
                                shiftKey:true,
                                keyCode:66
                            },
                            nextElement: document.getElementsByTagName('button')[0]
                            */
                        },
            			styles: {
            				color: "#123456", /* 기본 글자색 */
            				fontFamily: "나눔고딕", /* 기본 글자체 */
            				fontSize: "9pt", /* 기본 글자크기 */
            				backgroundColor: "#fff", /*기본 배경색 */
            				lineHeight: "1.5", /*기본 줄간격 */
            				padding: "10px" /* 위지윅 영역의 여백 */
            			},
            			showGuideArea: false
            		},
            		events: {
            			preventUnload: false
            		},
            		sidebar: {
            			attachbox: {
            				show: true,
            				confirmForDeleteAll: true
            			},
            			capacity: {
            				available : 1024 * 1024 * 10, /* 첨부 용량 제한 */
            				maximum: 1024 * 1024 * 10     /* 첨부 용량 제한 */
            			}
            		},
            		size: {
            			//contentWidth: 670 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
            		}
            		,
            		toolbar: {
            	        fontfamily: {
            	            options: [
            	                { label: ' 나눔고딕 (<span class="tx-txt">가나다라</span>)', title: '나눔고딕', data: 'Nanum Gothic', klass: 'tx-nanumgothic' },
            	                { label: ' 맑은고딕 (<span class="tx-txt">가나다라</span>)', title: '맑은고딕', data: '"맑은 고딕",AppleGothic,sans-serif', klass: 'tx-gulim' },
            	                { label: ' 굴림 (<span class="tx-txt">가나다라</span>)', title: '굴림', data: 'Gulim,굴림,AppleGothic,sans-serif', klass: 'tx-gulim' },
            	                { label: ' 바탕 (<span class="tx-txt">가나다라</span>)', title: '바탕', data: 'Batang,바탕', klass: 'tx-batang' },
            	                { label: ' 돋움 (<span class="tx-txt">가나다라</span>)', title: '돋움', data: 'Dotum,돋움', klass: 'tx-dotum' },
            	                { label: ' 궁서 (<span class="tx-txt">가나다라</span>)', title: '궁서', data: 'Gungsuh,궁서', klass: 'tx-gungseo' },
            	                { label: ' Arial (<span class="tx-txt">abcde</span>)', title: 'Arial', data: 'Arial', klass: 'tx-arial' },
            	                { label: ' Verdana (<span class="tx-txt">abcde</span>)', title: 'Verdana', data: 'Verdana', klass: 'tx-verdana' },
            	                { label: ' Arial Black (<span class="tx-txt">abcde</span>)', title: 'Arial Black', data: 'Arial Black', klass: 'tx-arial-black' },
            	                { label: ' Book Antiqua (<span class="tx-txt">abcde</span>)', title: 'Book Antiqua', data: 'Book Antiqua', klass: 'tx-book-antiqua' },
            	                { label: ' Comic Sans MS (<span class="tx-txt">abcde</span>)', title: 'Comic Sans MS', data: 'Comic Sans MS', klass: 'tx-comic-sans-ms' },
            	                { label: ' Courier New (<span class="tx-txt">abcde</span>)', title: 'Courier New', data: 'Courier New', klass: 'tx-courier-new' },
            	                { label: ' Georgia (<span class="tx-txt">abcde</span>)', title: 'Georgia', data: 'Georgia', klass: 'tx-georgia' }      	              
            	            ]
            	        }
            	    }
            	};

            	EditorJSLoader.ready(function(Editor) {
            		var editor = new Editor(config);
            		Editor.getCanvas().setCanvasSize({height:250});

            		if(objPosition == 'self'){
            			Editor.modify({
                            "content":  document.getElementById(objId) /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
                        });
            		}else{
            			Editor.modify({
            				"content": opener.document.getElementById(objId) /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
            			});
            		}

            	});
    	}
	});
}

// 확장자 체크
function gfnCheckFext(objs, type)
{
	var retval = true;
	var ext = "";

	objs.each(function(){
		var fpath = $(this).val();
		if(fpath.length > 0)
		{
			ext = fpath.substr(fpath.lastIndexOf(".") + 1, fpath.length);
			ext = ext.toLowerCase();

			if(type == "IMG")
			{
				var allows = "jpg|png|bmp|gif";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n이미지 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
					retval = false;
					return false;
				}
			}
			else if(type == "DOC")
			{
				var allows = "doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다/.\n문서 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
					retval = false;
					return false;
				}
			}
			else if(type == "GNR")
			{
				var allows = "jpg|png|bmp|gif|doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt|zip";
				if(allows.indexOf(ext) < 0)
				{
					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n파일 종류 : " + ext);
					retval = false;
					return false;
				}
			}
		}
	});

	return retval;
}

$(function(){
	if(typeof Kakao !== "undefined") {
		Kakao.init('416390a719cbfba0726bb85544063852');
	}
})

function sendKakaoStory(menuName){
	if(typeof Kakao !== "undefined") {
		Kakao.Story.share({
			text: menuName,
			url: document.location.href
		});
	}
}

function sendNaverBlog(title){
	var url = "http://blog.naver.com/openapi/share?title="+ title + "&url=" + document.URL;
	$(".blog a").attr("href", url);
	$(".blog a").click();
}

function sendNaverBlog1(title){
	var url = "http://blog.naver.com/openapi/share?title="+ title + "&url=" + document.URL;
	$(".blog").attr("href", url);
	$(".blog").click();
}