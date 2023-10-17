package com.spring_memberBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;
import com.spring_memberBoard.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService bsvc;
	
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm() {
		System.out.println("글작성 페이지 이동요청 /boardWriteForm");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/BoardWriteForm");
		return mav;
	}
	
	// 글 등록 요청
	@RequestMapping(value = "/boardWrite")
	public ModelAndView boardWrite(Board board, HttpSession session, RedirectAttributes ra ){
		System.out.println("글 등록 요청 - /boardWrite");
		ModelAndView mav = new ModelAndView();
		
		String bwriter = (String) session.getAttribute("loginMemberId");
		board.setBwriter(bwriter);
		System.out.println(board); // 등록할 글 정보
		// 첨부파일 이름
		System.out.println(board.getBfile().getOriginalFilename());
		// SERVICE - 글 등록 기능 호출
		int writeResult = 0;
		try {
			writeResult = bsvc.registBoard(board, session);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if(writeResult > 0) {
			System.out.println("글 등록 성공");
			mav.setViewName("redirect:/boardList");     // 글 목록 페이지
			ra.addFlashAttribute("noticeMsg", "board");
		} else {
			System.out.println("글 등록 실패");
			mav.setViewName("redirect:/boardWriteForm");// 글 작성 페이지
		}
		return mav;
	}
	
	// /boardView?bno=1
	
	// 글 상세보기 요청
	@RequestMapping(value = "/boardView")
	public ModelAndView boardView(int bno) {
		System.out.println("글 상세 보기 요청 - /boardView");
		ModelAndView mav = new ModelAndView();
		System.out.println("상세보기 글번호 : " + bno);
		//1. 글 정보 조회 - SELECT * FROM BOARDS WHERE BNO = #{bno}
		Board board = bsvc.getBoardView(bno);
		mav.addObject("bo", board);
		
		//2. 글 상세보기 페이지 
		mav.setViewName("board/BoardView");
		return mav;
	}
	
	//글 목록 페이지 이동 요청
	@RequestMapping(value = "/boardList")
	public ModelAndView boardList() {
		System.out.println("글 목록 페이지 이동요청 - /boardList");
		ModelAndView mav = new ModelAndView();
		//1. 글 목록(List) 조회
		// SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BDATE DESC
		ArrayList<Board> bList = bsvc.getBoardList();
		//System.out.println(bList);
		mav.addObject("boardList", bList);
		
		// HashMap - 글목록 조회
		ArrayList< HashMap<String, String>  > bList_map = bsvc.getBoardList_map();
		System.out.println(bList_map);
		mav.addObject("bListMap", bList_map);
		
		mav.setViewName("board/BoardList");
		return mav;
	}
	
	@RequestMapping(value = "/replyWrite")
	public @ResponseBody String replyWrite(Reply re, HttpSession session) {
		System.out.println("댓글 등록 요청 - /replyWrite");
		//댓글 작성자 확인
		String remid = (String)session.getAttribute("loginMemberId");
		re.setRemid(remid); //remid 필드에 댓글 작성자 저장
		System.out.println(re);
		int result = bsvc.registReply(re);
		return result + "";
	}
	
	
	@RequestMapping(value = "/replyList")
	public @ResponseBody String replyList(int rebno) {
		System.out.println("댓글 조회 요청");
		System.out.println("댓글을 조회 할 글번호 : " + rebno);
		//1. SERVICE -  댓글 목록 조회
		// SELECT * FROM REPLYS WHERE REBNO = #{rebno}
		ArrayList<Reply> replyList = bsvc.getReplyList(rebno);
		// 조회된 댓글 목록 확인
		System.out.println(replyList.size());
		System.out.println(replyList);
		//2.JSON 변환 후 응답
		// gson 사용 { key : value } ( ArrayList >> JSON )
		Gson gson = new Gson();
		String reList = gson.toJson(replyList);
		System.out.println(reList);
		return reList;
	}
	
	
	@RequestMapping(value = "/deleteReply")
	public @ResponseBody String deleteReply(int renum) {
		System.out.println("댓글 삭제 요청 - /deleteReply");
		System.out.println("삭제할 댓글 번호 : " + renum);
		
		int result = bsvc.deleteReply(renum);
		
		return result+"";
	}
	
}















