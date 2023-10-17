<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버스 도착정보</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
</head>
<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>버스 도착정보 - views/BusList.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
		<div class="contents">
			<h2>버스 도착정보</h2>
			<%-- 정류소명, 버스번호, 남은정류장, 도착예정시간(초) --%>
			<table>
				<tr>
					<th>정류소명</th>
					<th>버스번호</th>
					<th>남은정류장</th>
					<th>도착예정시간</th>
				</tr>
			
				<c:forEach items="${busList }" var="bus">
					<tr>
						<td>${bus.nodenm }</td>
						<td>${bus.routeno } 번</td>
						<td>${bus.arrprevstationcnt } 번째전</td>
						<td>${bus.arrtime } 초 후 도착예정</td>
					</tr>
				</c:forEach>
			
			
			</table>
			
		</div>
		
	</div>
<!-- 메인페이지 이동 JS -->
<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
</body>
</html>




















