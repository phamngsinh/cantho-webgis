<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Filter Feature</title>
<style type="text/css">
#map {
	border: 1px solid black;
	margin-left: 200px;
	clear: both;
	height: 547px;
	position: relative;
	width: 712px;
}

#wrapper {
	width: 500px;
}

#location {
	float: right;
}
</style>

<script type="text/javascript" src="Libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="Libs/jquery-1.4.4.js"></script>
<script type="text/javascript" defer="defer">
	var map, selectControl,selectedFeature;;
	var untiled;
	var tiled;
	var pureCoverage = false;
	OpenLayers.IMAGE_RELOAD_ATTEMPTS = 5;
	OpenLayers.DOTS_PER_INCH = 25.4 / 0.28;

	//KHAI BAO MARKER
	var SHADOW_Z_INDEX = 10;
	var MARKER_Z_INDEX = 11;
	var DIAMETER = 200;
	var NUMBER_OF_FEATURES = 15;
	var layer;

	function onPopupClose(evt) {
		selectControl.unselect(selectedFeature);
	}
	function onFeatureSelect(feature) {
		alert("Da chon doi tuong");
		selectedFeature = feature;
		popup = new OpenLayers.Popup.FramedCloud("chicken", feature.geometry
				.getBounds().getCenterLonLat(), null,
				"<div style='font-size:.8em'>Feature: " + feature.id
						+ "<br />Area: " + feature.geometry.getArea()
						+ "</div>", null, true, onPopupClose);
		feature.popup = popup;
		map.addPopup(popup);
	}
	function onFeatureUnselect(feature) {
		map.removePopup(feature.popup);
		feature.popup.destroy();
		feature.popup = null;
	}

	function init() {

		format = 'image/png';

		var bounds = new OpenLayers.Bounds(533665.483, 1099901.022, 586361.294,
				1141760.714);

		var options = {
			controls : [],
			maxExtent : bounds,
			maxResolution : 205,
			projection : "EPSG:4326",
			units : 'degrees',
			isBaselayer : 'true'
		};

		map = new OpenLayers.Map('map', options);

		//lay ra quan huyen duoi dinh dang raster
		base_layer = new OpenLayers.Layer.WMS("Quan_huyen",
				"http://localhost:8080/geoserver/wms", {
					height : '406',
					width : '512',
					layers : 'ws_cantho:QuanHuyen',
					styles : '',
					srs : 'EPSG:4326',
					format : format,
					tiled : 'true',
					transparent : 'false',
					isBaselayer : 'true',
					tilesOrigin : map.maxExtent.left + ','
							+ map.maxExtent.bottom
				}, {
					buffer : 0,
					displayOutsideMaxExtent : true
				});

		map.addLayers([ base_layer ]);
		
		//dang ky su kien khi them mot lop moi

		// create WFS point layer		

		// build up all controls

		map.addControl(new OpenLayers.Control.PanZoomBar({
			position : new OpenLayers.Pixel(15, 15)
		}));

		map.addControl(new OpenLayers.Control.Navigation());

		map.addControl(new OpenLayers.Control.Scale($('scale')));

		map.addControl(new OpenLayers.Control.MousePosition({
			element : $('location')
		}));
		map.addControl(new OpenLayers.Control.LayerSwitcher());

		layer = new OpenLayers.Layer.Vector("Marker Drop Shadows", {
			styleMap : new OpenLayers.StyleMap({
				externalGraphic : "images/marker-gold.png",
				backgroundGraphic : "images/marker_shadow.png",
				backgroundXOffset : 0,
				backgroundYOffset : -7,
				graphicZIndex : MARKER_Z_INDEX,
				backgroundGraphicZIndex : SHADOW_Z_INDEX,
				pointRadius : 10
			}),
			isBaseLayer : false,
			rendererOptions : {
				yOrdering : true
			}
		});

		map.addLayers([ layer ]);
		//alert("so layer:"+map.getNumLayers());
		// Add a drag feature control to move features around.
		var dragFeature = new OpenLayers.Control.DragFeature(layer);
		map.addControl(dragFeature);
		dragFeature.activate();
		
		var selectFeature= new OpenLayers.Control.SelectFeature(layer,
				{
					onSelect:onSelectFeature,
					onUnselect:onUnselectFeature,
					clickout:'true',
					hover:'true'
				});
		map.addControl(selectFeature);
		selectFeature.activate();
		map.zoomToMaxExtent();		
		
		//dang ky su kien click tren ban do
		map.events.register('click', map, handlerMapClick);

	}
	
	function onSelectFeature(e){
		alert("Da chon marker");
	}
	function onUnselectFeature(e){
		alert("bo chon");
	}
	//Xu lu kien Click len ban do
	function handlerMapClick(e) {
		var feature;
		//alert("su kien click"+e.xy.x+":"+e.xy.y);
		var pixel = new OpenLayers.Pixel(e.xy.x, e.xy.y);
		createMarker(map, layer, pixel);

	}

	function onPopupClose(evt) {
		selectControl.unselect(selectedFeature);
	}
	/*
	@tao maker tren mot lop
	@params:
		map  : Map
		layer: Layer
		pixel: Pixel
	@return: void
	 */
	function createMarker(map, layer, pixel) {
		var feature;
		var lonlat = map.getLonLatFromViewPortPx(pixel);
		feature = (new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(
				lonlat.lon, lonlat.lat)));
		layer.addFeatures(feature);
		
		

		/*
		popup = new OpenLayers.Popup.FramedCloud("chicken", new OpenLayers.LonLat(lonlat.lon,lonlat.lat),
				new OpenLayers.Size(200, 200), "Toa do: "+lonlat.lon+":"+lonlat.lat, true);
		map.addPopup(popup);
		 */
		//dang ky su kien mousedown cho feature		
		feature.events.register('mousedown', feature, function(e) {
			alert("Ban vua click len mot marker");
		});
	}
</script>
</head>
<body onLoad="init()">
<div id="map"></div>
<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>


</body>
</html>