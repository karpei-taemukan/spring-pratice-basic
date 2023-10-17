<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>버스도착정보</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">
<style type="text/css">
	.sttnBtn{
		width: 130px;
    	margin: 2px;
    	cursor: pointer;
	}
	#busApi{
		display: flex;
	}
	#busLoc{
	margin-left: 10px;
    width: 200px;
    border: 1px solid black;
    overflow: scroll;
    height: 376px;
	}
	
	#busSttnArea{
	    max-height: 150px;
    	overflow: scroll;
	}
	.busNode{
    	margin: 2px;
    	font-size: 14px;
    	padding: 3px;
    	border: 1px solid black;
	}
	.nowBus{
		border: 5px solid coral !important;
	}
	.selectNode{
		background-color: antiquewhite;
    	font-weight: bold;
	}
	
</style>
<script src="https://kit.fontawesome.com/633fcd26ea.js" crossorigin="anonymous"></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d20bb3cce6d4afc4dccd79366bd89f6d"></script>

<!-- TOASTR CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	
</head>
<body>
	<div class="mainWrap">

		<div class="header">
			<h1>버스도착정보 - views/BusArriveInfo.jsp</h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">
			<h2>컨텐츠 영역</h2>
			
		<div id="busApi">	
			<div id="busInfo">
				<div id="map" style="width:300px;height:200px;"></div>
				<hr>
				<div id="busSttnArea">
				</div>
				<hr>
				<div id="busInfoArea"></div>
			</div>
			<div id="busLoc">
			
			</div>
		</div>	
			
		</div>

	</div>

	<script type="text/javascript">
	
	
	</script>

	<script type="text/javascript">
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    console.log( message );
    getBusSttnList(latlng.getLat(), latlng.getLng());
});
	</script>
	
	<!-- 메인페이지 이동 JS -->
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

<!-- JQUERY  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- TOASTR JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- sockJs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/NoticeJS.js"></script>

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
			console.log("도착정보 출력 기능 호출 " + (arrList.length==undefined) );
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
				console.log(info);
				let infoTrTag = document.createElement('tr');//<tr></tr> 생성
				
				let tdTag_routeno = document.createElement('td');//<td></td> 생성
				let btn = document.createElement('button');
				btn.setAttribute("onclick","viewBusLoc('"+info.routeid+"','"+info.nodeid+"')")
				btn.innerText = info.routeno;
				tdTag_routeno.appendChild(btn);
				//tdTag_routeno.innerText = info.routeno;
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
		function viewBusLoc(routeid, preNodeId){
			
			let nodeList = ""; // 전체 정류장
			let busLocList = []; // 현재 버스가 위치한 정류장
			
			//해당 버스의 전체 경유 정류장 목록 국토교통부_(TAGO)_버스노선정보
			$.ajax({
				type : "get",
				url : "getBusNodeList",
				data : {
					"routeid" : routeid
				},
				async:false,
				dataType : "json",
				success : function(result) {
					//console.log(result);
					nodeList = result;
				}
			});

			//현재 운행중인 버스의 위치 목록 국토교통부_(TAGO)_버스위치정보
			$.ajax({
				type : "get",
				url : "getBusLocList",
				data : {
					"routeid" : routeid
				},
				async:false,
				dataType : "json",
				success : function(result) {
					//console.log(result);
					for(let loc of result){
						busLocList.push(loc.nodeid);
					}
					
					
				}
			});
			let busLoc_div = document.querySelector("#busLoc");
			busLoc_div.innerHTML = "";
			
			for(let busNode of nodeList){
				console.log( busLocList.includes(busNode.nodeid)  );
				
				let nodeDiv = document.createElement('div');
				nodeDiv.classList.add('busNode');
				
				if( busLocList.includes(busNode.nodeid) ){
					nodeDiv.classList.add('nowBus');
					nodeDiv.innerHTML = "<i class='fa-solid fa-bus'></i>"+ busNode.nodenm;
				} else {
					nodeDiv.innerHTML = busNode.nodenm;
				}
				if(preNodeId == busNode.nodeid){
					nodeDiv.setAttribute('tabindex','-1');
					nodeDiv.setAttribute('id','focusNode');
					nodeDiv.classList.add('selectNode');
				}
				busLoc_div.appendChild(nodeDiv);
			}
			
			document.querySelector("#focusNode").focus();
			
		}
	
	</script>
	
	

	<script type="text/javascript">
		$(document).ready(function(){
			//navigator.geolocation.getCurrentPosition(myPositionToMap)
		});
		
		function myPositionToMap(position){
			getBusSttnList(position.coords.latitude,position.coords.longitude );
		}
		
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
					printBusSttnBtn(sttnList);
				}
			});		
			
		}
	
		function printBusSttnBtn(sttnList){
			let btn_div = document.querySelector("#busSttnArea");
			btn_div.innerHTML = "";
			let idx = 0;
			for(let sttn of sttnList){
				let sttnBtn = document.createElement('button');
				//<button>
				sttnBtn.classList.add('sttnBtn'); //<button class="sttnBtn">
				sttnBtn.setAttribute("onclick","getBusArrInfo('"+sttn.nodeid+"')")
				//<button class="sttnBtn" onclick="getBusArrInfo('ICB11111')" >
				sttnBtn.innerHTML = sttn.nodeno+"<br>"+sttn.nodenm;
				//<button class="sttnBtn" onclick="getBusArrInfo('ICB11111')" >
				//    30000<br>영남아파트
				//</button>
				btn_div.appendChild(sttnBtn);
				idx++;
				if(idx % 3 == 0){
					let br = document.createElement('br');
					btn_div.appendChild(br);
				}
			}
			
			
			
		}
		/*
			<button>
				<span>30000</span><br>
				<span>영남아파트</span>
			</button>
		
		*/
	
	</script>



</body>
</html>




















