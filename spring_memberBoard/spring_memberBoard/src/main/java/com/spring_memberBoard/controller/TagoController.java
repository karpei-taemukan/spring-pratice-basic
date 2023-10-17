package com.spring_memberBoard.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.service.TagoService;

@Controller
public class TagoController {
	
	@Autowired
	private TagoService tagosvc;

	@RequestMapping(value = "/tagoBus")
	public ModelAndView tagoBus() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("TagoBus");
		return mav;
	}
	
	@RequestMapping(value = "/getTagoSttnList")
	public @ResponseBody String getTagoSttnList(String lati, String longi) throws IOException {
		System.out.println("정류소 목록 조회 요청 - /getTagoSttnList 요청");
		System.out.println(lati + " : " + longi);
		// SERVICE - 국토교통부_(TAGO)_버스정류소정보 조회 기능 호출
		String result = tagosvc.getBusSttnList(lati, longi);
		return result;
	}
	
	@RequestMapping(value = "/getTagoBusArrList") 
	public @ResponseBody String getTagoBusArrList(String citycode, String nodeid) throws IOException {
		System.out.println("버스 도착 예정 정보 조회 요청 - /getTagoBusArrList");
		System.out.println(citycode + " : " + nodeid);
		// SERVICE - 국토교통부_(TAGO)_버스도착정보 조회 기능 호출
		String result = tagosvc.getBusArrList(citycode, nodeid);
		return result;
	}
	
	@RequestMapping(value = "/getTagoBusNodeList")
	public @ResponseBody String getTagoBusNodeList(String citycode, String routeid) throws IOException {
		System.out.println("버스노선정보 조회 요청 - /getTagoBusNodeList");
		System.out.println("도시코드 : " + citycode+", 버스ID : "+routeid);
		String result = tagosvc.getTagoBusNodeList(citycode, routeid);
		return result;
	}
	
	@RequestMapping(value = "/getTagoBusLocList")
	public @ResponseBody String getTagoBusLocList(String citycode, String routeid) throws IOException {
		System.out.println("버스위치정보 조회 요청 - /getTagoBusLocList");
		System.out.println("도시코드 : " + citycode+", 버스ID : "+routeid);
		String result = tagosvc.getTagoBusLocList(citycode, routeid);
		return result;
	}	
	
	
	
}











