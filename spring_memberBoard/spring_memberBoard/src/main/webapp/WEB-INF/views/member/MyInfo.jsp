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
			<h1>내정보 페이지 - views/member/MyInfo.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2 class="text-center">내정보 페이지</h2>
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			<div class="formWrap">
					<div class="formRow">
						아이디 ${mInfo.mid }
					</div>
					<div class="formRow">
						비밀번호 ${mInfo.mpw }
					</div>
					<div class="formRow">
						이름 ${mInfo.mname }
					</div>
					<div class="formRow">
						생년월일 ${mInfo.mbirth}
					</div>
					<div class="formRow">
						이메일 ${mInfo.memail}
					</div>
					<button class="submitBtn" 
					        type="button"
					        onclick="pwCheck('${mInfo.mpw }')"  >수정하기</button>
			</div>
			<hr>
			작성한 글 : ${boardCount } 개
			<hr>
			작성한 댓글 : ${replyCount } 개
			<hr>
		</div>

	</div>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		function pwCheck(mpw){
			let inputpw = prompt("비밀번호 입력");
			if(mpw == inputpw){
				location.href = "memberModifyForm";
			} else {
				alert('비밀번호를 다시 확인 해주세요!');
			}
		}
	
	</script>
	
	
</body>
</html>



























