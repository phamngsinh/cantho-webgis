<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>WebMap Can Tho </title>
<script language="javascript" src="http://localhost:8080/geoserver/openlayers/OpenLayers.js" type="text/javascript"></script>
<style type="text/css">
#map
{
	border:1px solid black;
	margin-left:200px;
	clear:both;
	height:547px;
	position:relative;
	width:712px;
}
#wrapper
{
	width:500px;
}
#location
{
	float:right;
}
</style>
<script type="text/javascript" defer="defer">

	OpenLayers.ProxyHost = "/cgi-bin/proxy.cgi?url=";

	var map, info;

	function init() {
		format = 'image/png';
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
			isBaselayer : true
		};

		map = new OpenLayers.Map('map', options);
		map.addControl(new OpenLayers.Control.PanZoomBar({
			position : new OpenLayers.Pixel(15, 15)
		}));
		// build up all controls
		map.addControl(new OpenLayers.Control.Navigation());

		map.addControl(new OpenLayers.Control.Scale($('scale')));

		map.addControl(new OpenLayers.Control.MousePosition({
			element : $('location')
		}));

		//lay ra quan huyen duoi dinh dang raster
		base_layer = new OpenLayers.Layer.WMS("Quan_huyen",
				"http://localhost:8080/geoserver/wms", {
					height : '406',
					width : '512',
					layers : 'ws_CanTho:Quan huyen',
					styles : '',
					srs : 'EPSG:4326',
					format : format,
					tiled : true,
					transparent : false,
					isBaselayer : true,
					tilesOrigin : map.maxExtent.left + ','
							+ map.maxExtent.bottom
				}, {
					buffer : 0,
					displayOutsideMaxExtent : true
				});
		/*
		var highlight = new OpenLayers.Layer.Vector("Highlighted Features", {
			displayInLayerSwitcher : false,
			isBaseLayer : false
		});
		*/
		map.addLayers([ base_layer]);
		
		// support GetFeatureInfo
		map.events.register('click',map,function(e) {
							//document.getElementById('nodelist').innerHTML = "Loading... please wait...";
							var params = {
								REQUEST : "GetFeatureInfo",
								EXCEPTIONS : "application/vnd.ogc.se_xml",
								BBOX : map.getExtent().toBBOX(),
								X : e.xy.x,
								Y : e.xy.y,
								INFO_FORMAT : 'text/plain',
								QUERY_LAYERS : map.layers[0].params.LAYERS,
								FEATURE_COUNT : 10,
								Layers : 'ws_CanTho:Quan huyen',
								Styles : '',
								Srs : 'EPSG:4326',
								WIDTH : map.size.w,
								HEIGHT : map.size.h,
								format : format
							};
							//alert(params);
							OpenLayers.loadURL(OpenLayers.ProxyHost+"http://localhost:8080/geoserver/wms",params, this, setHTML, setHTML);
							OpenLayers.Event.stop(e);
						});	
		
		
	map.addControl(new OpenLayers.Control.LayerSwitcher());
	map.zoomToMaxExtent();
	
}
	
	//Build others functions
	// sets the HTML provided into the nodelist element
	function setHTML(response) {
		//document.getElementById('nodelist').innerHTML = response.responseText;
		alert(response.responseText);
	};

</script>

</head>

<body onload="init()">
<div id="map"></div>
<div id="wrapper">
	<div id="location"></div>
    <div id="scale"></div>
</div>
<div id="msg">
<table>

</table>
</div>
</body>
</html>