<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성 페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/css/memberForm.css"
	rel="stylesheet">
<style type="text/css">
	div.formRow>textarea{
		width: 100%;
		height: 200px;
		font-family: auto;
		font-size: 20px;
		padding: 5px;
		border: 2px solid black;
        border-radius: 7px;
	}	

</style>	
	
</head>
<body>
	<div class="mainWrap">
		<div class="header">
			<h1>글작성 페이지 - views/board/BoardWriteForm.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2 class="text-center">글작성 페이지</h2>
			<!-- 글제목, 글내용 -->
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/boardWrite" 
				      method="post"  enctype="multipart/form-data" >
					<div class="formRow">
						<input type="text" name="btitle" placeholder="글제목">
					</div>
					<div class="formRow">
					    <textarea name="bcontents" placeholder="글내용"></textarea>
					</div>
					<div class="formRow">
						<input type="file" name="bfile">
					</div>
					<input class="submitBtn" type="submit"  value="글등록">
				</form>
			</div>

		</div>

	</div>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
</body>
</html>



























