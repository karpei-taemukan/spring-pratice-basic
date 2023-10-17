<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
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
			<h1>회원가입 페이지 - views/member/MemberJoinForm.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2 class="text-center">회원가입 페이지</h2>
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberJoin" method="post">
					<div class="formRow">
						<input type="text" id="inputId" name="mid" placeholder="아이디">
						<button class="checkBtn" type="button" onclick="idCheck()" >중복확인</button>
					</div>
					
					<p id="idCheckMsg"></p>
					
					<div class="formRow">
						<input type="text" name="mpw" placeholder="비밀번호">
					</div>
					<div class="formRow">
						<input type="text" name="mname" placeholder="이름">
					</div>
					<div class="formRow">
						<input type="date" name="mbirth">
					</div>
					<div class="formRowEmail">
						<input type="text" name="memailId" placeholder="이메일아이디">
						<span>&nbsp;@&nbsp;</span>
						<input type="text" id="edomain" name="memailDomain" placeholder="이메일도메인">
						<select onchange="selectDomain(this)">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="google.com">구글</option>
						</select>

					</div>
					<input class="submitBtn" type="submit"  value="회원가입">
				</form>
			</div>

		</div>

	</div>
	<script type="text/javascript">
	/* 이메일 도메인 선택 */
		function selectDomain(selObj) {
			//document.getElementById('edomain').value = selObj.value;
			document.querySelector('#edomain').value = selObj.value;
		}
	</script>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<!-- 아이디 중복체크 -->
	<script type="text/javascript">
		function idCheck(){
			// 중복확인 할 아이디 VALUE 확인
			let idEl = document.querySelector('#inputId');
			console.log(idEl.value);
			// ajax - 아이디 중복 확인 요청 ( memberIdCheck )
			$.ajax( { 
				type : "get", /* 전송 방식 */
				url : "memberIdCheck", /* 전송 URL */
				data : { "inputId" : idEl.value },  /* 전송 파라메터 */
				success : function(re){ /* 전송에 성공 했을 경우 */
					/* re : 응답받은 데이터 */
					console.log("확인결과 : " + re);
					if(re == 'Y'){
						/* 사용가능한 아이디 입니다. 출력 */
						//document.getElementById('idCheckMsg').innerText = '메시지';
						//document.querySelector('#idCheckMsg').innerText = '메시지';
						$('#idCheckMsg').text('사용가능한 아이디 입니다.').css('color','green');
					} else {
						/* 이미 가입된 아이디 입니다. 출력 */
						$('#idCheckMsg').text('이미 가입된 아이디 입니다.').css('color','red');
					}
				
				}
			} );
			
		}
	
	</script>
	
</body>
</html>



























