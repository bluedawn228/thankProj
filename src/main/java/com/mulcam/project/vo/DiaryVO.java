package com.mulcam.project.vo;

import java.util.Date;

public class DiaryVO {
	
    private int diaryId;
    private int imgId;
    
    //이모티콘
    private int emcId;
    
    //명언
    private int phrsId;
    
    //명상 영상
    private String mvId;
    private int mvDrt;
    private String mvDT;
    
    private String author;
    
    //태그
    private String tags;

    
    private String content;
    private int opened;
    
    private int commCnt;
    private int rcmdCnt;
    private int viewCnt;
    
    //클로바 감정 분석
    private double stmAnlsPst;
    private double stmAnlsNtr;
    private double stmAnlsNgt;
    
    
    private Date regdate;
    private Date moddate;
    
    
    //이모티콘 
    private String emcData;
    private String emcText;
    //클로바 감정 분석
    private double pgStat;
    
    //태그    
    private String[] tagList;
    
	public int getDiaryId() {
		return diaryId;
	}
	public void setDiaryId(int diaryId) {
		this.diaryId = diaryId;
	}
	public int getImgId() {
		return imgId;
	}
	public void setImgId(int imgId) {
		this.imgId = imgId;
	}
	public int getEmcId() {
		return emcId;
	}
	public void setEmcId(int emcId) {
		this.emcId = emcId;
	}
	public int getPhrsId() {
		return phrsId;
	}
	public void setPhrsId(int phrsId) {
		this.phrsId = phrsId;
	}
	public String getMvId() {
		return mvId;
	}
	public void setMvId(String mvId) {
		this.mvId = mvId;
	}
	public int getMvDrt() {
		return mvDrt;
	}
	public void setMvDrt(int mvDrt) {
		this.mvDrt = mvDrt;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOpened() {
		return opened;
	}
	public void setOpened(int opened) {
		this.opened = opened;
	}
	public int getCommCnt() {
		return commCnt;
	}
	public void setCommCnt(int commCnt) {
		this.commCnt = commCnt;
	}
	public int getRcmdCnt() {
		return rcmdCnt;
	}
	public void setRcmdCnt(int rcmdCnt) {
		this.rcmdCnt = rcmdCnt;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public double getStmAnlsPst() {
		return stmAnlsPst;
	}
	public void setStmAnlsPst(double stmAnlsPst) {
		this.stmAnlsPst = stmAnlsPst;
	}
	public double getStmAnlsNtr() {
		return stmAnlsNtr;
	}
	public void setStmAnlsNtr(double stmAnlsNtr) {
		this.stmAnlsNtr = stmAnlsNtr;
	}
	public double getStmAnlsNgt() {
		return stmAnlsNgt;
	}
	public void setStmAnlsNgt(double stmAnlsNgt) {
		this.stmAnlsNgt = stmAnlsNgt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getModdate() {
		return moddate;
	}
	public void setModdate(Date moddate) {
		this.moddate = moddate;
	}
	public String getEmcData() {
		return emcData;
	}
	public void setEmcData(String emcData) {
		this.emcData = emcData;
	}
	public String getEmcText() {
		return emcText;
	}
	public void setEmcText(String emcText) {
		this.emcText = emcText;
	}
	public String getMvDT() {
		return mvDT;
	}
	public void setMvDT(String mvDT) {
		this.mvDT = mvDT;
	}
	public double getPgStat() {
		return pgStat;
	}
	public void setPgStat(double pgStat) {
		this.pgStat = pgStat;
	}
	public String[] getTagList() {
		return tagList;
	}
	public void setTagList(String[] tagList) {
		this.tagList = tagList;
	}
	
	
    
    

}
