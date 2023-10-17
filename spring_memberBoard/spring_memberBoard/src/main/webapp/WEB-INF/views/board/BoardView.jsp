<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath }/resources/css/memberForm.css"
	rel="stylesheet">
<style type="text/css">
div.formRow>textarea {
	width: 100%;
	height: 200px;
	font-family: auto;
	font-size: 20px;
	padding: 5px;
	border: 2px solid black;
	border-radius: 7px;
}
</style>

<style type="text/css">
	.replyArea{
		border: 3px solid black;
		border-radius: 10px;
		width: 500px;
		margin: 8px auto; 
		padding: 15px;
	}
	.replyWrite textarea{
		border-radius: 7px;
		width: 96%;
		min-height: 70px;
		font-family: auto;
		resize:none;
		padding:8px;
	}
	.replyWrite button{
		width: 100%;
		margin-top: 5px;
		cursor: pointer;
		padding: 5px;
		border-radius: 7px;
	}
	
	.reply{
		display: flex;
	}
	.reply>p{
		padding: 0;
		margin: 3px;
	}
	
	.reply>button{
	    margin-left: auto;
    	border-radius: 7px;
    	border: 2px solid black;
    	cursor: pointer;
	}
	.recomm{
		margin-top:5px;
		border-radius: 7px;
		width: 96%;
		min-height: 70px;
		font-family: auto;
		resize:none;
		padding:8px;
		font-size: 17px;
		font-weight: bold;	
	}

</style>

<!-- TOASTR CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


</head>
<body>
	<div class="mainWrap">
		<div class="header">
			<h1 >글 상세 페이지 - views/board/BoardView.jsp</h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2 class="text-center">글 상세 페이지</h2>
			<div class="formWrap">
				<form action="" method="post">
					<div class="formRow">
						<input type="text" disabled="disabled" value="${bo.btitle }">
					</div>
					<div class="formRow">
						<input type="text" disabled="disabled" value="${bo.bwriter }">
						<input type="text" style="margin-left: 5px; margin-right: 5px;"
							disabled="disabled" value="${bo.bhits }"> <input
							type="text" disabled="disabled" value="${bo.bdate }">
					</div>
					<div class="formRow" style="justify-content: center;">
						<img alt="" style="max-height: 150px;"
							src="${pageContext.request.contextPath }/resources/boardUpload/${bo.bfilename}">
					</div>
					<div class="formRow">
						<textarea disabled="disabled">${bo.bcontents}</textarea>
					</div>
					<button type="button">글삭제</button>
					<button type="button">글목록</button>
				</form>
			</div>
			
	     <%-- 댓글 관련 시작--%>

		    <div class="replyArea">
			
				<c:if test="${sessionScope.loginMemberId != null }">
				<div class="replyWrite">		    	
		    		<form onsubmit="return replyWrite(this)">
		    			<input type="hidden" name="rebno" value="${bo.bno}">
		    			<input type="hidden" name="bwriter" value="${bo.bwriter}">
		    			<textarea name="recomment" placeholder="댓글 내용 작성"></textarea>
		    			<button type="submit">댓글 등록</button>
		    		</form>
		    	</div>
		    	<hr>
		    	</c:if>
		    	
		    	<div id="replyList">
		    		
		    	</div>
		    	<div tabindex="-1" id="focusDiv"></div>
		    
		    </div>
		  <%-- 댓글 관련 끝--%>
		
		</div> <%-- div.contents 끝--%>
	
	</div> <%-- div.mainWrap 끝--%>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<!-- JQUERY  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- TOASTR JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- sockJs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/NoticeJS.js"></script>
<script type="text/javascript">
	let noticeSock = connectNotice('${noticeMsg}');
</script>

	
	<!-- 댓글 등록 -->
	<script type="text/javascript">
		function replyWrite(formObj){
			console.log("replyWrite 호출 " + formObj.rebno.value);
			/* ajax 댓글 등록 요청 전송 */
			$.ajax( {
				type : "get",
				url : "replyWrite",
				data : { "rebno" : formObj.rebno.value, 
					     "recomment" : formObj.recomment.value },
			    async:false,
				success: function(result){
					console.log("result : " + result);
					if(result == "1"){
						alert("댓글이 등록되었습니다.");
						formObj.recomment.value = ""; // 댓글 내용 작성 textarea 초기화
						//댓글 목록 갱신
						getReplyList(formObj.rebno.value);
						document.querySelector("#focusDiv").focus();
						
						let noticeObj = { "noticeType" : "reply",
								          "noticeMsg" : formObj.rebno.value,
								          "receiveId" : formObj.bwriter.value
						                 };
						// 공지타입,글번호,작성자 >> JSON
						noticeSock.send(  JSON.stringify(noticeObj)  );  
					
						
					} else {
						alert("댓글 실패하였습니다.");
					}
				}				
			} );
			
			return false;
		}
	
		// 댓글 목록 조회 // 
		function getReplyList(rebno){
			console.log("getReplyList() 호출");
			console.log("댓글 조회 할 글번호 : " + rebno);
			$.ajax({
				type : "get",
				url : "replyList",
				data : { "rebno" : rebno },
				dataType : "json",
				async:false,
				success : function(reList){
					printReplyList(reList); // 댓글 출력 기능 호출

				}
			}); 
		}
	</script>
	<%-- 
	<div>
		<div class="reply">
			<p>작성자출력</p>
			<p>작성일출력</p>
			<button>댓글삭제</button>
		</div>
		<textarea class="recomm" disabled="disabled">댓글내용 출력</textarea>
		<hr>
	</div>
	--%>	
	<script type="text/javascript">
		let loginId = '${sessionScope.loginMemberId}';
		console.log("로그인된 아이디 : " + loginId);
	
	
		// 댓글 출력 기능
		function printReplyList(reList){
			// 댓글을 출력할 DIV
			let reListDiv = document.querySelector("#replyList");
			reListDiv.innerHTML = "";  // 댓글을 출력할 DIV 자식요소 초기화
			
			for(let reInfo of reList){ // let i = 0; i < reList.length; i++
				let reDiv = document.createElement('div');// <div></div>
				let replyDiv = document.createElement('div'); // <div></div>
				replyDiv.classList.add('reply'); // <div class="reply"></div>
				
				let reWriterP = document.createElement('p');// <p></p>
				reWriterP.innerText = reInfo.remid; // <p>작성자</p>
				replyDiv.appendChild(reWriterP);
			// <div class="reply"> <p>작성자</p> </div>
				
				let redateP = document.createElement('p'); //<p></p>
				redateP.innerText = reInfo.redate; // <p>작성일</p>
				replyDiv.appendChild(redateP);
			// <div class="reply"> <p>작성자</p> <p>작성일</p> </div>
				
			// 댓글 작성자 reInfo.remid 와 로그인 된 아이디가 같을 경우에 실행
				if( reInfo.remid == loginId ){
					let rebtn = document.createElement('button');// <button></button>
					rebtn.innerText = "삭제"; // <button>삭제</button>
					rebtn.setAttribute("onclick", "delReply( '"+reInfo.renum+"' )");
					replyDiv.appendChild(rebtn); //  <button onclick='delReply()'>삭제</button>
				}
		    // <div class="reply"> <p>작성자</p> <p>작성일</p> <button>삭제</button> </div>			
		    
				let recomment = document.createElement('textarea');//<textarea></textarea>
				recomment.innerText = reInfo.recomment;  //<textarea>댓글내용</textarea>
				recomment.classList.add('recomm'); //<textarea class='recomm'>댓글내용</textarea>
				recomment.setAttribute('disabled', 'disabled');
				//<textarea class='recomm' disabled='disabled'>댓글내용</textarea>
				
				reDiv.appendChild(replyDiv);
				reDiv.appendChild(recomment);
				reDiv.appendChild( document.createElement('hr') );
				
				reListDiv.appendChild(reDiv);
			}
		}
	</script>
	<script type="text/javascript">
		function delReply(delrenum){
			console.log('삭제할 댓글 번호:' + delrenum);
			let confirmVal = confirm('댓글을 삭제 하시겠습니까?');
			if(confirmVal){
				$.ajax({ 
					type : "get",
					url : "deleteReply",
					data : { "renum" : delrenum },
					success: function(result){
						if(result == '1'){
							getReplyList(bno);
						} else {
							alert('댓글 삭제 처리를 실패하였습니다.');
						}
					}
				})
			}
		}
	
	</script>
	
	
	
	<script type="text/javascript">
		let bno = '${bo.bno}'; // 현재 글번호
		$(document).ready(function(){  
			getReplyList(bno);
		});
		
		
	</script>
	

	
	
	
</body>
</html>



























