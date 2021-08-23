package com.mulcam.project.controller;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
  			
  			//긍정도와 부정도를 합산하여 긍정도 가중평균으로 전환(소주 2자리까지 계산)
  			vo.setPgStat( Double.parseDouble(String.format("%.2f",vo.getStmAnlsPst()/(vo.getStmAnlsPst()+vo.getStmAnlsNgt())*100)) ) ;
  			
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
		
		//목록 화면에서 content 말줄임 처리
		for(DiaryVO dvo : authorList) {
			String oriContent = dvo.getContent();
			
		    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
		    dvo.setContent(abbrContent);
		}
		
		//목록 화면에서 댓글 개수를 갱신처리 해준다
		for(DiaryVO dvo : authorList) {
		    service.refreshCommCnt(dvo.getDiaryId());
		}
		
		//작성자의 게시글 개수
		int authorCnt = service.getCntByAuthor(authorId); 
		mv.addObject("authorCnt", authorCnt);
		
		mv.addObject("authorList", authorList);
		
		// =================================                공개 감상일기                        ===================================
		ArrayList<DiaryVO> voList= service.getAllOpenedArticles(startrow, endrow*3);
		
		//목록 화면에서 content 말줄임 처리
				for(DiaryVO vo : voList) {
					String oriContent = vo.getContent();
				    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
				    vo.setContent(abbrContent);
				}
				
		//목록 화면에서 댓글 개수를 갱신처리 해준다
		for(DiaryVO dvo : authorList) {
		    service.refreshCommCnt(dvo.getDiaryId());
		}		
		
		//전체 게시글 개수
		int allCnt = service.getCntAll(); 
		mv.addObject("allCnt", allCnt);		
		mv.addObject("openedList", voList);
		return mv;
	}
	
	@Override
	@GetMapping("/medi-community-detail")
	public ModelAndView mediCommunityDetail(@RequestParam(value="diaryId") String diaryId) {
		ModelAndView mv = new ModelAndView("medi-community-detail");
		System.out.println("medi-community-detail ===== diaryId " + diaryId);
		DiaryVO vo= service.getArticleById(Integer.parseInt(diaryId));
		
		//조회수 업데이트
		service.increaseViewCnt(Integer.parseInt(diaryId));
		
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
	@Override
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
	@Override
	@RequestMapping(value = "/addDiaryComm", method = RequestMethod.POST)
	public ModelAndView addDiaryComm(@ModelAttribute("dc") DiaryCommentsVO dcVO) throws Exception {

		System.out.println("addDiaryComm start");
		ModelAndView modelAndView = new ModelAndView();

		try {
			service.addDiaryComm(dcVO);
			
			//댓글 개수를 갱신처리 해준다
			service.refreshCommCnt(dcVO.getDiaryId());
	
			modelAndView.setViewName("redirect:./medi-community-detail?diaryId=" + dcVO.getDiaryId());

		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("err", "오류 발생");
			modelAndView.setViewName("error");

		}
		return modelAndView;
	}
	
	// 감사일기 커뮤니티 - 나의 게시글 (first)
	@Override
	@GetMapping("/medi-community-mypage")
	public ModelAndView mediCommunityMypageFirst(@RequestParam (value="page", required=false, defaultValue="1") int page, @RequestParam(value="authorId", defaultValue="test") String authorId) {
		ModelAndView mv = new ModelAndView("medi-community-mypage");
		ArrayList<DiaryVO> mdList = new ArrayList<DiaryVO>();
		System.out.println("==============medi-community-mypage  +++ call ==="+page+" +++ " +authorId+"==========");
		//게시글을 12개씩 조회
		int startrow = ( (page-1)*12  > 0 ? (page-1)*12  : 0 )+1 ;   // 1page 1 ~ 12,  2page 13~24
		
		//게시글 조회
		mdList = service.getMyDiary(authorId, startrow);
		
		//목록 화면에서 content 말줄임 처리
		for(DiaryVO dvo : mdList) {
			String oriContent = dvo.getContent();
		    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
		    dvo.setContent(abbrContent);
		}
		
		//목록 화면에서 댓글 개수를 갱신처리 해준다
		for(DiaryVO dvo : mdList) {
		    service.refreshCommCnt(dvo.getDiaryId());
		}		
		
		//작성자의 게시글 개수
		int authorCnt = service.getCntByAuthor(authorId); 
		mv.addObject("authorCnt", authorCnt);
		mv.addObject("page",page);
		mv.addObject("author",authorId);
		mv.addObject("mdList", mdList);

		return mv;
	}
	
	// 감사일기 커뮤니티 - 나의 게시글 (infinite)
		@Override
		@PostMapping("/medi-community-mypage")
		public @ResponseBody List<DiaryVO> mediCommunityMypageNext(@RequestBody DiaryVO vo) {

			ArrayList<DiaryVO> mdList = new ArrayList<DiaryVO>();
			System.out.println("==============medi-community-mypage  +++ call ==impl===="+vo.getPage()+"=======");
			//게시글을 12개씩 조회
			int pageValue = vo.getPage();
			
			int startrow = ( (pageValue-1)*12  > 0 ? (pageValue-1)*12  : 0 )+1 ;   // 1page 1 ~ 12,  2page 13~24
			
			
			//게시글 조회
			mdList = service.getMyDiary(vo.getAuthor(), startrow);
			
			//목록 화면에서 content 말줄임 처리
			for(DiaryVO dvo : mdList) {
				String oriContent = dvo.getContent();
			    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
			    dvo.setContent(abbrContent);
			}
			
			
			//목록 화면에서 댓글 개수를 갱신처리 해준다
			for(DiaryVO dvo : mdList) {
			    service.refreshCommCnt(dvo.getDiaryId());
			}		
			
			return mdList;
		}
	
		// 감사일기 커뮤니티 - 공개 게시글 (first)
		@Override
		@GetMapping("/medi-community-opened")
		public ModelAndView mediCommunityOpenedPageFirst(@RequestParam (value="page", required=false, defaultValue="1") int page) {
			ModelAndView mv = new ModelAndView("medi-community-opened");
			ArrayList<DiaryVO> mdList = new ArrayList<DiaryVO>();
			System.out.println("==============medi-community-opened  +++ call ==="+page+" ======");
			//게시글을 12개씩 조회
			int startrow = ( (page-1)*12  > 0 ? (page-1)*12  : 0 )+1 ;   // 1page 1 ~ 12,  2page 13~24
			
			//게시글 조회
			mdList = service.getOpenedDiary(startrow);
			
			//목록 화면에서 content 말줄임 처리
			for(DiaryVO dvo : mdList) {
				String oriContent = dvo.getContent();
			    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
			    dvo.setContent(abbrContent);
			}
			
			//목록 화면에서 댓글 개수를 갱신처리 해준다
			for(DiaryVO dvo : mdList) {
			    service.refreshCommCnt(dvo.getDiaryId());
			}		
			//전체 게시글 개수
			int allCnt = service.getCntAll(); 
			mv.addObject("allCnt", allCnt);		
			mv.addObject("page",page);
			mv.addObject("mdList", mdList);

			return mv;
		}
		
		// 감사일기 커뮤니티 - 공개 게시글 (infinite)
		@Override
		@PostMapping("/medi-community-opened")
		public @ResponseBody List<DiaryVO> mediCommunityOpenedPageNext(@RequestBody DiaryVO vo) {

			ArrayList<DiaryVO> mdList = new ArrayList<DiaryVO>();
			System.out.println("==============medi-community-mypage  +++ call ==impl===="+vo.getPage()+"=======");
			//게시글을 12개씩 조회
			int pageValue = vo.getPage();
			
			int startrow = ( (pageValue-1)*12  > 0 ? (pageValue-1)*12  : 0 )+1 ;   // 1page 1 ~ 12,  2page 13~24
			
			
			//게시글 조회
			mdList = service.getOpenedDiary(startrow);
			
			//목록 화면에서 댓글 개수를 갱신처리 해준다
			for(DiaryVO dvo : mdList) {
			    service.refreshCommCnt(dvo.getDiaryId());
			}		
			
			//목록 화면에서 content 말줄임 처리
			for(DiaryVO dvo : mdList) {
				String oriContent = dvo.getContent();
			    String abbrContent = oriContent.substring(0, oriContent.length() < 30 ? oriContent.length() : 29 )+"...";
			    dvo.setContent(abbrContent);
			}
			
			return mdList;
		}
		
		
		//감사일기 삭제
		@Override
		@GetMapping("/deleteDiary")
		public ModelAndView deleteDiary(@RequestParam("diaryId") String diaryId) {
			ModelAndView mv = new ModelAndView("redirect:/medi-community");
			service.deleteDiary(Integer.parseInt(diaryId));
			return mv;
		}
		
		//감사일기 공유 취소(비공개 전환)
		@Override
		@GetMapping("/cancleDiaryShare")
		public ModelAndView cancleDiaryShare(@RequestParam("diaryId") String diaryId) {
			ModelAndView mv = new ModelAndView("redirect:/medi-community");
			service.cancelDiaryShare(Integer.parseInt(diaryId));
			return mv;
		}
		
		//감사일기 공유 (공개 전환)
		@Override
		@GetMapping("/openDiary")
		public ModelAndView openDiary(@RequestParam("diaryId") String diaryId) {
			ModelAndView mv = new ModelAndView("redirect:/medi-community");
			service.openDiary(Integer.parseInt(diaryId));
			return mv;
		}
		

}
