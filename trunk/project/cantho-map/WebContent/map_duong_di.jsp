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
<script type="text/javascript" defer="defer">
	OpenLayers.ProxyHost = 'cgi-bin/proxy.cgi?url=';
	var map;
	var untiled;
	var tiled;
	var pureCoverage = false;
	var selected_layer, control;
	var format = 'image/png';
	OpenLayers.IMAGE_RELOAD_ATTEMPTS = 5;
	OpenLayers.DOTS_PER_INCH = 25.4 / 0.28;

	function init() {

		var bounds = new OpenLayers.Bounds(533665.483, 1099901.022, 586361.294,
				1141760.714);

		var options = {
			controls : [],
			maxExtent : bounds,
			maxResolution : 205.84301171874995,
			projection : "EPSG:4326",
			units : 'degrees',
			isBaselayer : 'true',
			numZoomLevels : 12
		};

		map = new OpenLayers.Map('map', options);
		//lay ra quan huyen duoi dinh dang raster
		quan_huyen = new OpenLayers.Layer.WMS("Quan_huyen",
				"http://localhost:8080/geoserver/wms", {
					layers : 'ws_cantho:quanhuyen,ws_cantho:giaothong',
					styles : '',
					srs : 'EPSG:4326',
					format : format,
					tiled : 'true',
					transparent : 'true',
					tilesOrigin : map.maxExtent.left + ','
							+ map.maxExtent.bottom
				}, {
					buffer : 0,
					isBaseLayer : true,
					displayOutsideMaxExtent : true
				});

		map.addLayers([ quan_huyen ]);
		/**Tao lop vector hien thi duong di duoc tim*/
		//var duong_di = new OpenLayers.Layer.Vector("duong_di");
		var duong_di = new OpenLayers.Layer.Vector("duong_di", {
			styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
				strokeColor : "#8A2BE2",
				strokeWidth : 5				
				//strokeOpacity: 0.6
			}))
		});

		var diem_chon = new OpenLayers.Layer.Vector("diem_chon",{
			styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({				
				externalGraphic: 'images/Vietnam-icon.png',
				graphicWidth: 20, 
				graphicHeight: 20
				//strokeOpacity: 0.6
			}))
		});
		map.addLayers([ duong_di, diem_chon ]);
		//gan control chon diem cho lop diem_chon
		var control_ve_diem = new OpenLayers.Control.DrawFeature(diem_chon,
				OpenLayers.Handler.Point, {
					featureAdded : point_Added
				});
		map.addControl(control_ve_diem);
		var control_drag = new OpenLayers.Control.DragFeature(diem_chon,
				{
					//onStart: begin_Drag(),
					//onDrag: Draging(),
					onComplete: drag_Completed
				}
				);
		map.addControl(control_drag);

		//control_ve_diem.activate();
		// build up all controls		
		map.addControl(new OpenLayers.Control.PanZoomBar({
			position : new OpenLayers.Pixel(5, 10)
		}));
		map.addControl(new OpenLayers.Control.Navigation());
		map.addControl(new OpenLayers.Control.LayerSwitcher());
		map.addControl(new OpenLayers.Control.Scale($('scale')));
		map.addControl(new OpenLayers.Control.MousePosition({
			element : $('location')
		}));
		map.zoomToMaxExtent();

		//map.addControl(new OpenLayers.Control.OverviewMap());
		//alert("So lop hien tai: "+map.getNumLayers());
		/*
		control.events.register("hoverfeature", this, function(e) {
			hover.addFeatures([ e.feature ]);
		});
		
		control.events.register("outfeature", this, function(e) {
			hover.removeFeatures([ e.feature ]);
		});
		 */
		map.zoomToExtent(bounds);
	}
	function point_Added() {
		//alert("Diem da duoc ve ! ");
		//kiem tra neu da chon du hai diem thi goi webservice de lay duong di
		list_layer_diem_chon = map.getLayersByName('diem_chon');
		lop_diem_chon = list_layer_diem_chon[0];
		num_points = lop_diem_chon.features.length;
		if (num_points == 2) {
			//lay toa do hai diem duoc chon			
			var start_point = lop_diem_chon.features[0].geometry.clone();
			var end_point = lop_diem_chon.features[1].geometry.clone();				
			//goi webservice tra ve duong di giau hai diem

			callService(start_point.x, start_point.y, end_point.x, end_point.y);

			//dong thoi diactivate olControlDrawFeature va activate control olNavigation
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].deactivate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}
			}
		}
	}
	
	function begin_Drag(){
		alert("Bat dau drag");
	}
	function Draging(){
		alert("Dang drag");
	}
	function drag_Completed(){
		//alert("Hoan thanh drag");		
		//goi webservice o day
		list_layer_diem_chon = map.getLayersByName('diem_chon');
		lop_diem_chon = list_layer_diem_chon[0];
		num_points = lop_diem_chon.features.length;
		if (num_points == 2) {
			//lay toa do hai diem duoc chon			
			var start_point = lop_diem_chon.features[0].geometry.clone();
			var end_point = lop_diem_chon.features[1].geometry.clone();				
			//goi webservice tra ve duong di giau hai diem
			callService(start_point.x, start_point.y, end_point.x, end_point.y);		
		}
	}
	
	$(document)
			.ready(
					function() {
						// Code that uses jQuery's $ can follow here.
						//alert('hoang');
						$("#btn_getduongdi").click(function() {
							//alert("Bat dau goi webservice");
							var x1 = $("#txt_x1").val();
							var y1 = $("#txt_y1").val();
							var x2 = $("#txt_x2").val();
							var y2 = $("#txt_y2").val();
							callService(x1, y1, x2, y2);
						});
						$("#btn_reset").click(function() {
							//alert("Reset");
							reset_DuongDi();
						});
						$("#chk_timduong")
								.click(
										function() {
											//kich hoat control ve diem chon
											checked = $("#chk_timduong").attr(
													"checked");
											if (checked == true) {
												//alert("Activate olDrawFeature, Deactivate olNavigation");
												for ( var i = 0; i < map.controls.length; i++) {
													if (map.controls[i].displayClass == "olControlDrawFeature") {
														map.controls[i].activate();
													}
													if (map.controls[i].displayClass == "olControlDragFeature"){
														map.controls[i].activate();
													}
													if (map.controls[i].displayClass == "olControlNavigation") {
														map.controls[i].deactivate();
													}
												}

											} else {
												//alert("Deactivate olDrawFeature, Activate olNavigation");
												for ( var i = 0; i < map.controls.length; i++) {
													if (map.controls[i].displayClass == "olControlDrawFeature") {
														map.controls[i]
																.deactivate();
													}
													if (map.controls[i].displayClass == "olControlDragFeature"){
														map.controls[i].deactivate();
													}
													if (map.controls[i].displayClass == "olControlNavigation") {
														map.controls[i]
																.activate();
													}
												}
											}
										});
					});
	
	function callService(x1, y1, x2, y2) {

		/*
		x1 = 586406.15289;
		y1 = 1110178.56230;
		x2 = 586424.03201;
		y2 = 1110974.18319;
		 */
		var url1 = 'http://localhost:8888/cantho-service/services/CanThoMap?wsdl';
		//var url1 = "http://localhost:8888/axis2/services/CanThoMap?wsdl";
		var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "   <soapenv:Header/>";
		soapMessage += "   <soapenv:Body>";
		soapMessage += "      <ser:getDuongDi>";
		soapMessage += "         <ser:x1>" + x1 + "</ser:x1>";
		soapMessage += "         <ser:y1>" + y1 + "</ser:y1>";
		soapMessage += "         <ser:x2>" + x2 + "</ser:x2>";
		soapMessage += "         <ser:y2>" + y2 + "</ser:y2>";
		soapMessage += "      </ser:getDuongDi>";
		soapMessage += "   </soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
		//alert('request: ' + soapMessage);		
		$.ajax({
			type : 'POST',
			url : url1,
			cache : false,
			success : call_BackGetDuongDi,
			error : error_GetDuongDi,
			dataType : 'xml',// kieu du lieu tra ve (response)
			contentType : 'text/xml; charset=\"utf-8\"', //kieu du lieu gui di (request)
			data : soapMessage
		});
	}
	function call_BackGetDuongDi(xml_result, status) {
		
		list_lop_duong = map.getLayersByName('duong_di');
		lop_duong_di = list_lop_duong[0];
		//xoa cac feature cu tren lop duong di
		lop_duong_di.destroyFeatures();//xoa di cac feature hien tai tren lop duong di				
		var wkt_format=new OpenLayers.Format.WKT();		
		for (i=0;i<xml_result.getElementsByTagName('ns:return').length;i++){
			
			//alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue);
			wkt=xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
			lop_duong_di.addFeatures(wkt_format.read(wkt));				
			
		}			
		/*
		var gml = xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
		var gml_format = new OpenLayers.Format.GML();
		*/		
	}
	function error_GetDuongDi(xml_result) {
		alert("Loi: "
				+ xml_result.getElementByTagName("faultstring")[0].childNodes[0].nodeValue);
	}
	function reset_DuongDi() {
		//xoa lop diem chon
		list_layer_diem_chon = map.getLayersByName('diem_chon');
		lop_diem_chon = list_layer_diem_chon[0];
		lop_diem_chon.destroyFeatures();
		checked = $("#chk_timduong").attr("checked");
		if (checked == true) {
			//alert("Activate olDrawFeature, Deactivate olNavigation");
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
			//alert("Deactivate olDrawFeature, Activate olNavigation");
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
		//xoa lop duong di
		list_layer_duong_di = map.getLayersByName('duong_di');
		lop_duong_di=list_layer_duong_di[0];
		lop_duong_di.destroyFeatures();
	}
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