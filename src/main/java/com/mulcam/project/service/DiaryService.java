package com.mulcam.project.service;

import com.mulcam.project.vo.DiaryVO;
import com.mulcam.project.vo.PharseVO;

public interface DiaryService {
	
	public void registOneArticle(DiaryVO vo);
	
	public DiaryVO  getRecentOneArticleByAuthor(String author);
	
	public DiaryVO  getArticleById(int diaryId);
	
	public PharseVO  getRandomPharse();
	
	public DiaryVO  getArticlesByAuthor(String author, int startrow, int endrow);
	
	public DiaryVO  getAllOpenedArticles(int startrow, int endrow);
	
	


}
