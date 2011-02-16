<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Client Axis</title>
<style type="text/css">
#map {
	border: 1px solid black;
	
	clear: both;
	height: 547px;
	
	width: 850px;
}

#wrapper {
	width: 500px;
}

#location {
	float: right;
}
</style>

<script type="text/javascript" src="../libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="../libs/jquery/jquery-1.4.4.js"></script>
<script type="text/javascript" src="../libs/soap/soapclient.js"></script>
<script type="text/javascript" src="../libs/jquery/contextmenu/jquery.contextMenu.js"></script>
<link type="text/css" rel="stylesheet" href="../libs/jquery/contextmenu/jquery.contextMenu.css"></link>
<script type="text/javascript" src="../libs/web/DrawPoints.js"></script>
<script type="text/javascript" defer="defer">
	//end point webservice
	var url = "http://localhost:8888/MyWebSV/services/GisData";
	var map;
	$(document).ready(function(){
								$("#btn_callservice").click(function(){
																	 call_Shortest_Path();
																	 }); 
							   });//end $(document).ready(function()
	
	function call_Shortest_Path()
	{
		var pl = new SOAPClientParameters();		
		pl.add('a',10);
		pl.add('b',20);
		SOAPClient.invoke(url, "Tong", pl, true, shortest_Path_CallBack);
	} 
	function shortest_Path_CallBack(result)
	{
		alert(result);
		/*
		var geojson_format = new OpenLayers.Format.GeoJSON();
		var vector_layer = new OpenLayers.Layer.Vector();
		map.addLayer(vector_layer);
		vector_layer.addFeatures(geojson_format.read(result)); 
		*/
	}
	
	
	function init()
	{
		//KHAI BAO MARKER
		var SHADOW_Z_INDEX = 10;
		var MARKER_Z_INDEX = 11;
		var DIAMETER = 200;
		var NUMBER_OF_FEATURES = 15;
		
		OpenLayers.IMAGE_RELOAD_ATTEMPTS = 5;
		// make OL compute scale according to WMS spec
		OpenLayers.DOTS_PER_INCH = 25.4 / 0.28; 
		var format='image/png';
		var bounds = new OpenLayers.Bounds(
						524847.24, 1097030.63,
						592626.076, 1142071.805
					); 
		var options = {
						controls: [],
						maxExtent: bounds,
						maxResolution: 264.76107812500004,
						projection: "EPSG:4326",
						units: 'degrees',
						numZoomLevels: 11
					}; 
		map=new OpenLayers.Map('map',options);	
		
		// setup tiled layer
		quan_huyen = new OpenLayers.Layer.WMS(
				"quan huyen", 
				"http://localhost:8080/geoserver/wms",
				{
					layers: 'ws_cantho:quanhuyen',
					styles: '',
					srs: 'EPSG:4326',
					format: format,
					tiled: 'true',
					transparent: true,
					tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
				},
				{
					buffer: 0,
					isBaseLayer:true
					//displayOutsideMaxExtent: true
				}
		); 
		giao_thong= new OpenLayers.Layer.WMS(
											 "giao thong",
											 "http://localhost:8080/geoserver/wms",
											 {
												 layers: 'ws_cantho:giaothong',
												 styles:'',
												 srs: 'EPSG:4326',
												 tiled: true,
												 transparent: true,
												 tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
											 },
											 {
												 buffer: 0,
												 isBaseLayer: false
											 }
											 );
		
		map.addLayers([quan_huyen,giao_thong]);
		// build up all controls
		var options = {mapOptions: {numZoomLevels: 1}};
			map.addControl(new OpenLayers.Control.PanZoomBar({
			position: new OpenLayers.Pixel(2, 15)
		}));
		map.addControl(new OpenLayers.Control.LayerSwitcher());
		map.addControl(new OpenLayers.Control.Navigation());
		map.addControl(new OpenLayers.Control.Scale($('scale')));
		map.addControl(new OpenLayers.Control.MousePosition({element: $('location')}));		
   		map.addControl(new OpenLayers.Control.OverviewMap(options));
		map.zoomToMaxExtent(); 
				
		// create the layer where the route will be drawn
		var route_layer = new OpenLayers.Layer.Vector("route", {
			styleMap: new OpenLayers.StyleMap(new OpenLayers.Style({
				strokeColor: "#ff9933",
				strokeWidth: 3
			}))
		});
		// create the layer where the start and final points will be drawn
				
		var points_layer = new OpenLayers.Layer.Vector("Points", {
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
		
		map.addLayers([route_layer,points_layer]);
		
		// create the control to draw the points (see the DrawPoints.js file)
		//var draw_points = new DrawPoints(points_layer);		
		// create the control to move the points
		var drag_points = new OpenLayers.Control.DragFeature(points_layer, {
		autoActivate: true
		});
		
		// add the controls to the map
		map.addControls([drag_points]);		
		
	}//end function inti();		
	
	
</script>
</head>
<body onLoad="init()">
    <div id="map"></div>
    <div id="wrapper"></div>
    <div id="location"></div>
    <div id="scale"></div>
    <!-- Right Click Menu -->
    <ul id="myMenu" class="contextMenu">    
        <li class="tu_day"><a href="#tu_day">Từ đây</a></li>
        <li class="den_day"><a href="#den_day">Đến đây</a></li>            
	</ul>
    <input type="button" id="btn_callservice" value="Call Service"/>
</body>
</html>