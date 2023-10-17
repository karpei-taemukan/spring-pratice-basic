<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TagoBus</title>
<link href="${pageContext.request.contextPath }/resources/css/main.css"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/633fcd26ea.js" crossorigin="anonymous"></script>	
	
<style type="text/css">
	#mapInfo{
		display: flex;
	}
	#map{
		box-sizing:border-box;
		border: 2px solid black;
		border-radius: 7px;
	}
	#TagoBus{
		display: flex;
		width: 1100px;
    	margin: 0 auto;
	}
	
	#busSttnArea{
		box-sizing:border-box;
		border: 2px solid black;
		border-radius: 7px;
		margin-left: 5px;
		padding: 5px;
		width: 230px;
		overflow: scroll;
		height:450px;
		/*font-size: 13px;*/
	}
	
	.busSttn{
		border: 1px solid black;
		border-radius: 10px;
		padding: 8px;
		text-align: center;
		margin-bottom: 3px;
		cursor: pointer;
	}
	
	.busSttn:hover {
		background-color: wheat;
	}

	
	#busArrInfo{
		box-sizing: border-box;
    	border: 2px solid black;
    	border-radius: 7px;
    	padding: 5px;
    	margin-top: 5px;
    	height: 200px;
        overflow: scroll;
	}
	
	.arrInfo{
		display: flex;
		border: 1px solid black;
    	border-radius: 10px;
    	padding: 8px;
    	margin-bottom: 3px;
    	cursor: pointer; 
	}
	.arrInfo:hover {
		background-color: wheat;
	}	
	.selectDiv{
		background-color: wheat;
	}
	
	#busLocInfo{
		border: 2px solid black;
    	border-radius: 7px;
    	margin-left: 5px;
    	width: 270px;
    	padding: 7px;
    	height: 637px;
        overflow: scroll;
        text-align: center;
	}
	.busNode{
		border: 1px solid black;
		border-radius: 10px;
		padding: 8px;
		margin-bottom: 5px;
	}
	.nowBus{
		border: 5px solid coral !important;
	}
	
	
</style>	
	
<!-- TOASTR CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	
</head>
<body>
	<div class="mainWrap">

		<div class="header">
			<h1>TagoBus - views/TagoBus.jsp</h1>
		</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>
		<div class="contents">

			<div id="TagoBus">
				<div id="leftInfo">
					<div id="mapInfo">
						<!-- 지도 -->
						<div id="map" style="width: 550px; height: 450px;"></div>
						<!-- 정류소 목록 / 국토교통부_(TAGO)_버스정류소정보 -->
						<div id="busSttnArea">
							
						</div>
					</div>

					<div id="busArrInfo">
						<!-- 도착예정 버스 정보 -->
					</div>
				</div>

				<div id="busLocInfo">
				</div>
				
				
			</div>
		</div>

	</div>
	<!-- 메인페이지 이동 JS -->
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d20bb3cce6d4afc4dccd79366bd89f6d"></script>
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		//지도에 클릭 이벤트를 등록합니다
		//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng;
			console.log("위도 : " + latlng.getLat());
			console.log("경도 : " + latlng.getLng());
			
			document.querySelector("#busSttnArea").innerHTML = "";
			document.querySelector("#busArrInfo").innerHTML = "";
			document.querySelector("#busLocInfo").innerHTML = "";

			// 정류소 목록 조회 기능 호출
			getBusSttnList(latlng.getLat(), latlng.getLng());
			
		});
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
	
	<script type="text/javascript">
		//정류소 목록 조회 기능
		function getBusSttnList(latitude, longitude) {
			console.log("getBusSttnList() 호출");
			console.log(latitude + " : " + longitude);
			//1. 국토교통부_(TAGO)_버스정류소정보 - 정류소 목록 조회 
			$.ajax({
				type : "get",
				url : "getTagoSttnList",
				data : { "lati" : latitude, "longi" : longitude  },
				async:false,
				dataType : "json",
				success : function(result){
					//정류소 목록 출력 기능 호출
					printBusSttn(result);
				}
			});
		}
		
		
		let currentCityCode = null;
		let selectBusNodeId = null;
		
		let oldMarker = null;
		//정류소 목록 출력 기능
		function printBusSttn(sttnList){
			console.log("printBusSttn() 호출")
			console.log(sttnList);
			console.log(sttnList.length);
			// 정류소 목록을 출력하는 DIV 선택
			let busSttnArea = document.querySelector("#busSttnArea");
			busSttnArea.innerHTML = ""; // 정류소 목록 초기화
			
			
			for(let sttn of sttnList){
				console.log(sttn);
				let sttnDiv = document.createElement('div');
				sttnDiv.classList.add('busSttn');
				sttnDiv.innerText = sttn.nodeno +" " + sttn.nodenm;
				sttnDiv.addEventListener('click', function(e){
					/*
					let busSttnList = document.querySelectorAll('#busSttnArea>div.busSttn');
					for(let stn of busSttnList){
						stn.classList.remove('selectDiv');
					}
					e.target.classList.add('selectDiv');
					*/
					selectedTag(e.target, "busSttn");
					
					// 이동할 위도 경도 위치를 생성합니다 
				    var moveLatLon = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);
				    // 지도 중심을 부드럽게 이동시킵니다
				    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
				    map.panTo(moveLatLon);  
				    
				    // 마커가 표시될 위치입니다 
				    var markerPosition  = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong); 
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        position: markerPosition
				    });
				    
				    if(oldMarker != null){
				    	oldMarker.setMap(null);    
				    }
				    
				    marker.setMap(map);
				    oldMarker = marker;
				    
				    selectBusNodeId = sttn.nodeid;
				    currentCityCode = sttn.citycode;
				    
				    getBusArrInfo( sttn.citycode, sttn.nodeid );
				    
				    document.querySelector("#busLocInfo").innerHTML = "";
				    
				});
				
				busSttnArea.appendChild(sttnDiv);
			}
		}
		
		
		
	</script>
	<script type="text/javascript">
		function selectedTag(selObj, clname){
			let objList = document.querySelectorAll('.'+clname);
			for(let obj of objList){
				obj.classList.remove('selectDiv');
			}
			selObj.classList.add('selectDiv');			
		};
	
	</script>
	
	
	<script type="text/javascript">
		function getBusArrInfo(citycode, nodeid){
			console.log("버스 도착 정보 getBusArrInfo() 호출")
			console.log("도시코드 : " + citycode +" || 정류소ID : " + nodeid);
			$.ajax({
				type : "get",
				url : "getTagoBusArrList",
				data : { "citycode" : citycode, "nodeid" : nodeid  },
				dataType : "json",
				async:false,
				success : function(result){
					//버스 도착 정보 목록 출력 기능 호출
					printBusArrInfo(result);
				}
			});
		}

		function printBusArrInfo(arrList){
			console.log("버스도착정보 출력 기능 호출")
			console.log(arrList);
			console.log(arrList.length);
			console.log(arrList.length == undefined);
			
			// 도착 정보를 출력할 DIV 선택
			let busArrInfoDiv = document.querySelector("#busArrInfo");
			busArrInfoDiv.innerHTML = ""; // 초기화
			
			for(let arrInfo of arrList){
				let arrInfoDiv = document.createElement('div');
				arrInfoDiv.classList.add('arrInfo');
				let numTime = Number(arrInfo.arrtime);
				arrInfoDiv.innerText = arrInfo.routeno+"번 "
				              +arrInfo.arrprevstationcnt+"정거장 전 "
				              +parseInt(numTime/60)+"분 "+(numTime % 60)+"초 후 도착예정";
				
				arrInfoDiv.addEventListener('click',function(e){
					console.log(" 버스 선택! 도시코드, 버스ID");
					/*
					let arriveList = document.querySelectorAll('#busArrInfo>div.arrInfo');
					for(let arrive of arriveList){
						arrive.classList.remove('selectDiv');
					}
					e.target.classList.add('selectDiv');
					*/
					selectedTag(e.target, "arrInfo");
					
					// 버스 위치 정보 조회 기능 호출
					getBusLocList(currentCityCode, arrInfo.routeid);
				});
				busArrInfoDiv.appendChild(arrInfoDiv);
			}
			
			
		}
	
		function getBusLocList(ccode, rid){
			console.log("버스 위치정보 + 노선정보 조회 기능 호출");
			console.log("도시 코드 : " + ccode);
			console.log("버스ID : " + rid);
			let nodeList = null;  // 정류소 목록
			let locList = null;   // 버스 위치 목록
			
		//1. 버스 노선 정보 - 국토교통부_(TAGO)_버스노선정보 (노선별 경유 정류소목록 조회)
			$.ajax({ 
				type : "get",
				url : "getTagoBusNodeList",
				data : { "citycode" : ccode, "routeid" : rid },
				dataType : "json",
				async : false,
				success : function(nodeResult){
					nodeList = nodeResult;
				}
			});
		//2. 버스 위치 정보 - 국토교통부_(TAGO)_버스위치정보(노선별버스위치 목록조회)
			$.ajax({ 
				type : "get",
				url : "getTagoBusLocList",
				data : { "citycode" : ccode, "routeid" : rid },
				dataType : "json",
				async : false,
				success : function(busLocResult){
					locList = busLocResult;
				}
			});
		
		//3. 정류소 목록 출력   <div id="busLocInfo"> 
			console.log("정류소 목록");
			console.log(nodeList); 
			console.log("버스 위치 목록")
			console.log(locList); 
			let locNodeIdList = []; // 버스 위치 목록의 nodeid를 저장할 배열
			for(let locnode of locList){
				locNodeIdList.push(locnode.nodeid);
			}
			console.log(locNodeIdList)
			
			
			let busLocInfoDiv = document.querySelector("#busLocInfo");
			busLocInfoDiv.innerHTML = "";
			
			for(let busNode of nodeList){
				
				let busNodeDiv = document.createElement('div');
				busNodeDiv.classList.add('busNode'); //<div class="busNode">
				
				// 정류소에 버스가 위치하고 있는지 확인
				if( locNodeIdList.includes( busNode.nodeid ) ){
					busNodeDiv.classList.add('nowBus');
					busNodeDiv.innerHTML = '<i class="fa-solid fa-bus-simple"></i> ' + busNode.nodenm;//<div class="busNode"> 정류장이름 </div>
				} else {
					busNodeDiv.innerHTML = busNode.nodenm;
				}
				
				// 선택한 정류소인지 확인
				if(busNode.nodeid == selectBusNodeId){
					busNodeDiv.classList.add('selectDiv');
					busNodeDiv.setAttribute("tabindex","0");
					busNodeDiv.setAttribute("id","focusNode");
				} 
				
				
				
				busLocInfoDiv.appendChild(busNodeDiv);
			}
		
			document.querySelector("#focusNode").focus();
			
		}
		
		
		
	</script>
	


</body>
</html>




















