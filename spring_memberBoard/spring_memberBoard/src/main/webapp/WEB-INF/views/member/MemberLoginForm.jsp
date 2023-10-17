<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/memberForm.css"
	rel="stylesheet">
<script type="text/javascript">
	let msg = '${msg}';
	if( msg.length > 0 ){
		alert( msg );
	}
</script>
</head>
<body>
	<div class="mainWrap">
		<div class="header">
			<h1>로그인 페이지 - views/member/MemberJoinForm.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			
			<h2 class="text-center">로그인 페이지</h2>
			<!-- 아이디, 비밀번호 -->
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberLogin" method="post">
					<div class="formRow">
						<input type="text" id="inputId" name="mid" placeholder="아이디">
					</div>
					<div class="formRow">
						<input type="text" name="mpw" placeholder="비밀번호">
					</div>
					<input class="submitBtn" type="submit"  value="로그인">
				</form>
			</div>

		</div>

	</div>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
</body>
</html>



























