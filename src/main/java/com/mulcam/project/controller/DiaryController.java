package com.mulcam.project.controller;

import org.json.simple.parser.ParseException;
import org.springframework.web.servlet.ModelAndView;

import com.mulcam.project.vo.DiaryVO;

public interface DiaryController {
	
	public String medi() ;
	
	public String mediStep01() ;
	
	public ModelAndView mediStep02(DiaryVO vo) throws ParseException ;
	
	public String mediCommunity() ;

}
