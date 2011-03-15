/**
 * 
 */
var anh_dia_diem = 'images/tick_1.png';

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
	moveIconClick();
	var s1=document.getElementById("search");
	var map_width=$("#map").css("width").replace("px","")*1;
	if(map_width<700){	
		s1.style.left= "300px";
		
	}
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
				layers : 'ws_cantho:quanhuyen,ws_cantho:xaphuong,ws_cantho:giaothong,ws_cantho:coquan',
				styles : '',
				srs : 'EPSG:4326',
				format : format,
				tiled : 'false',
				transparent : 'true' ,
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

	/** Lop chua tat ca cac dia diem duoc tim**/
	var lop_dia_diem = new OpenLayers.Layer.Vector("lop_dia_diem", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			externalGraphic : anh_dia_diem,
			graphicWidth : 25,
			graphicHeight : 25		
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

	// Them cac lop vua tao vao ban do
	map.addLayers([ lop_duong_di, lop_quan_huyen, lop_dia_diem,
					lop_diem_chon]);
	// hide lop_quan_huyen di
	lop_quan_huyen.setVisibility(false);

	/** tao control DrawFeature ve start_point va end_point**/
	control_ve_diem = new OpenLayers.Control.DrawFeature(lop_diem_chon,
			OpenLayers.Handler.Point, {
				featureAdded : point_Added
			});
	/** tao control DragFeature de drag hai diem start_point va end_point**/
	control_drag = new OpenLayers.Control.DragFeature(lop_diem_chon, {
		// onStart: begin_Drag(),
		// onDrag: Draging(),
		onComplete : drag_Completed
	// duoc kich hoat khi su kien drag ket thuc
	});
	/** Tao control SelectFeature de chon cac diem tren lop_dia_diem* */
	control_select = new OpenLayers.Control.SelectFeature([ lop_dia_diem, lop_quan_huyen, lop_diem_chon ], {
		onSelect : onSelectFeature,// kick hoat khi click chuot tren feature
		onUnSelect : onUnSelectFeature,
		clickout : true,
		toggle : true,
		hover : false
	});
	/** Tao control SelectFeature de doi cursor khi hover feature* */
	control_hover = new OpenLayers.Control.SelectFeature([ lop_dia_diem ], {
		clickout : true,
		toggle : true,
		callbacks : {
			'over' : feature_Hover,
			'out' : feature_Out
		}
	});
	/** Tao control SelectFeature tren lop_quan_huyen* */
	control_select_quan_huyen = new OpenLayers.Control.SelectFeature(
			[lop_quan_huyen], {
				clickout : true,
				toggle : false,
				multiple : false,
				hover : false,
				//toggleKey : "shiftKey", // shift key removes from selection
				multipleKey : "ctrlKey" // ctrl key adds to selection
				//box : true
				//onSelect : onSelectQuanHuyen,// kick hoat khi click chuot tren feature
				//onUnSelect : onUnSelectQuanHuyen
			});
	lop_quan_huyen.events.on({
		featureselected: function(event){
			var feature = event.feature;
			alert("So feature duoc chon: "+lop_quan_huyen.selectedFeatures.length);
			//alert("selecte: "+feature.attributes.ten);
		},
		featureunselected: function(event){
			var feature = event.feature;
			alert("Unselecte: "+feature.attributes.ten);
		}
	});
	/** Them cac controls vua tao vao ban do* */
	map.addControls([ control_drag, control_ve_diem, control_hover, control_select, control_select_quan_huyen]);
	control_hover.activate();
	control_select.activate();
	/** ************************ Style cho lop controlmeasure******************* */
	// style the sketch fancy
	var sketchSymbolizers = {
		"Point" : {
			pointRadius : 4,
			graphicName : "square",
			fillColor : "white",
			fillOpacity : 1,
			strokeWidth : 1,
			strokeOpacity : 1,
			strokeColor : "#333333"
		},
		"Line" : {
			strokeWidth : 3,
			strokeOpacity : 1,
			strokeColor : "#666666",
			strokeDashstyle : "dash"
		}
	};
	var style = new OpenLayers.Style();
	style.addRules([ new OpenLayers.Rule({
		symbolizer : sketchSymbolizers
	}) ]);
	var styleMap = new OpenLayers.StyleMap({
		"default" : style
	});

	control_measure = new OpenLayers.Control.Measure(OpenLayers.Handler.Path, {
		persist : true,
		handlerOptions : {
			layerOptions : {
				styleMap : styleMap
			}
		}
	});
	control_measure.events.on({
		"measure" : handleMeasurements,// kich hoat khi ket thuc viec ve
		// linestring
		"measurepartial" : handleMeasurements
	// kich hoat khi co them mot diem duoc ve
	});
	map.addControl(control_measure);

	// build up all controls
	
	var external_panel = new OpenLayers.Control.Panel({
		div : document.getElementById('overviewmap')
	});
	map.addControl(external_panel);
	map.addControl(new OpenLayers.Control.PanZoomBar());	
	//map.addControl(new OpenLayers.Control.OverviewMap());
	map.addControl(new OpenLayers.Control.Navigation());	
	map.addControl(new OpenLayers.Control.ScaleLine());
	var ovControl = new OpenLayers.Control.OverviewMap();
    ovControl.isSuitableOverview = function() {
        return false;
    };
    map.addControl(ovControl);
	/*
	var control_zoom_in = new OpenLayers.Control.ZoomIn();
	var control_zoom_out = new OpenLayers.Control.ZoomOut();
	var control_panpanel = new OpenLayers.Control.PanPanel();
	var control_panzoom = new OpenLayers.Control.PanZoomBar();
	map.addControl(control_zoom_in);
	map.addControl(control_zoom_out);
	map.addControl(control_panpanel);
	//map.addControl(control_panzoom);
	external_panel.addControls([control_zoom_in, control_zoom_out,control_panpanel]);
	*/
	map.zoomToMaxExtent(bounds);
}
/** **************CAC SU KIEN************************ */
/**
 * ********Goi Webservice sau khi hai diem da duoc them vao
 * lop_diem_chon*********
 */
function point_Added(point) {
	// alert("Diem da duoc ve ! ");
	// kiem tra neu da chon du hai diem thi goi webservice de lay duong di
	var wkt_format = new OpenLayers.Format.WKT();
	var list_layer_diem_chon = map.getLayersByName('lop_diem_chon');
	// dinh nghia type moi cho diem chon
	var lop_diem_chon = list_layer_diem_chon[0];
	num_points = lop_diem_chon.features.length;

	if (num_points == 1) {
		/** *tao icon cho start_point*** */
		// tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = point.layer.styleMap.createSymbolizer(point);
		// thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/tuday.png';
		// set the unique style to the feature
		point.style = symbolizer;
		// ve lai diem voi style moi
		point.layer.drawFeature(point, point.style);
	}
	/** *tao icon cho end_point*** */
	if (num_points == 2) {
		if (flag_end == 1) {
			// lay diem dau tien ra
			var wkt_point_end = lop_diem_chon.features[0].geometry;
			var wkt_point_start = lop_diem_chon.features[1].geometry;
			// alert("point_end: "+wkt_point_end);
			// xoa lop_diem_chon
			lop_diem_chon.destroyFeatures();
			// Them diem moi ve vao
			lop_diem_chon.addFeatures(wkt_format.read(wkt_point_start));
			// them diem thu hai
			lop_diem_chon.addFeatures(wkt_format.read(wkt_point_end));
			/** *Tao icon cho start_point*** */
			// Lay feature vua them vao lop lop_diem_chon ra
			var s_point = lop_diem_chon.features[0];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = s_point.layer.styleMap.createSymbolizer(s_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/tuday.png';
			// Set the unique style to the feature
			s_point.style = symbolizer;
			// Ve lai diem voi style moi
			s_point.layer.drawFeature(s_point);
			/** *Tao icon cho end_point*** */
			// Lay feature vua them vao lop lop_diem_chon ra
			var e_point = lop_diem_chon.features[1];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// Set the unique style to the feature
			e_point.style = symbolizer;
			// Ve lai diem voi style moi
			e_point.layer.drawFeature(e_point);
			// gan lai flag_end = 0
			flag_end = 0;

		} else {
			// tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = point.layer.styleMap.createSymbolizer(point);
			// thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// set the unique style to the feature
			point.style = symbolizer;
			// ve lai diem voi style moi
			point.layer.drawFeature(point, point.style);
		}
	}
	// tao icon cho end_point
	if (num_points == 2) {
		lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}
			/*
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
			*/
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].activate();
			}
		}	
		control_select.activate();
		// control_select.setLayer(lop_dia_diem);
		getDuongDi();
	}
	//control_hover.activate();
}
/** ********Su kien cac feature tren lop_diem_chon duoc drag********* */
function begin_Drag() {
	alert("Bat dau drag");
}
/** ********Su kien cac feature tren lop_diem_chon dang duoc drag********* */
function Draging() {
	alert("Dang drag");
}

function drag_Completed() {
	// alert("Hoan thanh drag");
	// goi webservice o day
	list_layer_diem_chon = map.getLayersByName('lop_diem_chon');
	lop_diem_chon = list_layer_diem_chon[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		getDuongDi();
	}
}
function handleMeasurements(event) {
	var geometry = event.geometry;
	var units = event.units;
	var order = event.order;
	var measure = event.measure;
	// var element = document.getElementById('output');
	//alert("khoang cach = " + measure.toFixed(3) + " " + units);
	var do_dai = measure.toFixed(3) + " " + units;
	// element.innerHTML = out;
	$(".tong-kc").html("Tong khoang cach : "+ do_dai);
}
function onSelectFeature(e) {
	// goi webservice o day de hien thi thong tin cua diem vua chon
	// alert("Da chon feature");
	getDiaDiemTheoViTri(e.geometry);
	/*
	 * pixel = new OpenLayers.Pixel(e.geometry.x, e.geometry.y); alert("Fearture
	 * da duoc chon! tai vi tri: " + pixel); var lonlat =
	 * map.getLonLatFromPixel(pixel); popup = new
	 * OpenLayers.Popup.FramedCloud("chicken", lonlat, new OpenLayers.Size(100,
	 * 100), "tran van hoang", null, true, onPopupClose);
	 */
}
function onUnSelectFeature() {
	alert("Feature duoc bo chon");
}
//Goi dich vu de lay ve duong di cua hai diem duoc chon
function getDuongDi(){
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	// lay toa do hai diem duoc chon
	var start_point = lop_diem_chon.features[0].geometry.clone();
	var end_point = lop_diem_chon.features[1].geometry.clone();
	// goi webservice tra ve duong di giau hai diem
	// alert("Bat dau goi webservice");
	callService(start_point.x, start_point.y, end_point.x, end_point.y);
	// dong thoi diactivate olControlDrawFeature va activate control
}
/** Doi hinh cursor khi hover feature tren lop_dia_diem* */
function feature_Hover(feature) {
	var hover_style = {
		externalGraphic : anh_dia_diem,
		graphicWidth : 32,
		graphicHeight : 32,
		graphicOpacity : 1,
		cursor : 'pointer'
	};
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	lop_dia_diem.drawFeature(feature, hover_style);
}
function feature_Out(feature) {
	// alert("out");
	var out_style = {
		externalGraphic : anh_dia_diem,
		graphicWidth : 25,
		graphicHeight : 25,
		graphicOpacity : 1,
		cursor : 'default'
	};
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	lop_dia_diem.drawFeature(feature, out_style);
}

function onSelectQuanHuyen(feature){
	alert("Select quan huyen"+feature.attributes.ten);
}
function onUnSelectQuanHuyen(feature){
	alert("UnSelect quan huyen"+feature.attributes.ten);
}
