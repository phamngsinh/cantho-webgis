<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Filter</title>
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
	$(function() {
		//alert("bat dau jQuery");
		$("#btn_filter").click(function() {
			Filter($("#txt_filter").val());
		});
	});

	//OpenLayers.ProxyHost = "http://localhost/cantho-map/cgi-bin/proxy.cgi?url=";
	OpenLayers.ProxyHost = "cgi-bin/proxy.cgi?url=";
	var map, info, select_control;

	function Filter(text) {
		//alert(text);
		var filterParams = {
			filter : null,
			cql_filter : null,
			featureId : null
		};

		filterParams["cql_filter"] = "ten LIKE '%" + text + "%'";

		uy_ban.mergeNewParams(filterParams);
		//alert("Bat dau merge: "+text);
	}//ket thuc function Filter

	function init() {
		format = 'image/png';
		// pink tile avoidance
		OpenLayers.IMAGE_RELOAD_ATTEMPTS = 8;
		// make OL compute scale according to WMS spec
		OpenLayers.DOTS_PER_INCH = 25.4 / 0.28;

		var bounds = new OpenLayers.Bounds(105.749, 10.002, 105.802, 10.061);
		//var bounds = new OpenLayers.Bounds(533665.483, 1099901.022, 586361.294, 1141760.714);

		var options = {
			controls : [],
			maxExtent : bounds,
			maxResolution : 0.00023046875,
			projection : "EPSG:4326",
			units : 'degrees',
			numZoomLevels : 5
		};
		//dinh nghia cac style cho ban do
		//alert('hoang');
		var khach_san_styles = new OpenLayers.StyleMap({
			"default" : {
				graphicName : "star",
				pointRadius : 10,
				strokeColor : "fuchsia",
				strokeWidth : 2,
				fillColor : "lime",
				fillOpacity : 0.6
			},
			"select" : {
				pointRadius : 20,
				fillOpacity : 1,
				rotation : 45
			}
		});
		//alert('hoang');
		map = new OpenLayers.Map('map', options);
		// setup tiled layer
		uy_ban = new OpenLayers.Layer.WMS("Uy Ban",
				"http://localhost:8080/geoserver/wms", {
					layers : 'ws_cantho:uyban',
					srs : 'EPSG:4326',
					format : format,
					transparent : true,
					tile : true,
					styleMap:khach_san_styles

				}, {
					displayOutsideMaxExtent : true,
					isBaseLayer : true
				});
		map.addLayers([ uy_ban ]);
		//tao lop vector KhachSan
		/*
		select_control = new OpenLayers.Control.SelectFeature(khach_san, {
			onSelect : onFeatureSelect(),
			onUnSelect : onFeatureUnSelect()
		});
		 */				 
		var khach_san = new OpenLayers.Layer.Vector("Khach San", {
			strategies : [ new OpenLayers.Strategy.BBOX() ],
			protocol : new OpenLayers.Protocol.WFS({
				url : "http://localhost:8080/geoserver/wfs",
				featureType : "khachsan",
				featureNS : "http://opengeo.org/ws_cantho"
			}),
			styleMap: khach_san_styles

		});

		map.addLayer(khach_san);

		// build up all controls
		map.addControl(new OpenLayers.Control.PanZoomBar({
			position : new OpenLayers.Pixel(2, 15)
		}));
		map.addControl(new OpenLayers.Control.Navigation());
		map.addControl(new OpenLayers.Control.LayerSwitcher());
		map.addControl(new OpenLayers.Control.Scale($('scale')));
		map.addControl(new OpenLayers.Control.MousePosition({
			element : $('location')
		}));

		//map.addControl(select_control);

		map.zoomToExtent(bounds);

		map.events.register('click', map, function(e) {
			//document.getElementById('nodelist').innerHTML = "Loading... please wait...";
			var params = {
				REQUEST : "GetFeatureInfo",
				EXCEPTIONS : "application/vnd.ogc.se_xml",
				BBOX : map.getExtent().toBBOX(),
				X : e.xy.x,
				Y : e.xy.y,
				INFO_FORMAT : 'application/vnd.ogc.gml',
				QUERY_LAYERS : map.layers[0].params.LAYERS,
				FEATURE_COUNT : 10,
				Layers : 'ws_cantho:uyban',
				Styles : '',
				Srs : 'EPSG:4326',
				WIDTH : map.size.w,
				HEIGHT : map.size.h,
				format : format
			};

			OpenLayers.loadURL("http://localhost:8080/geoserver/wms", params,
					this, setHTML, setHTML);
			OpenLayers.Event.stop(e);

		});

		map.zoomToExtent(bounds);
	}//ket thuc function init()

	//Build others functions
	// sets the HTML provided into the nodelist element

	function setHTML(response) {
		var gmlResponse = new OpenLayers.Format.GML({
			extractAttributes : true
		}).read(response.responseText);
		//alert(response.responseText);
		var a = gmlResponse[0].attributes;
		//alert ("Attributes: "+a['gid']+' - '+a['ma_cho']+' - '+a['ten_cho']);
		//alert ("bounds: "+gmlResponse[0].bounds);
		var geopoint = gmlResponse[0].geometry;
		//alert(geopoint.toString()+'-area: '+geopoint.calculateBounds());
		//tao Popup tai dia diem duoc chon, void thong tin lien quan
		
		var content = "<h2>" + a['ten'] + "</h2></br> Vị trí: "
				+ geopoint.x + ":" + geopoint.y;
		popup = new OpenLayers.Popup.FramedCloud("chicken",
				new OpenLayers.LonLat(geopoint.x, geopoint.y), null, content,
				null, true);

		map.addPopup(popup, true);
	
		//alert(a['ten_cho']);
	};

	function onPopupClose() {
		//xoa pop o day
	}
	function onFeatureSelect() {
		alert("Select");
	}
	function onFeatureUnSelect() {
		alert("Unselect");
	}
</script>
</script>

</head>
<body onLoad="init()">
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