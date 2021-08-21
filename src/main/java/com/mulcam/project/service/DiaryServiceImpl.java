package com.mulcam.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mulcam.project.dao.DiaryDAO;
import com.mulcam.project.vo.DiaryVO;
import com.mulcam.project.vo.PharseVO;

@Service
public class DiaryServiceImpl implements DiaryService {

	@Autowired
	DiaryDAO dao;
	
	//게시글 1개 insert
	@Override
	public void registOneArticle(DiaryVO vo) {
		
		//마지막 게시글 id 	조회
		int currentId = dao.selectMaxId();
		
		//다음 게시글 id 생성 및 vo 입력
		int nextId = currentId+1;
		vo.setDiaryId(nextId);
		
		//게시글 입력
		dao.insertOneArticle(vo);
	}
	
	//명언 랜덤으로 1개 조회
		@Override
		public PharseVO  getRandomPharse(){
			int max = dao.countAllPharse();
			int min = 1;
			int randomNum = (int) ((Math.random() * (max - min)) + min);
			return dao.selectOnePharse(randomNum);
		}
		
	
	//게시글 1개 조회
	@Override
	public DiaryVO  getArticleById(int diaryId){
		return dao.selectOneByDiaryId(diaryId);
	}
	
	//최종 게시글 1개 조회
	@Override
	public DiaryVO  getRecentOneArticleByAuthor(String author){
		return dao.selectRecentOneByAuthor(author);
	}
	
	
	//작성자의 모든 게시글 조회(페이징)	
	@Override
	public DiaryVO  getArticlesByAuthor(String author, int startrow, int endrow){
		return dao.selectByAuthorForPaging(author, startrow, endrow);
	}
	
	
	//모든 공개 게시글 조회(페이징)
	@Override
	public DiaryVO  getAllOpenedArticles(int startrow, int endrow){
		return dao.selectAllOpenedForPaging(startrow, endrow);
	}
	
}
