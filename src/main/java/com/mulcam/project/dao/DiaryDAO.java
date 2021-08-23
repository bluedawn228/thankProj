package com.mulcam.project.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.mulcam.project.vo.DiaryCommentsVO;
import com.mulcam.project.vo.DiaryVO;
import com.mulcam.project.vo.PharseVO;

@Mapper
@Repository
public interface DiaryDAO {
	
	public int selectMaxId();
	
	public void insertOneArticle(DiaryVO vo);
	
	public DiaryVO selectRecentOneByAuthor(String author);
	
	public DiaryVO selectOneByDiaryId(int diaryId);
	
	public int countAllPharse();
	
	public void updateOpenDiary(int diaryId);
	
	public PharseVO selectOnePharse(int randomNum);
	
	public ArrayList<DiaryVO> selectAllByAuthor(String author);
	
	public int selectCntByAuthor(String author);
	
	public ArrayList<DiaryVO> selectAllOpenedForPaging(@Param("startrow") int startrow, @Param("endrow") int endrow);
	
	public ArrayList<DiaryVO> selectByAuthorForPaging(@Param("author") String author, @Param("startrow") int startrow, @Param("endrow") int endrow);

	public PharseVO selectPharseById(int phrId);
	
	public void updateDairyRcmdByID(String articleId);
	
	public void updateDiaryCommById(int diaryId);

	public int selectDiaryRcmdById(String diaryId);

	public void insertDairyRcmdByID(String diaryId);

	public void insertDiaryCommById(DiaryCommentsVO vo);

	public int selectDiaryCommMaxId(int diaryId);

	public ArrayList<DiaryCommentsVO> selectDiaryCommById(int diaryId);

	public ArrayList<DiaryVO> selectMyDiary(@Param("author") String author, @Param("startrow") int startrow);

	public ArrayList<DiaryVO> selectOpenedDiary(int startrow);
	
	public int selectCntAll();

	public void updateViewCnt(int diaryId);
	
	public void updateCommCnt(int diaryId);

	public void deleteDiary(int diaryId);

	public void updateDiaryClosed(int diaryId);

	public void updateDiaryOpened(int diaryId);
	
	

	

}
