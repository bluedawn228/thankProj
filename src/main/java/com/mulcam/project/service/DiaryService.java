package com.mulcam.project.service;

import java.util.ArrayList;

import com.mulcam.project.vo.DiaryCommentsVO;
import com.mulcam.project.vo.DiaryVO;
import com.mulcam.project.vo.PharseVO;

public interface DiaryService {
	
	public void registOneArticle(DiaryVO vo);
	
	public DiaryVO  getRecentOneArticleByAuthor(String author);
	
	public DiaryVO  getArticleById(int diaryId);
	
	public void openDiaryById(int diaryId);
	
	public int getCntByAuthor(String author);
	
	public PharseVO  getRandomPharse();
	
	public PharseVO  getPharseById(int id);
	
	public ArrayList<DiaryVO>  getArticlesByAuthor(String author, int startrow, int endrow);
	
	public ArrayList<DiaryVO>  getAllOpenedArticles(int startrow, int endrow);
	
	public void addDiaryRcmd(String diaryId) ;
	
	public int getDiaryRcmd(String diaryId) ;
	
	public void addDiaryComm(DiaryCommentsVO vo) ;
	
	public ArrayList<DiaryCommentsVO> getDiaryComm(int diaryId);

	public ArrayList<DiaryVO> getMyDiary(String authorId, int startrow);

	public ArrayList<DiaryVO> getOpenedDiary(int startrow);
	
	public int getCntAll() ;

	public void increaseViewCnt(int diaryId);
	
	public void refreshCommCnt(int diaryId);
	
	public void deleteDiary(int diaryId) ;
	
	public void cancelDiaryShare(int diaryId) ;

	public void openDiary(int diaryId);

}
