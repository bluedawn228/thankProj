package com.mulcam.project.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface DepressionInventoryController {
	
	public ModelAndView bdi();
	
	public ModelAndView bdiMain() ;
	
	public ModelAndView bdiResult();
	
	public void bdiEmailSend(String email, String bdiResult, HttpServletResponse response)  throws IOException;
	

}
