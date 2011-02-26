<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bản Đồ Thành Phố Cần Thơ</title>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script type="text/javascript" src="js/events.js"></script>
<script type="text/javascript" src="js/services.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css"></link>
<script type="text/javascript" defer="defer">
$(document).ready(function() {
	// Code that uses jQuery's $ can follow here.
	// alert('hoang');
	$("#btn_getduongdi").click(function() {
		alert("sss");
		// alert("Bat dau goi webservice");
		var x1 = $("#txt_x1").val();
		var y1 = $("#txt_y1").val();
		var x2 = $("#txt_x2").val();
		var y2 = $("#txt_y2").val();
		callService(x1, y1, x2, y2);
	});
	$("#btn_reset").click(function() {
		// alert("Reset");
		reset_DuongDi();
	});
	$("#chk_timduong").click(function() {
		// kich hoat control ve diem chon
		checked = $("#chk_timduong").attr("checked");
		if (checked == true) {
			// alert("Activate olDrawFeature, Deactivate olNavigation");
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].deactivate();
				}
			}

		} else {
			// alert("Deactivate olDrawFeature, Activate olNavigation");
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].deactivate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].deactivate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}
			}
		}
	});
});
</script>
</head>
<body onload="init()">
<div id="map"></div>
<label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />
</body>
</html>