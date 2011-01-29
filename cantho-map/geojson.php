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
	var lon = 5;
	var lat = 40;
	var zoom = 5;
	var map, layer;
	function init() {
		map = new OpenLayers.Map('map');
		layer = new OpenLayers.Layer.WMS("OpenLayers WMS",
				"http://vmap0.tiles.osgeo.org/wms/vmap0", {
					layers : 'basic'				
				});
		map.addLayer(layer);
		map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
		var featurecollection = {
			"type" : "FeatureCollection",
			"features" : [ {
				"geometry" : {
					"type" : "GeometryCollection",
					"geometries" : [
							{
								"type" : "LineString",
								"coordinates" : [
										[ 11.0878902207, 45.1602390564 ],
										[ 15.01953125, 48.1298828125 ] ]
							},
							{
								"type" : "Polygon",
								"coordinates" : [ [
										[ 11.0878902207, 45.1602390564 ],
										[ 14.931640625, 40.9228515625 ],
										[ 0.8251953125, 41.0986328125 ],
										[ 7.63671875, 48.96484375 ],
										[ 11.0878902207, 45.1602390564 ] ] ]
							},
							{
								"type" : "Point",
								"coordinates" : [ 15.87646484375, 44.1748046875 ]
							} ]
				},
				"type" : "Feature",
				"properties" : {}
			} ]
		};
		var geojson_format = new OpenLayers.Format.GeoJSON();
		var vector_layer = new OpenLayers.Layer.Vector();
		map.addLayer(vector_layer);
		vector_layer.addFeatures(geojson_format.read(featurecollection));

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