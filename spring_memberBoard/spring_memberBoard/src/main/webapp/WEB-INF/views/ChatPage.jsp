<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 채팅</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">
<style type="text/css">
#chatArea {
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	width: 650px;
	padding: 10px;
	background-color: #9bbbd4;
	height: 500px;
	overflow: scroll;
}

.sendMsg {
	text-align: right;
}

.msgComment {
	display: inline-block;
	padding: 7px;
	border-radius: 7px;
	max-width: 220px;
	text-align: left;
}

.receiveMsg .msgComment {
	background-color: #ffffff;
}

.sendMsg .msgComment {
	background-color: #fef01b;
}

.receiveMsg, .sendMsg {
	margin-bottom: 5px;
}

.connMsg {
	min-width: 200px;
	max-width: 300px;
	margin: 5px auto;
	text-align: center;
	background-color: #556677;
	color: white;
	border-radius: 10px;
	padding: 5px;
}

.msgId {
	font-weight: bold;
	font-size: 13px;
	margin-bottom: 2px;
}

#inputMsg {
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	width: 650px;
	padding: 10px;
}

#inputMsg {
	display: flex;
}

#inputMsg>input {
	width: 100%;
	padding: 5px;
}

#inputMsg>button {
	width: 100px;
	padding: 5px;
}
#chatContents{
	display: flex;
	width: 900px;
	margin: 0 auto;
}
#leftContent{
	margin: 5px;
} 

#rightContent{
	margin: 5px;
	width: 230px;
}

#connMembersArea{
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	height: 558px;
    overflow: scroll;
	/* padding: 7px; */
}

.connMember{
	border: 2px solid black;
	border-radius: 7px;
	padding: 5px;
	margin:5px 8px;
}

</style>
<!-- TOASTR CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
	<div class="mainWrap">

		<div class="header">
			<h1>채팅페이지 - views/ChatPage.jsp</h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<div id="chatContents"> <!-- id="chatContents" -->
				<div id="leftContent">
					<div id="chatArea">
					</div>
					<div id="inputMsg">
						<input type="text" id="sendMsg">
						<button onclick="sendMsg()">전송</button>
					</div>
				</div>
				
				<div id="rightContent">
					<div id="connMembersArea">
						<div class="connMember">접속 아이디1</div>
					</div>
				</div>
			</div> <!-- id="chatContents" -->
				
		</div>

	</div>
	<!-- 메인페이지 이동 JS -->
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<!-- JQUERY  -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- sockJs -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- Notice JS -->
	<script src="${pageContext.request.contextPath }/resources/js/NoticeJS.js"></script>
	
	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>	
	
	<script type="text/javascript">
		var chatSock = new SockJS('chatSocket');
		chatSock.onopen = function() {
			console.log('open');
		};

		chatSock.onmessage = function(e) {
			let msgObj = JSON.parse(e.data);
			let mtype = msgObj.msgtype;
			switch(mtype){
			case "m":
				printMessage(msgObj); // 메세지 출력 기능
				break;
			case "c":
			case "d":
				printConnect(msgObj); // 접속 정보 출력 기능
				break;
			}
		};
		chatSock.onclose = function() {
			console.log('close');
		};
	</script>
	<script type="text/javascript">
		let msgInputTag = document.querySelector("#sendMsg");
		msgInputTag.addEventListener('keyup', function(e){
			if(e.keyCode == 13){
				sendMsg();
			}
		})
	
	</script>
	<script type="text/javascript">
	
		let chatAreaDiv = document.querySelector("#chatArea");
		
		function sendMsg(){
			let msgInput = document.querySelector("#sendMsg");
			chatSock.send(msgInput.value);
			
			let sendMsgDiv = document.createElement('div');
			sendMsgDiv.classList.add('sendMsg');
			
			let msgCommDiv = document.createElement('div');
			msgCommDiv.classList.add('msgComment');
			msgCommDiv.innerText = msgInput.value;
			
			sendMsgDiv.appendChild(msgCommDiv);
			
			chatAreaDiv.appendChild(sendMsgDiv);
			msgInput.value = "";
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
		function printMessage(msgObj){
			console.log("메세지 출력 기능");
			let receiveMsgDiv = document.createElement('div');
			receiveMsgDiv.classList.add('receiveMsg');
			
			let msgIdDiv = document.createElement('div');
			msgIdDiv.classList.add('msgId');
			msgIdDiv.innerText = msgObj.msgid;
			receiveMsgDiv.appendChild(msgIdDiv);
			
			let msgCommentDiv = document.createElement('div');
			msgCommentDiv.classList.add('msgComment');
			msgCommentDiv.innerText = msgObj.msgcomm;
			receiveMsgDiv.appendChild(msgCommentDiv);
			
			chatAreaDiv.appendChild(receiveMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
		function printConnect(msgObj){
			console.log("접속정보 출력 기능");
			// 접속 정보 >> 채팅창에 출력
			let connMsgDiv = document.createElement('div');
			connMsgDiv.classList.add('connMsg');
			connMsgDiv.innerText = msgObj.msgid+" 이/가 " + msgObj.msgcomm;
			chatAreaDiv.appendChild(connMsgDiv);
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
			
			// 접속 정보 >> 접속자 목록( id="connMembersArea" )
			let connMembersAreaDiv = document.querySelector("#connMembersArea");
			if(msgObj.msgtype == 'c'){
				// msgtype == 'c' >> 접속자 목록에 추가
				let connMemberDiv = document.createElement('div');
				connMemberDiv.classList.add('connMember');
				connMemberDiv.setAttribute('id',msgObj.msgid);
				
				connMemberDiv.innerText = msgObj.msgid;
				
				connMembersAreaDiv.appendChild(connMemberDiv);
			} else {
				// msgtype == 'd' >> 접속자 목록에서 삭제
				// msgObj.msgid >> 접속을 해제한 아이디
				document.querySelector("#"+msgObj.msgid).remove();
				
			}
			
			
			
			
		}
	
	</script>
</body>
</html>




















