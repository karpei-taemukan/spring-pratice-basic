package com.spring_memberBoard.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		System.out.println("메인 페이지 이동 요청 - /");
		return "MainPage";
	}
	@RequestMapping(value = "/mainpage", method = RequestMethod.GET)
	public String mainpage() {
		System.out.println("메인 페이지 이동 요청 - /mainpage");
		return "MainPage";
	}
	
}












