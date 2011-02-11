// JavaScript Document
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
		//dang ky su kien mousedown cho feature		
		feature.events.register('mousedown', feature, function(e) {
			alert("Ban vua click len mot marker");
		});
	}