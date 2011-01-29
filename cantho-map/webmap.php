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

	
	var map;
	var untiled;
	var tiled;
	var pureCoverage=false;
	OpenLayers.IMAGE_RELOAD_ATTEMPTS=5;
	OpenLayers.DOTS_PER_INCH=25.4 / 0.28;
		
	function init()
	{	
		
		format='image/png';		
		
		
		var bounds = new OpenLayers.Bounds(
											533665.483, 1099901.022,
											586361.294, 1141760.714
											); 
		
		
		var options = {
						controls: [],
						maxExtent: bounds,
						maxResolution: 205.84301171874995,
						projection: "EPSG:4326",
						units: 'degrees',
						isBaselayer:'true'
						//transitionEffect:'giao_thong'
						}; 
		

		map=new OpenLayers.Map('map',options);
		
		base_layer=new OpenLayers.Layer.WMS(
											"Quan_huyen","http://localhost:8080/geoserver/wms",
											{
												height: '406',
												width: '512',
												layers: 'ws_cantho:QuanHuyen',
												styles:'',
												srs: 'EPSG:4326',
												format: format,
												tiled: 'true',
												transparent:'false',
												isBaselayer:'true',
												tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom
											},
											{
												buffer: 0,
												displayOutsideMaxExtent: true
											} 
											);
				
		
		map.addLayers([base_layer]);
		//dang ky su kien khi them mot lop moi


// create WFS point layer

	


		//map.addLayer(giao_thong);			
		// build up all controls
				
		//marker=new OpenLayers.Layer.Marker("marker");
		
		map.addControl(new OpenLayers.Control.PanZoomBar({
		position: new OpenLayers.Pixel(2, 15)
		}));
		
		map.addControl(new OpenLayers.Control.Navigation());
		
		map.addControl(new OpenLayers.Control.Scale($('scale')));
		
		map.addControl(new OpenLayers.Control.MousePosition({element: $('location')}));
		
		map.zoomToExtent(bounds);
		// wire up the option button
		
		//var options = document.getElementById("options");
		//options.onclick = toggleControlPanel; 
		//var markers = new OpenLayers.Layer.Markers("Markers" );
		
		//lay thong tin cac feature tren ban do
		map.events.register('click',map,function(e){
												 //alert("so lop hien tai: "+map.getNumLayers());
												 //them popup
												 //alert("x:"+e.xy.x+"-y:"+e.xy.y);
												var pixel=new OpenLayers.Pixel(e.xy.x,e.xy.y);
												var lonlat=map.getLonLatFromPixel(pixel);																		
												
												alert('vi tri: '+e.xy.x+','+e.xy.y);								
												
												/*			  
												
												 document.getElementById('msg').innerHTML='Đang tải dữ liệu, xin vui lòng chờ ....';
												 
												 var params = {
													REQUEST: "GetFeatureInfo",
													EXCEPTIONS: "application/vnd.ogc.se_xml",
													BBOX: map.getExtent().toBBOX(),
													X: e.xy.x,
													Y: e.xy.y,
													INFO_FORMAT: 'text/html',
													QUERY_LAYERS: map.layers[0].params.LAYERS,
													FEATURE_COUNT: 50,
													Layers: 'ws_CanTho:Gthong',
													Styles: '',
													Srs: 'EPSG:4326',
													WIDTH: map.size.w,
													HEIGHT: map.size.h,
													format: format}; 											
																									
												 OpenLayers.loadURL("http://localhost:8080/geoserver/wms",params,this,setHTML,Fail);
												 OpenLayers.Event.stop(e);		
												 */
												 });
		
		//hien thi ket quan tra ve sau  khi truy xuat thong tin
		function setHTML(response)
		{			
			alert(response);
			//document.getElementById('msg').innerHTML=response.responseText;
		}
		function Fail()
		{
			document.getElementById('msg').innerHTML='Fail....';
		}
		
	}

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