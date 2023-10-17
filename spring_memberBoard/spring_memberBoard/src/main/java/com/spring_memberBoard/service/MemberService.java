package com.spring_memberBoard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spring_memberBoard.dao.MemberDao;
import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao mdao;

	public String midCheck(String inputId) {
		System.out.println("SERVICE - midCheck() 호출");
		System.out.println("아이디 : " + inputId);
		// DAO - SELECT MID FROM MEMBERS WHERE MID = #{아이디};
		Member member = mdao.selectMemberInfo(inputId);
		System.out.println(member);
		
		HashMap<String, String> member_mapper = mdao.selectMemberInfo_mapper(inputId);
		System.out.println(member_mapper);
		
		System.out.println(new Gson().toJson(member_mapper));
		
		String result = "N"; // 중복확인 결과 Y:사용가능 N:사용불가(중복)
		if(member == null) {
			result = "Y";
		}
		return result;
	}

	// 회원가입 기능 
	public int registMember(Member member) {
		System.out.println("SERVICE - registMember() 호출");
		// DAO 호출 - INSERT INTO MEMBERS().......
		int joinResult = 0;
		try {
			joinResult = mdao.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return joinResult;
	}

	// 로그인 - 회원정보 조회
	public Member getLoginMemberInfo(String mid, String mpw) {
		System.out.println("SERVICE - getLoginMemberInfo() 호출");
		// DAO - 회원정보 조회 
		// SELECT * FROM MEMBERS
		// WHERE MID = #{파라메터명} AND MPW = #{파라메터명}
		Member mInfo = mdao.selectMemberLogin(mid, mpw);
		return mInfo;
	}

	//회원정보 조회
	public Member getMemberInfo(String loginId) {
		System.out.println("SERVICE - getMemberInfo 호출");
		// SELECT * FROM MEMBERS WHERE MID = #{...}
		Member member = mdao.selectMemberInfo(loginId);
		
		return member;
	}
	//회원정보 수정
	public int modifyMemberInfo(Member member) {
		System.out.println("SERVICE - modifyMemberInfo 호출");
		
		int result = 0;
		try {
			// DAO - UPDATE문
			result = mdao.updateMemberInfo(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 회원의 작성글 개수 조회
	public int getMemBCount(String loginId) {
		System.out.println("SERVICE - getMemBCount'() 호출");
		return mdao.selectMemberBCount(loginId);
	}

	public ArrayList<Board> getMemberBoardList(String loginId) {
		return mdao.selectMemberBCount2(loginId);
	}

	public int getMemReCount(String loginId) {
		System.out.println("SERVICE - getMemReCount'() 호출");
		return mdao.selectMemberReCount(loginId);
	}

	
	
}











