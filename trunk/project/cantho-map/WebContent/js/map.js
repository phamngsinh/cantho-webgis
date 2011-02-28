/**
 * 
 */
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
		units : 'm',
		isBaselayer : 'true',
		numZoomLevels : 12
	};

	map = new OpenLayers.Map('map', options);
	// lay ra quan huyen duoi dinh dang raster
	lop_quan_huyen = new OpenLayers.Layer.WMS("Quan_huyen",
			"http://localhost:8080/geoserver/wms", {
				layers : 'ws_cantho:quanhuyen,ws_cantho:giaothong',
				styles : '',
				srs : 'EPSG:4326',
				format : format,
				tiled : 'true',
				transparent : 'true',
				tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
			}, {
				buffer : 1,
				isBaseLayer : true,
				displayOutsideMaxExtent : true
			});

	map.addLayers([ lop_quan_huyen ]);

	/** Lop hien thi duong duong di ngan nhat* */
	var lop_duong_di = new OpenLayers.Layer.Vector("lop_duong_di", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			strokeColor : "#8A2BE2",
			strokeWidth : 5
		// strokeOpacity: 0.6
		}))
	});

	/** Lop chua tat ca cac dia diem duoc tim* */
	var lop_dia_diem = new OpenLayers.Layer.Vector("lop_dia_diem", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			externalGraphic : 'images/tick_1.png',
			graphicWidth : 25,
			graphicHeight : 25
		// strokeOpacity: 0.6
		}))
	});
	/** Lop chua hai diem duoc chon, de tim duong di* */
	var lop_diem_chon = new OpenLayers.Layer.Vector("lop_diem_chon", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			externalGraphic : 'images/Vietnam-icon.png',
			graphicWidth : 20,
			graphicHeight : 20
		// strokeOpacity: 0.6
		}))
	});

	map.addLayers([ lop_duong_di, lop_dia_diem, lop_diem_chon ]);

	/** tao control DrawFeature ve start_point va end_point* */
	var control_ve_diem = new OpenLayers.Control.DrawFeature(lop_diem_chon,
			OpenLayers.Handler.Point, {
				featureAdded : point_Added
			});
	/** tao control DragFeature de drag hai diem start_point va end_point* */
	var control_drag = new OpenLayers.Control.DragFeature(lop_diem_chon, {
		// onStart: begin_Drag(),
		// onDrag: Draging(),
		onComplete : drag_Completed
	// duoc kich hoat khi su kien drag ket thuc
	});
	/** tao control SelectFeature de chon cac diem tren lop_dia_diem* */
	var control_select = new OpenLayers.Control.SelectFeature(lop_dia_diem, {
		onSelect : onSelectFeature,// kick hoat khi click chuot tren feature
		onUnSelect : onUnSelectFeature,//
		clickout : true
	});

	/** Them cac controls vua tao vao ban do* */
	map.addControls([ control_drag, control_ve_diem, control_select ]);
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
	map.addControl(new OpenLayers.Control.PanZoomBar({
		position : new OpenLayers.Pixel(5, 10)
	}));
	map.addControl(new OpenLayers.Control.Navigation());
	// map.addControl(new OpenLayers.Control.LayerSwitcher());
	map.addControl(new OpenLayers.Control.Scale($('scale')));
	map.addControl(new OpenLayers.Control.MousePosition({
		element : $('location')
	}));
	map.zoomToMaxExtent(bounds);
}
/** **************CAC SU KIEN************************ */
/**
 * ********Goi Webservice sau khi hai diem da duoc them vao
 * lop_diem_chon*********
 */
function point_Added() {
	// alert("Diem da duoc ve ! ");
	// kiem tra neu da chon du hai diem thi goi webservice de lay duong di
	list_layer_diem_chon = map.getLayersByName('lop_diem_chon');
	lop_diem_chon = list_layer_diem_chon[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].activate();
			}
		}
		// lay toa do hai diem duoc chon
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		// goi webservice tra ve duong di giau hai diem
		// alert("Bat dau goi webservice");
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
		// dong thoi diactivate olControlDrawFeature va activate control
	}
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
		// lay toa do hai diem duoc chon
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		// goi webservice tra ve duong di giau hai diem
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}
}
function handleMeasurements(event) {
	var geometry = event.geometry;
	var units = event.units;
	var order = event.order;
	var measure = event.measure;
	// var element = document.getElementById('output');
	alert("khoang cach = " + measure.toFixed(3) + " " + units);
	var do_dai = "measure: " + measure.toFixed(3) + " " + units;
	// element.innerHTML = out;
}
function onSelectFeature(e) {

	// goi webservice o day de hien thi thong tin cua diem vua chon
	getDiaDiemTheoViTri(e.geometry);
	/*	 
	pixel = new OpenLayers.Pixel(e.geometry.x, e.geometry.y);
	alert("Fearture da duoc chon! tai vi tri: " + pixel);
	var lonlat = map.getLonLatFromPixel(pixel);
	popup = new OpenLayers.Popup.FramedCloud("chicken", lonlat, 
			new OpenLayers.Size(100, 100),
			"tran van hoang", null, true, onPopupClose);
	*/

}


function onUnSelectFeature(e) {
	alert("Feature duoc bo chon");
}