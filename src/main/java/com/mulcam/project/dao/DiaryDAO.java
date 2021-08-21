package com.mulcam.project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

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
	
	public PharseVO selectOnePharse(int randomNum);
	
	public DiaryVO selectAllByAuthor(String author);
	
	public int selectCntByAuthor(String author);
	
	public DiaryVO selectAllOpenedForPaging(@Param("startrow") int startrow, @Param("endrow") int endrow);
	
	public DiaryVO selectByAuthorForPaging(@Param("author") String author, @Param("startrow") int startrow, @Param("endrow") int endrow);
	
	
	
	

}
