<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버스도착정보</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">
	
	
</head>
<body>
	<div class="mainWrap">

		<div class="header">
			<h1>버스도착정보 - views/BusArriveInfo.jsp</h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2>컨텐츠 영역</h2>
			<button onclick="getBusArrInfo('ICB163000063')">공원앞</button>
			<button onclick="getBusArrInfo('ICB163000060')">편의점앞</button>
			<hr>
			<div id="busInfoArea"></div>


		</div>

	</div>
	<!-- 메인페이지 이동 JS -->
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- 버스 도착정보 JS -->
	<script type="text/javascript">
		function getBusArrInfo(nodeId) {
			console.log("nodeId : " + nodeId);
			//1. 도착정보 조회 ajax
			$.ajax({
				type : "get",
				url : "getBusArr",
				data : {
					"nodeId" : nodeId
				},
				dataType : "json",
				success : function(arrInfoList) {
					// 도착 정보 출력 기능 호출
					printBusArrInfo(arrInfoList);
				}
			});
		}

		function printBusArrInfo(arrList) {
			console.log("도착정보 출력 기능 호출");
			/* <div id="busInfoArea"></div> 선택 */
			//도착 정보를 출력할 DIV 선택
			let busInfoArea_div = document.querySelector("#busInfoArea");
			busInfoArea_div.innerHTML = ""; 
			
			let tableTag = document.createElement('table');//<table></table> 생성
			let trTag = document.createElement('tr');//<tr></tr> 생성
			let thTag1 = document.createElement('th');//<th></th> 생성
			thTag1.innerText = "번호";//<th>번호</th> 생성
			trTag.appendChild(thTag1);//<tr> <th>번호</th> </tr>

			let thTag2 = document.createElement('th');//<th></th> 생성
			thTag2.innerText = "남은정류장";//<th>남은정류장</th> 생성
			trTag.appendChild(thTag2);//<tr> <th>번호</th> <th>남은정류장</th> </tr>
			
			let thTag3 = document.createElement('th');//<th></th> 생성
			thTag3.innerText = "도착예정시간";//<th>도착예정시간</th> 생성
			trTag.appendChild(thTag3);//<tr> <th>번호</th> <th>남은정류장</th> <th>도착예정시간</th> </tr>			
			tableTag.appendChild(trTag);
			
			for(let info of arrList){
				let infoTrTag = document.createElement('tr');//<tr></tr> 생성
				
				let tdTag_routeno = document.createElement('td');//<td></td> 생성
				tdTag_routeno.innerText = info.routeno;//<td> 4 </td> 생성
				infoTrTag.appendChild(tdTag_routeno);
				
				let tdTag_cnt = document.createElement('td');//
				tdTag_cnt.innerText = info.arrprevstationcnt+"번째전";
				infoTrTag.appendChild(tdTag_cnt);
				
				let tdTag_arrtime = document.createElement('td');//
				tdTag_arrtime.innerText = info.arrtime+"초 후 도착예정";
				infoTrTag.appendChild(tdTag_arrtime);
				
				tableTag.appendChild(infoTrTag);
			}
			
			busInfoArea_div.appendChild(tableTag);
		}
	</script>

	<script type="text/javascript">
	//GEOLOCATION API
		$(document).ready(function(){
			getBusSttnList(37.4387, 126.6750);
		});
		
		function getBusSttnList(lati, longti){
			$.ajax({
				type : "get",
				url : "getBusSttn",
				data : {
					"lati" : lati,
					"longti" : longti
				},
				dataType : "json",
				success : function(sttnList) {
					// 국토교통부_(TAGO)_버스정류소정보 - 좌표기반근접정류소 목록조회
					console.log(sttnList);
				}
			});		
			
		}
	
	
	</script>



</body>
</html>




















