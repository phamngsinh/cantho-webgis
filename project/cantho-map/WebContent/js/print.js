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
}
//function print(){
	//alert(queryString("a"));
	//document.getElementById('all').focus(); 
	//document.getElementById('all').contentWindow.print();
//}
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
function check(){
	var x1=queryString("x1");
	var y1=queryString("x2");
	var x2=queryString("y1");
	var y2=queryString("y2");
	alert(x1);
}