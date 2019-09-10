<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Kakao 지도 시작하기</title>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<body>
	<h2>MAP</h2>

	<p id="result"></p>
	
	<div id="map" style="width: 500px; height: 400px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=561a845178111e911d22f0a791f9d99a"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.5662952, 126.97794509999994), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);
	
		var mapTypeControl = new kakao.maps.MapTypeControl();

		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 마커가 표시될 위치
		var markerPosition  = new kakao.maps.LatLng(37.5662952, 126.97794509999994); 

		// 마커 생성
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 표시
		marker.setMap(map);
		
		// 마우스 드래그시 이동된 지도의 중심좌표 기준으로 1Km내 주차장 마커 생성
		 var markers=[];
		kakao.maps.event.addListener(map, 'dragend', function(mouseEvent) {
			removeMarker();
			// 지도의 중심 좌표
			var latlng = {
				    x: map.getCenter().getLat(),
				    y: map.getCenter().getLng()
				};
			
			var message = '변경된 지도 중심좌표는 ' + latlng.x + ' 이고, ';
		    message += '경도는 ' + latlng.y + ' 입니다';

			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
			
			   $.ajax({
			        url : "radius",
			        type : "GET",
			        //dataType: "json",
			        data: latlng,
			        success : function(data){
			        	
				        	// 마커 이미지의 이미지 주소입니다
				        	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				        	for (var i = 0; i < data.length; i++) {
				        		  var coords =new kakao.maps.LatLng(data[i].location[1],data[i].location[0]);
				        		 
				        		  console.log(data[i].location[1],data[i].location[0])
				        		  // 마커 이미지의 이미지 크기 입니다
				        		    var imageSize = new kakao.maps.Size(24, 35); 
				        		    
				        		    // 마커 이미지를 생성합니다    
				        		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				        		   
				        		    // 마커를 생성합니다
				        		    var marker = new kakao.maps.Marker({
				        		        map: map, // 마커를 표시할 지도
				        		        position: coords, // 마커를 표시할 위치
				        		        image : markerImage // 마커 이미지 
				        		    });
				        		    markers.push(marker);
				
					        	}
				        	}
			        });
		});
		// 지도위 모든 마커 제거 함수
		function removeMarker() {
		for (var i = 0; i < markers.length; i++)
				markers[i].setMap(null);
		markers = [];
		}
		
	</script>
</body>
</html>
