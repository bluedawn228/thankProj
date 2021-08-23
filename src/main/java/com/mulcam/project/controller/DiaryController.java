package com.mulcam.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.parser.ParseException;
import org.springframework.web.servlet.ModelAndView;

import com.mulcam.project.vo.DiaryCommentsVO;
import com.mulcam.project.vo.DiaryVO;

public interface DiaryController {
	
	public String medi() ;
	
	public String mediStep01() ;
	
	public ModelAndView mediStep01(DiaryVO vo) throws ParseException ;
	
	public ModelAndView mediStep02(int diaryId) throws ParseException ;
	
	public String mediShareUpdate( String diaryId,  String authorId);
	
	public ModelAndView mediCommunityDetail(String diaryId) ;
	
	public ModelAndView mediCommunity(String authorId);
	
	public void DiaryRcmdCall(String idx, HttpServletResponse response) throws Exception;
	
	public ModelAndView addDiaryComm(DiaryCommentsVO dcVO) throws Exception;
	
	public ModelAndView mediCommunityMypageFirst(int page, String authorId);
	
	public List<DiaryVO> mediCommunityMypageNext(DiaryVO vo);
	
	public ModelAndView mediCommunityOpenedPageFirst(int page);
	
	public List<DiaryVO> mediCommunityOpenedPageNext(DiaryVO vo);
	
	public ModelAndView deleteDiary(String diaryId) ;
	
	public ModelAndView cancleDiaryShare(String diaryId) ;
	
	public ModelAndView openDiary(String diaryId) ;

}
