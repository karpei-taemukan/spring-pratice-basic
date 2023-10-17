package com.spring_memberBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.spring_memberBoard.dto.Bus;
import com.spring_memberBoard.service.ApiService;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvc;

	@RequestMapping(value = "/busapi")
	public ModelAndView busapi() throws Exception  {
		System.out.println("버스도착정보 페이지 이동요청 - /busapi");
		ModelAndView mav = new ModelAndView();
		
		//1. 버스 도착 정보 조회
		ArrayList<Bus> result = apisvc.getBusArrive();
		mav.addObject("busList",result);
		
		//2. 버스도착정보 페이지
		mav.setViewName("BusList"); //views/BusList.jsp
		return mav;
	}
	
	// 버스 도착 정보 페이지 이동요청
	@RequestMapping(value = "/busapi_ajax")
	public ModelAndView busapi_ajax() {
		System.out.println("버스도착정보 페이지 이동요청 - /busapi_ajax 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("BusArriveInfo2");
		return mav;
	}
	
	@RequestMapping(value = "/getBusArr")
	public @ResponseBody String getBusArr(String nodeId) {
		System.out.println("버스 도착정보 조회 요청 - /getBusArr");
		System.out.println("nodeId : " + nodeId);
		//1. SERVICE - 도착정보 조회 기능 호출 
		String arrInfoList = null;
		try {
			arrInfoList = apisvc.getBusArrInfoList(nodeId);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//2. 도착정보 반환
		return arrInfoList;
	}
	private final String a =""; 
	@RequestMapping(value = "/getBusSttn")
	public @ResponseBody String getBusSttn(String lati, String longti) {
		System.out.println("주변 정류소 정보 조회 요청 - /getBusSttn");
		System.out.println("lati : " + lati);
		System.out.println("longti : " + longti);
		//1. SERVICE - 주변 정류소 조회 기능 호출 
		String arrInfoList = "";
		try {
			arrInfoList = apisvc.getBusSttnList(lati,longti);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//2. 도착정보 반환
		return arrInfoList;
	}	
	
	
	@RequestMapping(value = "/getBusNodeList")
	public @ResponseBody String getBusNodeList(String routeid) throws IOException {
		return apisvc.getBusNodeList(routeid);
	}
	
	@RequestMapping(value = "/getBusLocList")
	public @ResponseBody String getBusLocList(String routeid) throws IOException {
		return apisvc.getBusLocList(routeid);
	}
	
}









