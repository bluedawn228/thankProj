package com.mulcam.project.service;

import java.util.ArrayList;

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
		
		//명언 내용 조회
			@Override
			public PharseVO  getPharseById(int phrId){
				return dao.selectPharseById(phrId);
			}
		
	//게시자의 개시글 갯수 조회
	@Override
	public int getCntByAuthor(String author) {
		return dao.selectCntByAuthor(author);
	}
	//게시글 1개 조회
	@Override
	public DiaryVO  getArticleById(int diaryId){
		System.out.println("++++++++++++service++++++++++++");
		DiaryVO vo = dao.selectOneByDiaryId(diaryId);
		System.out.println(vo.getStmAnlsPst());
		System.out.println(vo.getStmAnlsNgt());
		return dao.selectOneByDiaryId(diaryId);
	}
	
	//최종 게시글 1개 조회
	@Override
	public DiaryVO  getRecentOneArticleByAuthor(String author){
		return dao.selectRecentOneByAuthor(author);
	}
	
	//게시글 공개 여부 공개로 변경
	@Override
	public void openDiaryById(int diaryId) {
		dao.updateOpenDiary(diaryId);
	}
	
	//작성자의 모든 게시글 조회(페이징)	
	@Override
	public ArrayList<DiaryVO>  getArticlesByAuthor(String author, int startrow, int endrow){
		return dao.selectByAuthorForPaging(author, startrow, endrow);
	}
	
	
	//모든 공개 게시글 조회(페이징)
	@Override
	public ArrayList<DiaryVO>  getAllOpenedArticles(int startrow, int endrow){
		System.out.println("++++++++++"+ startrow+"+++++++++++++"+ endrow+"+++++++++++");
		return dao.selectAllOpenedForPaging(startrow, endrow);
	}
	
}
