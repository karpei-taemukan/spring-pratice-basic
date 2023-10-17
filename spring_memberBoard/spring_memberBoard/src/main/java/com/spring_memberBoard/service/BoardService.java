package com.spring_memberBoard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Reply;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao bdao;
	
	//글 등록 기능
	public int registBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("SERVICE - registBoard() 호출");
		// 업로드된 파일 저장 - 저장경로 설정, 중복파일명 처리
		MultipartFile bfile = board.getBfile(); // 첨부파일
		String bfilename = ""; // 파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); // 파일을 저장할 경로
		if( !bfile.isEmpty() ){ // 첨부파일 확인
			// 첨부파일이 있는 경우
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");
			UUID uuid  = UUID.randomUUID();
			String code = uuid.toString();
			bfilename = code + "_" + bfile.getOriginalFilename();
			//저장할 경로 resources/boardUpload 폴더에 파일저장
			System.out.println("savePath : " + savePath );
			File newFile = new File( savePath  , bfilename );
			bfile.transferTo( newFile );
		} 
		System.out.println("파일이름 : " + bfilename);
		board.setBfilename(bfilename);
		System.out.println(board); // 제목, 내용, 작성자, 첨부파일명
		
		// 글번호 생성 ( 최대값 + 1 ) - SELECT NVL( MAX(BNO), 0 ) FROM BOARDS
		int bno = bdao.selectMaxBno() + 1;
		board.setBno(bno); // 생성된 글번호 board에 저장
		
/* DAO - INSERT INTO BOARDS(BNO,BWRITER,BTITLE,BCONTENTS,BHITS,BDATE,BFILENAME,BSTATE)
         VALUES(#{bno},#{bwriter}, #{btitle}, #{bcontents}, 0, SYSDATE,#{bfilename}, '1');        */
		int insertResult = 0;
		try {
			insertResult = bdao.insertBoards(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// INSERT 결과 반환
		return insertResult;
	}

	// 글 상세정보 조회 기능
	public Board getBoardView(int bno) {
		System.out.println("SERVICE - getBoardView()");
		//1. 조회수 증가
		
		//2. 글 정보 조회
		// SELECT * FROM BOARDS WHRE BNO = #{bno}
		Board board = bdao.selectBoardInfo(bno);
		System.out.println(board);
		//3. 글내용 줄바꿈 문자 >> HTML 태그로 치환
		return board;
	}

	public ArrayList<Board> getBoardList() {
		System.out.println("SERVICE - getBoardList() 호출");
		// DAO - SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BDATE DESC
		ArrayList<Board> bList = bdao.selectBoards();
		for(Board bo : bList) { //int i = 0; i < bList.size(); i++
			int recount = bdao.selectBoardRecount( bo.getBno() );
			bo.setRecount(recount);
		}
		System.out.println(bList);
		return bList;
	}
	
	public ArrayList<HashMap<String, String>> getBoardList_map() {
		System.out.println("SERVICE - getBoardList_map() 호출");
		return bdao.selectBoards_map();
	}
	
	
	
	// 댓글 등록 기능
	public int registReply(Reply re) {
		System.out.println("SERVICE - registReply() 호출");
		//1. 댓글 번호 생성
		int renum = bdao.selectMaxRenum() + 1;
		re.setRenum(renum);// renum 필드에 댓글번호저장
		//2. DAO - INSERT문 호출
		int insertResult = 0; 
		try {
			insertResult = bdao.insertReply(re);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return insertResult;
	}
	
	//댓글 목록 조회 기능
	public ArrayList<Reply> getReplyList(int rebno) {
		System.out.println("SERVICE - getReplyList() 호출");
		/* SELECT * FROM REPLYS WHERE REBNO = #{rebno} */
		return bdao.selectReplyList(rebno);
	}

	public int deleteReply(int renum) {
		System.out.println("SERVICE - deleteReply() 호출");
		return bdao.deleteReply(renum);
	}



}










