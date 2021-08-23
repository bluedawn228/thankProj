package com.mulcam.project.controller;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mulcam.project.common.ClovaAPI;
import com.mulcam.project.service.DiaryService;
import com.mulcam.project.vo.DiaryCommentsVO;
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
	
	//감사일기 입력
	@Override
	@PostMapping("/medi-step01")
	public ModelAndView mediStep01(DiaryVO vo) throws ParseException {
		ModelAndView mv = new ModelAndView("redirect:/medi-step02");
			
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
			mv.addObject("diaryId", vo.getDiaryId());
		return mv;
	}
	
	@Override
	@GetMapping("/medi-step02")
	public ModelAndView mediStep02(@RequestParam("diaryId") int diaryId) throws ParseException {
		ModelAndView mv = new ModelAndView("medi-step02");
			
			//ID로 게시글 조회
			DiaryVO one = service.getArticleById(diaryId);
			
			//게시자의 몇번째 게시글인지 조회
			int aCnt = service.getCntByAuthor(one.getAuthor());

			//긍정도와 부정도를 합산하여 긍정도 가중평균으로 전환(소주 2자리까지 계산)
			one.setPgStat( Double.parseDouble(String.format("%.2f",one.getStmAnlsPst()/(one.getStmAnlsPst()+one.getStmAnlsNgt())*100)) ) ;
			
			 System.out.println("=== 게시글의 가중평균 긍정도 ===" + one.getPgStat());
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

		    one.setMvDT(strTemp);
		    
		    //태그를 리스트로 변환
		    String[] tagArray = one.getTags().split(",");
		    one.setTagList(tagArray);
		    
		 // 명언 목록에서 내용 가져오기
		    PharseVO pOne = service.getPharseById(one.getPhrsId());
		    mv.addObject("aCnt", aCnt);
			mv.addObject("md",one);
			mv.addObject("phrs",pOne);
		return mv;
	}
	
	@Override
	@GetMapping("/medi-share")
	public String mediShareUpdate(@RequestParam("diaryId") String diaryId, @RequestParam("authorId") String authorId) {
		service.openDiaryById(Integer.parseInt(diaryId));
		return "redirect:/medi-community?authorId="+authorId;
	}
	
	@Override
	@GetMapping("/medi-community")
	public ModelAndView mediCommunity(@RequestParam(value="authorId", defaultValue="test") String authorId) {
		ModelAndView mv = new ModelAndView("medi-community");
		mv.addObject("author", authorId);
		int startrow = 1;
		int endrow = 4;
		ArrayList<DiaryVO> authorList= service.getArticlesByAuthor(authorId, startrow, endrow);
		mv.addObject("authorList", authorList);
		
		ArrayList<DiaryVO> voList= service.getAllOpenedArticles(startrow, endrow*3);
		mv.addObject("openedList", voList);
		return mv;
	}
	
	@Override
	@GetMapping("/medi-community-detail")
	public ModelAndView mediCommunityDetail(@RequestParam(value="diaryId") String diaryId) {
		ModelAndView mv = new ModelAndView("medi-community-detail");
	
		DiaryVO vo= service.getArticleById(Integer.parseInt(diaryId));
		//긍정도와 부정도를 합산하여 긍정도 가중평균으로 전환(소주 2자리까지 계산)
		vo.setPgStat( Double.parseDouble(String.format("%.2f",vo.getStmAnlsPst()/(vo.getStmAnlsPst()+vo.getStmAnlsNgt())*100)) ) ;
		// 명언 목록에서 내용 가져오기
	    PharseVO pOne = service.getPharseById(vo.getPhrsId());
		mv.addObject("phrs",pOne);
		//태그를 리스트로 변환
	    String[] tagArray = vo.getTags().split(",");
	    vo.setTagList(tagArray);
	    //게시자의 몇번째 게시글인지 조회
		int aCnt = service.getCntByAuthor(vo.getAuthor());
		//댓글 출력
		ArrayList<DiaryCommentsVO> dcList = service.getDiaryComm(vo.getDiaryId());
		
		
		mv.addObject("aCnt", aCnt);
		mv.addObject("diary", vo);
		mv.addObject("dcList", dcList);

		return mv;
	}
	
	//좋아요 추천
	@GetMapping("/DiaryRcmdCall")
	public void DiaryRcmdCall(@RequestParam(value = "idx", required = true) String idx, HttpServletResponse response) throws Exception {

		service.addDiaryRcmd(idx);

		int recommendationCnt = service.getDiaryRcmd(idx);

		PrintWriter out = response.getWriter();
		DecimalFormat decFormat = new DecimalFormat("###,###");
		String recommendationCntStr = decFormat.format(recommendationCnt);

		out.append(recommendationCntStr);
		out.flush();
		System.out.println("DiaryRcmdCall start" + idx);
	}
	

	// 상세 페이지 하단 댓글달기 (목록 페이지 > 상세페이지 = 댓글달기 )
	@RequestMapping(value = "/addDiaryComm", method = RequestMethod.POST)
	ModelAndView addCookingShowComments(@ModelAttribute("dc") DiaryCommentsVO dcVO) throws Exception {

		System.out.println("addDiaryComm start");
		ModelAndView modelAndView = new ModelAndView();

		try {
			service.addDiaryComm(dcVO);
			modelAndView.setViewName("redirect:./medi-community-detail?diaryId=" + dcVO.getDiaryId());

		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("err", "오류 발생");
			modelAndView.setViewName("error");

		}
		return modelAndView;
	}
	
}
