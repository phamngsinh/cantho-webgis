<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bản Đồ Thành Phố Cần Thơ</title>
<style type="text/css">
#map {
	border: 1px solid black;
	clear: both; height : 547px;
	width: 712px;
	height: 547px;
}
#wrapper {
	width: 500px;
}
#location {
	float: right;
}
</style>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/events.js"></script>
<script type="text/javascript" src="js/services.js"></script>
<script type="text/javascript" defer="defer">

	
	
	
	
	
	
</script>
<%
	
%>
</head>
<body onload="init()">
<div id="map"></div>
<div id="wrapper">
<div id="location"></div>
<div id="scale"></div>
</div>
<div id="overviewmap"></div>
<div id="msg"></div>
<label>x1</label>
<input id="txt_x1" type="text">
<label>y1</label>
<input id="txt_y1" type="text">
<label>x2</label>
<input id="txt_x2" type="text">
<label>y2</label>
<input id="txt_y2" type="text">
<label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />
</body>
</html>