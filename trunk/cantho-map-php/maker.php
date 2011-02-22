<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Marker</title>
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
	var map, layer;
	function init() {
		OpenLayers.ProxyHost = "http://localhost/cantho-map/cgi-bin/proxy/?url=";
		map = new OpenLayers.Map('map');
		layer = new OpenLayers.Layer.WMS("OpenLayers WMS",
				"http://vmap0.tiles.osgeo.org/wms/vmap0", {
					layers : 'basic'
				});
		map.addLayer(layer);
		map.setCenter(new OpenLayers.LonLat(0, 0), 0);
		var newl = new OpenLayers.Layer.Text("text", {
			location : "./textfile.txt"
		});
		map.addLayer(newl);
		var markers = new OpenLayers.Layer.Markers("Markers");
		map.addLayer(markers);
		var size = new OpenLayers.Size(21, 25);
		var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
		var icon = new OpenLayers.Icon(
				'http://www.openlayers.org/dev/img/marker.png', size, offset);
		markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(0, 0),
				icon));
		var halfIcon = icon.clone();
		markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(0, 45),
				halfIcon));
		marker = new OpenLayers.Marker(new OpenLayers.LonLat(90, 10), icon
				.clone());
		marker.setOpacity(0.2);
		marker.events.register('mousedown', marker, function(evt) {
			alert(this.icon.url);
			OpenLayers.Event.stop(evt);
		});
		markers.addMarker(marker);
		map.addControl(new OpenLayers.Control.LayerSwitcher());
		map.zoomToMaxExtent();
		halfIcon.setOpacity(0.5);
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