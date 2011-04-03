var anh_dia_diem = 'images/tick_1.png';
var anh_co_quan = 'map-icon/coquan16.png';
var anh_benh_vien = 'map-icon/benhvien16.png';

OpenLayers.ProxyHost = 'cgi-bin/proxy.cgi?url=';
var map;
var untiled;
var tiled;
var pureCoverage = false;
var control_select, control_hover, control_drag, control_ve_diem, control_measure, control_click, control_select_quan_huyen;
var format = 'image/png';
OpenLayers.IMAGE_RELOAD_ATTEMPTS = 5;
OpenLayers.DOTS_PER_INCH = 25.4 / 0.28;

function init() {
	var bounds = new OpenLayers.Bounds(533665, 1099901, 586361, 1141760);
	var options = {
		controls : [],
		maxExtent : bounds,
		maxResolution : 305.84301171874995,
		projection : "EPSG:4326",
		units : 'm',
		isBaselayer : 'true',
		numZoomLevels : 11
	};
	map = new OpenLayers.Map('map', options);
	// lay ra quan huyen duoi dinh dang raster
	lop_nen = new OpenLayers.Layer.WMS(
			"Quan_huyen",
			"http://localhost:8080/geoserver/wms",
			{
				layers : 'ws_cantho:quanhuyen,ws_cantho:xaphuong,ws_cantho:giaothong,ws_cantho:coquan,ws_cantho:benhvien',
				styles : '',
				srs : 'EPSG:4326',
				format : format,
				tiled : 'false',
				transparent : 'true',
				tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
			}, {
				buffer : 0,
				isBaseLayer : true,
				displayOutsideMaxExtent : true,
				transitionEffect : 'resize'
			});

	map.addLayers([ lop_nen ]);

	/** Lop chua hai diem duoc chon, de tim duong di* */
	var lop_diem_chon = new OpenLayers.Layer.Vector("lop_diem_chon", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			externalGraphic : '',
			graphicWidth : 30,
			graphicHeight : 35
		// strokeOpacity: 0.6
		}))
	});

	/** Lop hien thi duong duong di ngan nhat* */
	var lop_duong_di = new OpenLayers.Layer.Vector("lop_duong_di", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			strokeColor : "#FF000B",
			strokeWidth : 3,
			strokeOpacity : 0.7
		}))
	});

	/** Lop chua quan huyen* */
	// var lop_quan_huyen = new OpenLayers.Layer.Vector("lop_quan_huyen");
	var lop_quan_huyen = new OpenLayers.Layer.Vector("lop_quan_huyen", {
		strategies : [ new OpenLayers.Strategy.BBOX() ],
		protocol : new OpenLayers.Protocol.WFS({
			url : "http://localhost:8080/geoserver/wfs",
			featureType : "quanhuyen",
			featureNS : "http://opengeo.org/ws_cantho"
		})
	});
	/** Lop chua co quan* */
	var style_co_quan = new OpenLayers.StyleMap({
		"default" : {
			externalGraphic : anh_co_quan,
			graphicWidth : 12,
			graphicHeight : 12,
			cursor : 'pointer'
		},
		"select" : {
			externalGraphic : anh_co_quan,
			graphicWidth : 12,
			graphicHeight : 12
		}
	});
	var lop_co_quan = new OpenLayers.Layer.Vector("lop_co_quan", {
		styleMap : style_co_quan
	});
	// kiem tra neu zoomlevel == 5 thi hien thi lop_co_quan
	/** Lop chua benh vien* */
	var style_benh_vien = new OpenLayers.StyleMap({
		"default" : {
			externalGraphic : anh_benh_vien,
			graphicWidth : 12,
			graphicHeight : 12,
			cursor : 'pointer'
		},
		"select" : {
			externalGraphic : anh_benh_vien,
			graphicWidth : 12,
			graphicHeight : 12
		}
	});
	var lop_benh_vien = new OpenLayers.Layer.Vector("lop_benh_vien", {
		styleMap : style_benh_vien
	});
	// kiem tra neu Zoomlevel == 5 thi hien thi lop_co_quan
	// Them cac lop vua tao vao ban do
	map.addLayers([ lop_co_quan, lop_benh_vien, lop_duong_di, lop_quan_huyen, lop_diem_chon ]);
	// hide lop_quan_huyen di
	lop_quan_huyen.setVisibility(false);
	var external_panel = new OpenLayers.Control.Panel({
		div : document.getElementById('overviewmap')
	});
	map.addControl(external_panel);
	//map.addControl(new OpenLayers.Control.PanZoomBar());
	// map.addControl(new OpenLayers.Control.OverviewMap());
	//map.addControl(new OpenLayers.Control.Navigation());
	//map.addControl(new OpenLayers.Control.ScaleLine());
	//var ovControl = new OpenLayers.Control.OverviewMap();
	//ovControl.isSuitableOverview = function() {
	//	return false;
	//};
	//map.addControl(ovControl);
	map.zoomToMaxExtent(bounds);
	layDuong();
}
$(document).ready(function(){
	$('.inbando').click(function(){				
		$( ".all" ).print();
		//alert("dsf");
		return( false );
	});
});
function printAll(){
	$( "#all" ).print();
}
function queryString(parameter) { 
	  var loc = location.search.substring(1, location.search.length);
	  var param_value = false;

	  var params = loc.split("&");
	  for (i=0; i<params.length;i++) {
	      param_name = params[i].substring(0,params[i].indexOf('='));
	      if (param_name == parameter) {
	          param_value = params[i].substring(params[i].indexOf('=')+1)
	      }
	  }
	  if (param_value) {
	      return param_value;
	  }
	  else {
	      return false; //Here determine return if no parameter is found
	  }
}
function layDuong(){
	x1=parseFloat(queryString("x1"));
	y1=parseFloat(queryString("y1"));
	x2=parseFloat(queryString("x2"));
	y2=parseFloat(queryString("y2"));
	callService(x1, y1, x2, y2);
	var wkt1 = "POINT("+x1+" "+ y1 +" )"	;
	var wkt2 = "POINT("+x2+" "+ y2 +" )"	;
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var point1 = wkt_format.read(wkt1);
	var point2 = wkt_format.read(wkt2);
	lop_diem_chon.addFeatures(point1);
	lop_diem_chon.addFeatures(point2);
	
	var t_point = lop_diem_chon.features[0];
	var symbolizer = t_point.layer.styleMap.createSymbolizer(t_point);
	symbolizer['externalGraphic'] = 'images/tuday.png';
	t_point.style = symbolizer;
	t_point.layer.drawFeature(t_point);
	
	var e_point = lop_diem_chon.features[1];
	var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
	symbolizer['externalGraphic'] = 'images/denday.png';
	e_point.style = symbolizer;
	e_point.layer.drawFeature(e_point);
}
var url = 'http://localhost:8888/cantho-service/services/CanThoMap?wsdl';
function callService(x1, y1, x2, y2) {
	/*
	 * x1 = 586406.15289; y1 = 1110178.56230; x2 = 586424.03201; y2 =
	 * 1110974.18319;
	 */
	// var url1 = "http://localhost:8888/axis2/services/CanThoMap?wsdl";
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
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBackGetDuongDi,
		error : errorGetDuongDi,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function callBackGetDuongDi(xml_result, status) {
	lop_duong_di = map.getLayersByName('lop_duong_di')[0];
	// xoa cac feature cu tren lop duong di
	lop_duong_di.destroyFeatures();// xoa di cac feature hien tai tren lop
	// duong di
	var wkt_format = new OpenLayers.Format.WKT();
	var result = " <ol class='stepsList'>";
	var tenduong;
	var dodai;
	var tongdodai = 0;
	var li;
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		// alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue);
		li = "";
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		tenduong = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		dodai = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		tongdodai = (tongdodai * 1) + (dodai * 1);
		lop_duong_di.addFeatures(wkt_format.read(wkt));
		li= li+ "<li id='li' class='result-path-item'>" + "<a>" +(i+1)+ ".</a>"+
					"<span class='instruction'>" + 
						"<span>" +
							"<pan class='instructionKeyword'>" + tenduong +"</span>" +
						"</span" +
					"</span" +
					"<span class='distance'>"+ Math.round(dodai)+" m</span>" +
				"</li>";	
		result= result + li;
	}
	
	result= result + "</ol>";
	tongdodai= "<div class='sumary'>" +
			"<div class='sumary-item'>Tong do dai: "+ Math.round(tongdodai) + " m</div>" +
			"<div class='sumary-item'>Di qua: "+ (xml_result.getElementsByTagName('ns:return').length) + " con duong.</div>" +
			"</div>";
	result=tongdodai+result;
	//$('.search-result').html(result);
}
function errorGetDuongDi(xml_error) {	
	lop_diem_chon = map.getLayersByName("lop_diem_chon")[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		line_string = new OpenLayers.Geometry.LineString([ start_point,
				end_point ]);
		wkt_format = new OpenLayers.Format.WKT();
		lop_duong_di = map.getLayersByName("lop_duong_di")[0];
		lop_duong_di.destroyFeatures();
		lop_duong_di.addFeatures(wkt_format.read(line_string));
		var do_dai = line_string.getLength();
		alert("Do dai duong di: " + do_dai + " m");
	}
}