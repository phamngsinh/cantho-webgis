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
	var map, controls;
	
	OpenLayers.Feature.Vector.style['default']['strokeWidth'] = '2';
	
	function init() {
		map = new OpenLayers.Map('map');
		var vectors = new OpenLayers.Layer.Vector("vector", {
			isBaseLayer : true
		});
		map.addLayers([ vectors ]);
		var feature = new OpenLayers.Feature.Vector(
				OpenLayers.Geometry.fromWKT("POLYGON((28.828125 0.3515625, 132.1875 -13.0078125, -1.40625 -59.4140625, 28.828125 0.3515625))"));
		vectors.addFeatures([ feature ]);
		var feature2 = new OpenLayers.Feature.Vector(
				OpenLayers.Geometry.fromWKT("POLYGON((-120.828125 -50.3515625, -80.1875 -80.0078125, -40.40625 -20.4140625, -120.828125 -50.3515625))"));
		vectors.addFeatures([ feature2 ]);
		var report = function(e) {
			OpenLayers.Console.log(e.type, e.feature.id);
		};
		var highlightCtrl = new OpenLayers.Control.SelectFeature(vectors, {
			hover : true,
			highlightOnly : true,
			renderIntent : "temporary",
			eventListeners : {
				beforefeaturehighlighted : report,
				featurehighlighted : report,
				featureunhighlighted : report
			}
		});
		var selectCtrl = new OpenLayers.Control.SelectFeature(vectors, {
			clickout : true
		});
		map.addControl(highlightCtrl);
		map.addControl(selectCtrl);
		highlightCtrl.activate();
		selectCtrl.activate();
		map.addControl(new OpenLayers.Control.EditingToolbar(vectors));
		map.setCenter(new OpenLayers.LonLat(0, 0), 1);
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