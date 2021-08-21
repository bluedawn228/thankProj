package com.mulcam.project.controller;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mulcam.project.common.ClovaAPI;
import com.mulcam.project.service.DiaryService;
import com.mulcam.project.vo.DiaryVO;
import com.mulcam.project.vo.PharseVO;

@Controller
public class DiaryControllerImpl implements DiaryController {
	
	@Autowired
	DiaryService service;
	
	@Override
	@GetMapping("/medi")
	public String medi() {
		
		return "medi-introduce";
	}
	
	@Override
	@GetMapping("/medi-step01")
	public String mediStep01() {
		
		return "medi-step01";
	}
	
	@Override
	@PostMapping("/medi-step02")
	public ModelAndView mediStep02(DiaryVO vo) throws ParseException {
		ModelAndView mv = new ModelAndView("medi-step02");
			
			//sentiment 	분석
			String JsonResult = ClovaAPI.SentimentRequest(vo.getContent());
			System.out.println("=== 클로바 분석 결과 ===" + JsonResult);
			
			JSONParser parser = new JSONParser();
  			JSONObject object = (JSONObject)parser.parse(JsonResult);
  			JSONObject docObj = (JSONObject)object.get("document");
  			JSONObject pntObj = (JSONObject)docObj.get("confidence");

  			double stmAnlsNgt = (double)pntObj.get("negative")   ;   
  			double stmAnlsPst = (double)pntObj.get("positive")   ;
  			double stmAnlsNtr = (double)pntObj.get("neutral")   ;
			
  			vo.setStmAnlsPst(stmAnlsPst);
  			vo.setStmAnlsNtr(stmAnlsNtr);
  			vo.setStmAnlsNgt(stmAnlsNgt);

  			// 명언 목록에서 랜덤으로 가져오기
  			PharseVO pOne = service.getRandomPharse();
  			vo.setPhrsId(pOne.getPhrsId());
  			
			//게시글 등록
			service.registOneArticle(vo);
			
			System.out.println("=================감사일기 등록 완료===================");
			//게시자의 최종 게시글 조회
			DiaryVO one = service.getRecentOneArticleByAuthor(vo.getAuthor());
			

			//긍정도와 부정도를 합산하여 긍정도 가중평균으로 전환(소주 2자리까지 계산)
			one.setPgStat( Double.parseDouble(String.format("%.2f",stmAnlsPst/(stmAnlsPst+stmAnlsNgt)*100)) ) ;
			
			//밀리세컨을 시간으로 변경
			String strTemp = new String();    
			int second = one.getMvDrt() / 1000;
		    int minutes    = second / 60;
		    int seconds    = second % 60;
		    
		    if(minutes < 10)
		      strTemp = "0" + Integer.toString(minutes) + ":";
		    else
		      strTemp = Integer.toString(minutes) + ":";
		    
		    if(seconds < 10)
		      strTemp = strTemp + "0" + Integer.toString(seconds);
		    else
		      strTemp = strTemp + Integer.toString(seconds);
		    System.out.println("===작성자의 최종 게시글 ===" + strTemp);
		    one.setMvDT(strTemp);
		    
		    //태그를 리스트로 변환
		    String[] tagArray = one.getTags().split(",");
		    one.setTagList(tagArray);

			mv.addObject("md",one);
			mv.addObject("phrs",pOne);
		return mv;
	}
	
	@Override
	@GetMapping("/medi-community")
	public String mediCommunity() {
		
		return "medi-community";
	}

}
