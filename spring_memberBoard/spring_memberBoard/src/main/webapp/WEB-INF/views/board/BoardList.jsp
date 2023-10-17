<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
    <style>
        div.bListArea{
            border: 3px solid black;
            border-radius: 10px;
            width: 800px;
            margin: 0 auto;
            padding: 10px;
        }

        div.bListArea>table {
            border-collapse: collapse;
            width: 100%;
        }

        div.bListArea>table td {
            border-top: 1px solid black;

        }
        th,td{
            padding: 7px;
        }

        div.bListArea>table>tbody{
            text-align: center;
        }
        .bTitle{
            text-align: left;
            padding-left: 10px;
        }

    </style>
<script src="https://kit.fontawesome.com/633fcd26ea.js" crossorigin="anonymous"></script>

<!-- TOASTR CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />



</head>
<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>글목록 페이지 - views/board/BoardList.jsp </h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
            <div class="contents">
                <h2> 글목록 페이지 - ${noticeMsg } </h2>
                <div class="bListArea">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 50px;">번호</th>
                                <th>제목</th>
                                <th style="width: 110px;">작성자</th>
                                <th style="width: 50px;">조회수</th>
                                <th style="width: 170px;">작성일</th>
                            </tr>
                        </thead>

                        <tbody>
                        <%-- 글 목록 반복 --%>
                        <c:forEach items="${boardList }" var="bo" >
                            <tr>
                                <td>${bo.bno }</td>
                                <td class="bTitle">
                                <a href="${pageContext.request.contextPath }/boardView?bno=${bo.bno }">              
                                    ${bo.btitle }
                                </a>
                                <c:if test="${bo.bfilename != null }">
                                	<span><i class="fa-regular fa-image"></i></span>
                                </c:if>
                                
                                <i class="fa-regular fa-comment-dots"></i>
                                <span style="font-size: 10px;">${bo.recount }</span>
                                </td>
                                <td>${bo.bwriter }</td>
                                <td>${bo.bhits }</td>
                                <td>${bo.bdate }</td>
                            </tr>
                         </c:forEach>
                         <%-- 글 목록 반복 --%>  
                        </tbody>

                    </table>

                </div>

<hr>
                <div class="bListArea">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 50px;">번호</th>
                                <th>제목</th>
                                <th style="width: 110px;">작성자</th>
                                <th style="width: 50px;">조회수</th>
                                <th style="width: 170px;">작성일</th>
                            </tr>
                        </thead>

                        <tbody>
                        <%-- 글 목록 반복 --%>
                        <c:forEach items="${bListMap }" var="bomap" >
                            <tr>
                                <td>${bomap.BNO}</td>
                                <td class="bTitle">
                                <a href="${pageContext.request.contextPath }/boardView?bno=${bomap.BNO }">              
                                    ${bomap.BTITLE }
                                </a>
                                <c:if test="${bomap.BFILENAME != null }">
                                	<span><i class="fa-regular fa-image"></i></span>
                                </c:if>
                                
                                <i class="fa-regular fa-comment-dots"></i>
                                <span style="font-size: 10px;">${bomap.RECOUNT }</span>
                                </td>
                                <td>${bomap.BWRITER }</td>
                                <td>${bomap.BHITS }</td>
                                <td>${bomap.BDATE }</td>
                            </tr>
                         </c:forEach>
                         <%-- 글 목록 반복 --%>  
                        </tbody>

                    </table>

                </div>




            </div>
		
	</div>
<!-- 메인페이지 이동 JS -->
<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

<script type="text/javascript">
	let msg = '${msg}';
	if( msg.length > 0 ){
		alert( msg );
	}
</script>

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

</body>
</html>




















