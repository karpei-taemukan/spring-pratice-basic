package com.spring_memberBoard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService msvc;
	
	@RequestMapping(value = "/myInfo")
	public ModelAndView myInfo(HttpSession session) {
		System.out.println("회원정보 페이지 이동 요청 - /myInfo");
		ModelAndView mav = new ModelAndView();
		// 1. SERVICE - 회원정보 조회 
		// 회원정보를 조회 할 아이디 = 세션 loginMemberId
		// SELECT * FROM MEMBERS WHERE MID = ?;
		String loginId = (String)session.getAttribute("loginMemberId");
		System.out.println("회원정보를 조회 할 아이디 : "+loginId);
		Member member = msvc.getMemberInfo(loginId);
		mav.addObject("mInfo", member);
		// 2.SERVICE 작성한 글(BOARDS) 수 조회  
		int boardCount = msvc.getMemBCount(loginId);
		System.out.println("boardCount : " + boardCount );
		mav.addObject("boardCount", boardCount);
		
		ArrayList<Board> memberbList = msvc.getMemberBoardList(loginId);
		System.out.println("arrayList.size : " + memberbList.size());
		
		// 3.SERVICE 작성한 댓글(REPLYS) 수 조회
		int replyCount = msvc.getMemReCount(loginId);
		mav.addObject("replyCount", replyCount);
		
		// 4. member/MyInfo.jsp 응답 
		mav.setViewName("member/MyInfo");
		return mav;
	}
	
	@RequestMapping(value = "/memberModifyForm")
	public ModelAndView memberModifyForm(HttpSession session) {
		System.out.println("내정보 수정 페이지 이동요청 - /memberModifyForm");
		ModelAndView mav = new ModelAndView();
		// 1. SERVICE - 회원정보 조회 
		// 회원정보를 조회 할 아이디 = 세션 loginMemberId
		// SELECT * FROM MEMBERS WHERE MID = ?;
		String loginId = (String)session.getAttribute("loginMemberId");
		System.out.println("회원정보를 조회 할 아이디 : "+loginId);
		
		Member member = msvc.getMemberInfo(loginId);
		mav.addObject("mInfo", member);
		
		
		mav.setViewName("member/MemberModifyForm");
		return mav;
	}
	
	@RequestMapping(value = "/memberModify")
	public ModelAndView memberModify(Member member, RedirectAttributes ra) {
		System.out.println("회원정보 수정 요청 - /memberModify");
		ModelAndView mav = new ModelAndView();
		System.out.println(member);
		int updateResult = msvc.modifyMemberInfo(member);
		if( updateResult > 0 ) {
			System.out.println("회원정보 수정 성공");
			ra.addFlashAttribute("msg", "회원정보가 수정 되었습니다.");
		} else {
			System.out.println("회원정보 수정 실패");
			ra.addFlashAttribute("msg", "회원정보 수정을 실패하였습니다.");
		}
		mav.setViewName("redirect:/myInfo");
		return mav;
	}
	
	
	
	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 페이지 이동 요청 - /memberJoinForm");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}

	@RequestMapping(value = "/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아이디 중복 확인 요청");
	    System.out.println("중복 확인 할 아이디 : " + inputId);
		//1. 서비스 호출 - 아이디 중복 확인 기능 
		// MEMBERS 테이블의 MID 컬럼에 저장된 아이디 인지 확인
		// SELECT * FROM MEMBERS WHERE MID = #{아이디};
		String checkResult = msvc.midCheck(inputId);
		//2. 중복 확인 결과 반환 Y:사용가능 N:사용불가(중복)
		return checkResult; 
	}
	
	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(Member member, String memailId, String memailDomain,
			                       RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		// 가입할 회원 정보 파라메터 확인
		System.out.println("회원가입 요청");
		System.out.println(memailId);
		System.out.println(memailDomain);
		member.setMemail(memailId+"@"+memailDomain);
		System.out.println(member);
/*		Member(mid=TESTID, mpw=1111, mname=c, mbirth=2023-07-11, 
		memail=TE@naver.com, mstate=null) */
		// SERVICE - 회원가입 기능 호출 - INSERT INTO MEMBERS.....
		int joinResult = msvc.registMember(member);

		/* RedirectAttributes */
		if(joinResult > 0) {
			System.out.println("가입 성공");
			mav.setViewName("redirect:/"); // 메인 페이지 이동요청
			ra.addFlashAttribute("msg", "회원가입 되었습니다.");
		} else {
			System.out.println("가입 실패");
			mav.setViewName("redirect:/memberJoinForm"); // 회원가입페이지 이동요청
			ra.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
		}
		return mav;
	}
	
	/* 1. 로그인 페이지 이동 요청에 대한 처리 /memberLoginForm */
	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		ModelAndView mav = new ModelAndView();
		System.out.println("로그인 페이지 이동 요청 /memberLoginForm");
		mav.setViewName("member/MemberLoginForm");
		// WEB-INF/views/member/MemberLoginForm.jsp
		return mav;
	}
	
	/* 2. 로그인 요청에 대한 처리 /memberLogin */
	@RequestMapping(value = "/memberLogin")
	public ModelAndView memberLogin(String mid, String mpw, HttpSession session, RedirectAttributes ra) {
		System.out.println("로그인 처리 요청 - /memberLogin ");
		ModelAndView mav = new ModelAndView();
		//1. 로그인할 아이디, 비밀번호 파라메터 확인.
		System.out.println("입력한 아이디 : " + mid);
		System.out.println("입력한 비밀번호 : " + mpw);
		//2. SERVICE - 로그인 회원정보 조회 호출
		Member loginMember = msvc.getLoginMemberInfo(mid, mpw);
		if( loginMember == null) {
			System.out.println("로그인 실패");
			mav.setViewName("redirect:/memberLoginForm"); // 로그인 페이지 이동 요청
			ra.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		} else {
			System.out.println("로그인 성공");
			session.setAttribute("loginMemberId", loginMember.getMid());
			mav.setViewName("redirect:/"); // 메인 페이지 이동요청
			ra.addFlashAttribute("msg", "로그인 되었습니다.");
		}
		return mav;
	}
	
	@RequestMapping(value = "/memberLogout")
	public ModelAndView memberLogout(HttpSession session) {
		System.out.println("로그아웃 요청 /memberLogout");
		ModelAndView mav = new ModelAndView();
		//session.invalidate(); 세션 초기화
		session.removeAttribute("loginMemberId"); // 로그인 Attribute 삭제
		mav.setViewName("redirect:/"); // 메인페이지 이동요청 
		return mav;
	}
	
	
}


/* 
 views/Success.jsp 
<script> 
 alert('${msg}');
 location.href="${url}";
</script>

mav.setViewName("Success");
mav.addObject("msg", "회원가입에 성공 했습니다.");
mav.addObject("url", "mainpage");
*/













