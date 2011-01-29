<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GetFeatureInfo</title>
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
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script type="text/javascript" defer="defer">
	
    OpenLayers.ProxyHost = "http://localhost/cantho-map/cgi-bin/proxy.cgi?url=";
    
    var map, info;
    
    function load() {
        map = new OpenLayers.Map({
            div: "map",
            maxExtent: new OpenLayers.Bounds(143.834,-43.648,148.479,-39.573)
        });

        var political = new OpenLayers.Layer.WMS("State Boundaries",
            "http://demo.opengeo.org/geoserver/wms", 
            {'layers': 'topp:tasmania_state_boundaries', transparent: true, format: 'image/gif'},
            {isBaseLayer: true}
        );

        var roads = new OpenLayers.Layer.WMS("Roads",
            "http://demo.opengeo.org/geoserver/wms", 
            {'layers': 'topp:tasmania_roads', transparent: true, format: 'image/gif'},
            {isBaseLayer: false}
        );

        var cities = new OpenLayers.Layer.WMS("Cities",
            "http://demo.opengeo.org/geoserver/wms", 
            {'layers': 'topp:tasmania_cities', transparent: true, format: 'image/gif'},
            {isBaseLayer: false}
        );

        var water = new OpenLayers.Layer.WMS("Bodies of Water",
            "http://demo.opengeo.org/geoserver/wms", 
            {'layers': 'topp:tasmania_water_bodies', transparent: true, format: 'image/gif'},
            {isBaseLayer: false}
        );

        var highlight = new OpenLayers.Layer.Vector("Highlighted Features", {
            displayInLayerSwitcher: false, 
            isBaseLayer: false 
        });
        
       map.addLayers([political, roads, cities, water, highlight]); 

        info = new OpenLayers.Control.WMSGetFeatureInfo({
            url: 'http://demo.opengeo.org/geoserver/wms', 
            title: 'Identify features by clicking',
            queryVisible: true,
            eventListeners: {
                getfeatureinfo: function(event) {
                    map.addPopup(new OpenLayers.Popup.FramedCloud(
                        "chicken", 
                        map.getLonLatFromPixel(event.xy),
                        null,
                        event.text,
                        null,
                        true
                    ));
                }
            }
        });
        map.addControl(info);
        info.activate();
        map.addControl(new OpenLayers.Control.LayerSwitcher());
        map.zoomToMaxExtent();
    }

  
</script>

</head>
<body onLoad="load()">
<div id="map"></div>
<div id="wrapper">
<div id="location"></div>
<div id="scale"></div>
</div>
<div id="msg"><label>Tên Chợ</label> <input type="text"
	id="txt_filter" /> <input type="button" id="btn_filter" value="Tìm"></input>
<table>
</table>
</div>
</body>
</html>