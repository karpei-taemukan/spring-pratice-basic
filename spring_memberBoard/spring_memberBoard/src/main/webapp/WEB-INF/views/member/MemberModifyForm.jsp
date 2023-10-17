<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/css/memberForm.css"
	rel="stylesheet">


</head>
<body>
	<div class="mainWrap">
		<div class="header">
			<h1>내정보 수정 페이지 - views/member/MemberModifyForm.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2 class="text-center">내정보 수정 페이지</h2>
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberModify" 
				      method="post" >
					<div class="formRow">
					    <input type="text" name="mid" value="${mInfo.mid }" readonly="readonly">
					</div>
					<div class="formRow">
						<input type="text" name="mpw" value="${mInfo.mpw }">
					</div>
					<div class="formRow">
						<input type="text" name="mname" value="${mInfo.mname }">
					</div>
					<div class="formRow">
						<input type="date" name="mbirth" value="${mInfo.mbirth }">
					</div>
					<div class="formRow">
						<input type="text" name="memail" value="${mInfo.memail }">
					</div>
					<input class="submitBtn"  type="submit" value="정보수정" >
				</form>
			</div>

		</div>

	</div>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	
</body>
</html>



























