package com.mulcam.project.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mulcam.project.dao.DiaryDAO;
import com.mulcam.project.vo.DiaryCommentsVO;
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
	
	//게시자의 개시글 갯수 조회
		@Override
		public int getCntAll() {
			return dao.selectCntAll();
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
	
	//좋아요 1 추가
	@Override
	public void addDiaryRcmd(String diaryId) {
		dao.updateDairyRcmdByID(diaryId);

	}

	//좋아요 개수 조회
	@Override
	public int getDiaryRcmd(String diaryId) {
		return dao.selectDiaryRcmdById(diaryId);
	}
	
	//댓글 최종 id 조회
	public int getDiaryCommMaxId(int diaryId) {
		
		return dao.selectDiaryCommMaxId(diaryId);
	}
	
	//댓글 달기
	@Override
	public void addDiaryComm(DiaryCommentsVO vo) {
		int currCidx = getDiaryCommMaxId(vo.getDiaryId());
		vo.setCidx(currCidx+1);
		 dao.insertDiaryCommById(vo);
	}
	
	//댓글 조회
		@Override
		public ArrayList<DiaryCommentsVO> getDiaryComm(int diaryId) {
			 return dao.selectDiaryCommById(diaryId);
		}

	//나의 일기 조회 -12개씩 조회
		@Override
		public ArrayList<DiaryVO> getMyDiary(String authorId, int startrow) {
			
			return dao.selectMyDiary( authorId,  startrow);
		}

		// 공개 게시글 조회 - 12개씩 조회
		@Override
		public ArrayList<DiaryVO> getOpenedDiary(int startrow) {

			return dao.selectOpenedDiary(startrow);
		}
	
		// 조회수 업데이트 viewCnt +1
		@Override
		public void increaseViewCnt(int diaryId) {
			dao.updateViewCnt(diaryId);
		}
		
		// 댓글 개수 갱신
		@Override
		public void refreshCommCnt(int diaryId) {
			System.out.println("==========	댓글 개수 갱신============");
			dao.updateCommCnt(diaryId);
		}
		
		// 감상일기 삭제
		@Override
		public void deleteDiary(int diaryId) {
			System.out.println("==========감상일기 삭제 "+ diaryId  +"============");
			dao.deleteDiary(diaryId);
		}
		
		// 감상일기 비공개 전환
		@Override
		public void cancelDiaryShare(int diaryId) {
			System.out.println("==========감상일기 비공개 전환  "+ diaryId  +"============");
			dao.updateDiaryClosed(diaryId);
		}

		//감상일기 공개로 전환
		@Override
		public void openDiary(int diaryId) {
			System.out.println("==========감상일기 공개 전환  "+ diaryId  +"============");
			dao.updateDiaryOpened(diaryId);
			
		}
}
