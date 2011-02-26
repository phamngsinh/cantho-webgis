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
		units : 'degrees',
		isBaselayer : 'true',
		numZoomLevels : 12
	};

	map = new OpenLayers.Map('map', options);
	// lay ra quan huyen duoi dinh dang raster
	quan_huyen = new OpenLayers.Layer.WMS("Quan_huyen",
			"http://localhost:8080/geoserver/wms", {
				layers : 'ws_cantho:quanhuyen,ws_cantho:giaothong',
				styles : '',
				srs : 'EPSG:4326',
				format : format,
				tiled : 'true',
				transparent : 'true',
				tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
			}, {
				buffer : 0,
				isBaseLayer : true,
				displayOutsideMaxExtent : true
			});

	map.addLayers([ quan_huyen ]);
	/** Tao lop vector hien thi duong di duoc tim */
	// var duong_di = new OpenLayers.Layer.Vector("duong_di");
	var duong_di = new OpenLayers.Layer.Vector("duong_di", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			strokeColor : "#8A2BE2",
			strokeWidth : 5
		// strokeOpacity: 0.6
		}))
	});

	var diem_chon = new OpenLayers.Layer.Vector("diem_chon", {
		styleMap : new OpenLayers.StyleMap(new OpenLayers.Style({
			externalGraphic : 'images/Vietnam-icon.png',
			graphicWidth : 20,
			graphicHeight : 20
		// strokeOpacity: 0.6
		}))
	});
	map.addLayers([ duong_di, diem_chon ]);
	// gan control chon diem cho lop diem_chon
	var control_ve_diem = new OpenLayers.Control.DrawFeature(diem_chon,
			OpenLayers.Handler.Point, {
				featureAdded : point_Added
			});
	map.addControl(control_ve_diem);
	var control_drag = new OpenLayers.Control.DragFeature(diem_chon, {
		// onStart: begin_Drag(),
		// onDrag: Draging(),
		onComplete : drag_Completed
	});
	map.addControl(control_drag);

	// control_ve_diem.activate();
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

	// map.addControl(new OpenLayers.Control.OverviewMap());
	// alert("So lop hien tai: "+map.getNumLayers());
	/*
	 * control.events.register("hoverfeature", this, function(e) {
	 * hover.addFeatures([ e.feature ]); });
	 * 
	 * control.events.register("outfeature", this, function(e) {
	 * hover.removeFeatures([ e.feature ]); });
	 */
	map.zoomToExtent(bounds);
}
function point_Added() {
	// alert("Diem da duoc ve ! ");
	// kiem tra neu da chon du hai diem thi goi webservice de lay duong di
	list_layer_diem_chon = map.getLayersByName('diem_chon');
	lop_diem_chon = list_layer_diem_chon[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		// lay toa do hai diem duoc chon
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		// goi webservice tra ve duong di giau hai diem

		callService(start_point.x, start_point.y, end_point.x, end_point.y);

		// dong thoi diactivate olControlDrawFeature va activate control
		// olNavigation
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

function begin_Drag() {
	alert("Bat dau drag");
}
function Draging() {
	alert("Dang drag");
}
function drag_Completed() {
	// alert("Hoan thanh drag");
	// goi webservice o day
	list_layer_diem_chon = map.getLayersByName('diem_chon');
	lop_diem_chon = list_layer_diem_chon[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		// lay toa do hai diem duoc chon
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		// goi webservice tra ve duong di giau hai diem
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}
	
	function reset_DuongDi() {
		alert("sdgsd");
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
}