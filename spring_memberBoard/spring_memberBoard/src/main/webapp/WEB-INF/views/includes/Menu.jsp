<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="nav">
	<ul>
		<li> <a href="${pageContext.request.contextPath }/memberChatPage">회원채팅</a> </li>
		
		<li> <a href="${pageContext.request.contextPath }/tagoBus">tagoBus</a> </li>
	
		<li><a href="${pageContext.request.contextPath }/boardList">게시판</a></li>
		
		<c:choose>
			<c:when test="${sessionScope.loginMemberId == null }">
				<%-- 로그인 X --%>
				<li><a href="${pageContext.request.contextPath }/memberJoinForm">회원가입</a></li>
				<li><a href="${pageContext.request.contextPath }/memberLoginForm">로그인</a></li>
			</c:when>
			<c:otherwise>
				<%-- 로그인 O --%>
				<li><a href="${pageContext.request.contextPath }/myInfo">${sessionScope.loginMemberId}</a></li>
				<li><a href="${pageContext.request.contextPath }/boardWriteForm">글쓰기</a> </li>
				<li><a href="${pageContext.request.contextPath }/memberLogout">로그아웃</a></li>
			</c:otherwise>
		</c:choose>
		
	</ul>
	
</div>








