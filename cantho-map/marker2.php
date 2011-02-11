<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Filter Feature</title>
<style type="text/css">
#map {
	border: 1px solid black;
	
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
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script type="text/javascript" src="libs/jquery/jquery.corner.js"></script>
<script type="text/javascript" src="libs/jquery/contextmenu/jquery.contextMenu.js"></script>
<link type="text/css" rel="stylesheet" href="libs/jquery/contextmenu/jquery.contextMenu.css"></link>
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
		giao_thong = new OpenLayers.Layer.WMS("Giao thong",
				"http://localhost:8080/geoserver/wms", {
					height : '406',
					width : '512',
					layers : 'ws_cantho:giaothong',
					styles : '',
					srs : 'EPSG:4326',
					format : format,
					tiled : 'true',
					transparent : 'true',					
					tilesOrigin : map.maxExtent.left + ','
							+ map.maxExtent.bottom
				}, {
					buffer : 0,					
					displayOutsideMaxExtent : true
				});
		
		map.addLayers([ quan_huyen, giao_thong ]);
		
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

		layer = new OpenLayers.Layer.Vector("points", {
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
		//map.events.register('click', map, handlerMapClick);

	}
	/**************doi contextMenu khi hover marker tren lop layer************************/
	function onSelectFeature(e){
		//alert("Da chon marker");
		$('#map').destroyContextMenu();
		$("#map").contextMenu({menu:'myMenu_2'},
							   function(action,el,pos){contextMenuWork(action,el,pos);}
							);
	}
	function onUnselectFeature(e){
		//alert("bo chon");
		$('#map').destroyContextMenu();
		$("#map").contextMenu({menu:'myMenu_1'},
							   function(action,el,pos){contextMenuWork(action,el,pos);}
							);
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
		//alert("position:"+pixel);
		feature = (new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(
				lonlat.lon, lonlat.lat)));
		layer.addFeatures(feature);
		
		//dang ky su kien mousedown cho feature		
		/*
		feature.events.register('mousedown', feature, function(e) {
			alert("Ban vua click len mot marker");
		});
		*/
	}
	$(document).ready(function(){
							   
							   $(".contextMenu").corner();/**Rounding contextMenu**/							   							   $("#map").contextMenu({menu:'myMenu_1'},
													 function(action,el,pos){contextMenuWork(action,el,pos);}
													 );						   
							   });//end $(document).ready(function()
							   
							  
	function contextMenuWork(action,el,pos)
							   {
									switch(action)
									{
										case "tu_day":
										{
											//alert("action firstpoint at position: X="+pos.x+': y='+pos.y+'\n'+'Element ID: '+$(el).attr('id'));
											/*create marker for first point*/											
											alert('so feature hien tai: '+layer.features.length);
											var pixel= new OpenLayers.Pixel(pos.x,pos.y);												
											if (layer.features.length==2)
											{
												return;
											}
											createMarker(map,layer,pixel);

											break;
										}
										case "den_day":
										{
											/*create marker for first point*/
											alert('so feature hien tai: '+layer.features.length);
											var pixel= new OpenLayers.Pixel(pos.x,pos.y);												
											if (layer.features.length==2)
											{
												return;
											}
											createMarker(map,layer,pixel);
											break;
										}	
										case "xoa_diem":
										{
											//alert('so feture: '+layer.selectedFeatures.length);
											if (layer.selectedFeatures.length==1)
											{												
												layer.removeFeatures(layer.selectedFeatures);			
												
											}
											onUnselectFeature();
											break;											
										}
									}
							   }
</script>
</head>
<body onLoad="init()">
<div id="map"></div>
<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>
	<!-- Right Click Menu 1-->
    <ul id="myMenu_1" class="contextMenu">    
        <li class="tu_day"><a href="#tu_day">Từ đây</a></li>
        <li class="den_day"><a href="#den_day">Đến đây</a></li> 
        <li class="separator"></li>    
        <li class="tim_xung_quanh"><a href="#tim_xung_quanh">Tìm Xung Quanh</a></li>        
	</ul>
    <!-- Right Click Menu 2-->
    <ul id="myMenu_2" class="contextMenu">    
        <li class="xoa_diem"><a href="#xoa_diem">Xóa điểm này</a></li>
        <li class="den_day"><a href="#den_day">Đến đây</a></li> 
        <li class="separator"></li>    
        <li class="tim_xung_quanh"><a href="#tim_xung_quanh">Tìm Xung Quanh</a></li>        
	</ul>
</body>
</html>