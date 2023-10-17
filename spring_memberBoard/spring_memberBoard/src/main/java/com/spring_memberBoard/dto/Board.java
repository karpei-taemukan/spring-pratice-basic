package com.spring_memberBoard.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Board {
	private int bno;	         //번호
	private String bwriter;      //작성자
	private String btitle;       //제목
	private String bcontents;    //내용
	private int bhits;           //조회수
	private String bdate;        //작성일
	private String bstate;       //상태
	
	private String bfilename;    //파일이름
	private MultipartFile bfile; //첨부파일
	
	
	private int recount;         //댓글 수 
	
	
	
}







