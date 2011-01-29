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
	$(function(){
		//alert("Bat dau jquery");		
	});
	OpenLayers.ProxyHost = 'http://localhost/cantho-map/cgi-bin/proxy.cgi?url=';
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
			controls : [
			//new OpenLayers.Control.PanZoom(),
			//new OpenLayers.Control.Permalink(),
			//new OpenLayers.Control.Navigation() 
			],
			maxExtent : bounds,
			maxResolution : 205.84301171874995,
			projection : "EPSG:4326",
			units : 'degrees',
			isBaselayer : 'true',
			numZoomLevels : 5
		};

		map = new OpenLayers.Map('map', options);

		//lay ra quan huyen duoi dinh dang raster
		quan_huyen = new OpenLayers.Layer.WMS(
				"Quan_huyen",
				"http://localhost:8080/geoserver/wms",
				{
					layers : 'ws_cantho:QuanHuyen',
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
		
		xa_phuong= new OpenLayers.Layer.WMS(
				'Xa Phuong',
				'http://localhost:8080/geoserver/wms',
				{
					layers:'ws_cantho:XaPhuong',
					transparent: true,
					format: format,
					srs : 'EPSG:4326',
					tiled : true
				},
				{
					isBaseLayer: false,
					displayOutsideMaxExtent : true
				}
				);
		map.addLayer(xa_phuong);
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
		options = {
			srs : 'EPSG:4326'
		};
		map.addControl(new OpenLayers.Control.OverviewMap(options));		
		//tao lop selected_layer
		selected_layer = new OpenLayers.Layer.Vector("selected layer", {
			styleMap : new OpenLayers.Style(
					OpenLayers.Feature.Vector.style['select'])
		});
		map.addLayer(selected_layer);
		//alert("So lop hien tai: "+map.getNumLayers());
		control = new OpenLayers.Control.GetFeature({
			protocol : OpenLayers.Protocol.WFS.fromWMSLayer(xa_phuong),
			box : true,
			//hover : true,
			multipelKey : "shiftKey",
			toggleKey : "ctrlKey"
		});
		
		control.events.register('featureselected', this, function(e) {
			selected_layer.addFeatures([ e.feature ]);
			//alert(e.feature.attributes.phuong_xa);
			//alert(e.feature.attributes.dan_so);
			//alert(e.feature.geometry.getArea());
			//alert(e.feature.geometry.toString());
			
		});
		control.events.register("featureunselected", this, function(e) {
			selected_layer.removeFeatures([ e.feature ]);
			//selected_layer.removeAllFeatures();
		});
		/*
		control.events.register("hoverfeature", this, function(e) {
			hover.addFeatures([ e.feature ]);
		});
		
		control.events.register("outfeature", this, function(e) {
			hover.removeFeatures([ e.feature ]);
		});
		*/
		map.addControl(control);
		control.activate();
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