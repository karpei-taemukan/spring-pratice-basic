package com.spring_memberBoard.dto;

import lombok.Data;

@Data
public class Reply {
	private int renum;			//댓글번호
	private int rebno;          //게시글 번호
	private String remid;       //작성자
	private String recomment;   //내용
	private String redate;      //작성일
	private String restate;     // 상태
}






