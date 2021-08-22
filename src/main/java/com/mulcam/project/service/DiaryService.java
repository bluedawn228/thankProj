package com.mulcam.project.service;

import java.util.ArrayList;

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
	
	


}
