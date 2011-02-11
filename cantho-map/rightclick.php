<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Right Click</title>
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
	var map;
	OpenLayers.ProxyHost = "http://localhost/cantho-map/cgi-bin/proxy.cgi?url=";
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
			isBaselayer : 'true'
		};

		map = new OpenLayers.Map('map',options);

		//lay ra quan huyen duoi dinh dang raster
		base_layer = new OpenLayers.Layer.WMS("Quan_huyen",
				"http://localhost:8080/geoserver/wms", {
					height : '406',
					width : '512',
					layers : 'ws_cantho:quanhuyen,ws_cantho:giaothong',
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
		/*
		map.div.oncontextmenu = function noContextMenu(e) {
			if (OpenLayers.Event.isRightClick(e)) {
				alert("Right button click"); // Add the right click menu here
			}
			return false; //cancel the right click of brower
		};
		*/
		// Get control of the right-click event:
		document.getElementById('map').oncontextmenu = function(e){
		 e = e ? e:window.event;
		 if (e.preventDefault) e.preventDefault(); // For non-IE browsers.
		 else return false; // For IE browsers.
		};
		
		
		// A control class for capturing click events...
		OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {                
		
		defaultHandlerOptions: {
		'single': true,
		'double': true,
		'pixelTolerance': 0,
		'stopSingle': false,
		'stopDouble': false
		},
		handleRightClicks:true,
		initialize: function(options) {
		this.handlerOptions = OpenLayers.Util.extend(
		{}, this.defaultHandlerOptions
		);
		OpenLayers.Control.prototype.initialize.apply(
		this, arguments
		); 
		this.handler = new OpenLayers.Handler.Click(
		this, this.eventMethods, this.handlerOptions
		);
		},
		CLASS_NAME: "OpenLayers.Control.Click"
		
		});
		
		
		// Add an instance of the Click control that listens to various click events:
		var oClick = new OpenLayers.Control.Click({eventMethods:{
		'rightclick': function(e) {
		alert('rightclick at '+e.xy.x+','+e.xy.y);
		},
		'click': function(e) {
		pixel=new OpenLayers.Pixel(e.xy.x,e.xy.y);
		lonlat=map.getLonLatFromPixel(pixel);
		//alert('click at '+e.xy.x+','+e.xy.y);
		alert("click at (lonlat): "+lonlat.lon+','+lonlat.lat);
		
		},
		'dblclick': function(e) {
		alert('dblclick at '+e.xy.x+','+e.xy.y);
		},
		'dblrightclick': function(e) {
		alert('dblrightclick at '+e.xy.x+','+e.xy.y);
		}
		}});
		map.addControl(oClick);
		oClick.activate();
		var lonLat = new OpenLayers.LonLat(lon, lat).transform(
				new OpenLayers.Projection("EPSG:4326"), map
						.getProjectionObject());
		
		map.setCenter(lonLat, zoom);
		
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