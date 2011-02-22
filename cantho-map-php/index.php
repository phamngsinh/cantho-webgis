<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bản đồ thành phố cần thơ </title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/tabs.css" type="text/css" rel="stylesheet">
<script src="js/event.js" language="javascript"></script>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script src="libs/jquery/jquery-1.4.4.js" language="javascript"></script>
<script src="libs/jquery/jquery.tools.min.js" language="javascript"></script>
<style>
/* tab pane styling */
* {
    margin: 0;
    padding: 0;
}
img, input {
    border: 0 none;
}
.panes panes-div {
	 display:none;
	 padding:5px 5px;
	 border:1px solid #999;
	 border-top:0;
	 height:100%;
	 font-size:14px;
	 background-color:#fff;
	 position:absolute;
	 width:100%;
	 background-color:#FF00CC;
} 
.panes  {
	margin-top:0px;
	position:absolute;
	width:100%;
	height:100%;
}
.tabs {  
	margin:0 !important; 
	padding:0;
	height:30px;
	border-bottom:1px solid #666;	 	
}
.tabs li {  
	float:left;	 
	padding:0; 
	margin:0;  
	list-style-type:none;	
}
.tabs a { 
	float:left;
	font-size:13px;
	display:block;
	padding:5px 15px;	
	text-decoration:none;
	border:1px solid #666;	
	border-bottom:0px;
	height:18px;
	background-color:#efefef;
	color:#777;
	margin-right:1px;
	position:relative;
	top:1px;	
	outline:0;
	-moz-border-radius:4px 4px 0 0;	
}
.tabs a.current {
	background-color: #FF9900;
	border-bottom:1px solid #ddd;	
	color:#000;	
	cursor:default;
}
.swrap-timduong {
    margin: 0 10px;
    padding: 5px 8px 0;
	height:30px;
}
.a-z {
    -moz-user-select: none;
    background: url("images/Pins.png") no-repeat scroll left top transparent;
    color: #154600;
    display: block;
    font-size: 10px;
    font-weight: bold;
    height: 29px;
    padding: 6px 6px 0 0;
    text-align: center;
    text-shadow: 0 1px #B4DC34;
    text-transform: uppercase;
    width: 26px;
	position:absolute;
	margin-top:-4px;
}
.boxtimduong {
    -moz-border-radius: 5px 5px 5px 5px;
    background: url("images/bg_s_top.png") repeat-x scroll 0 -1px transparent;
    border: 1px solid #C1C1C1;
    color: #333333;
    font-family: Tahoma,Verdana,Arial,Geneva,sans-serif;
    font-size: 12px;
    height: 16px;
    left: 52px;
    padding: 3px 23px 4px 6px;
    position: absolute;
    width: 180px;
}
.del-timduong {
    background: url("images/del.png") no-repeat scroll 0 0 transparent;
    height: 16px;
    left: 263px;
    position: absolute;
    text-indent: -9999px;
    width: 23px;
}

.btn-timduong {
    background: url("images/search.png") no-repeat scroll 0 0 transparent;
    display: block;
    height: 13px;
    left: 267px;
    position: absolute;
	text-indent: -9999px;
    width: 13px;
	cursor:pointer;
	margin-top:5px;
}
.direction-item {
    position: relative;
}
#listDirection {
    height: 100%;
    position: absolute;
    width: 100%;
	padding-top:10px;
}
#header {
	top:0;
	left:300px;
    height: 100%;
    margin: 0 auto;
    position: absolute;
    width: 650px;
}
#search {
    left: 129px;
    position: absolute;
    top:5px;
}
.SLeft {
    background: url("images/SLeft.png") no-repeat scroll 0 0 transparent;
    float: left;
    height: 47px;
    width: 7px;
}
.SCenter {
    background: url("images/bg-SCenter.png") repeat-x scroll 0 0 transparent;
    float: left;
    padding: 10px 4px;
}
.SBox {
    background: url("images/bg-SBox.png") repeat-x scroll 0 0 transparent;
    height: 27px;
    width: 483px;
}
.SBoxLeft {
    background: url("images/SBoxLeft.png") no-repeat scroll 0 0 transparent;
    float: left;
    height: 27px;
    width: 7px;
}
.AvimOff {
    background: url("images/bogo.png") no-repeat scroll left top transparent;
    cursor: pointer;
    float: left;
    height: 17px;
    margin-top: 5px;
    width: 17px;
}
.SText {
    background: none repeat scroll 0 0 transparent;
    color: #111111;
    float: left;
    font-family: Tahoma,Verdana,Geneva,sans-serif;
    font-size: 12px;
    height: 14px;
    padding: 6px;
    text-decoration: none;
    width: 342px;
}
.keyboardInputInitiator {
    cursor: pointer;
    float: left;
    margin: 6px 5px 0;
    vertical-align: middle;
}
.SHelpClose, .SHelpOpen {
    display: block;
    float: left;
    font-size: 0;
    height: 17px;
    line-height: 0;
    margin: 5px 0 0;
    width: 17px;
}
.SHelpClose a, .SHelpOpen a {
    background: url("images/SHelp0.png") no-repeat scroll 0 0 transparent;
    float: left;
    height: 17px;
    text-indent: -9999px;
    width: 17px;
}
.SButton {
    background: url("images/btn-search.png") no-repeat scroll 0 0 transparent;
    color: #254401;
    cursor: pointer;
    float: right;
    font-family: Tahoma,Verdana,Geneva,sans-serif;
    font-size: 12px;
    height: 27px;
    padding: 6px 0 7px;
    text-decoration: none;
    text-shadow: 0 1px 0 #DDEA8F;
    width: 56px;
}
.SHelpDiv {
    -moz-border-radius-bottomleft: 10px;
    -moz-border-radius-bottomright: 10px;
    -moz-box-shadow: 0 0 5px #333333;
    background-color: #F0F0F0;
    border: 1px solid #C1C1C1;
    color: #111111;
    display: none;
    font-size: 12px;
    left: 18px;
    overflow: hidden;
    position: absolute;
    top: 37px;
}
.SRight {
    background: url("images/SRight.png") no-repeat scroll 0 0 transparent;
    float: left;
    height: 47px;
    width: 7px;
}
.SWTrans {
    float: left;
    left: 0;
    position: relative;
    top: -10px;
}
.boundTree {
    background: url("images/SWTrShadow.png") repeat scroll 0 0 transparent;
    display: inline-block;
    overflow: hidden;
    position: relative;
    width: 489px;
}
#Tree {
    background: -moz-linear-gradient(center top , #F6F6F6, #FFFFFF) repeat scroll 0 0 #F6F6F6;
    color: #333333;
    display: none;
    font-family: Tahoma,Verdana,Geneva,sans-serif;
    height: 0;
    overflow: auto;
    width: 473px;
}
.SWRight-bgShadow {
    background: url("images/s-shadow.png") no-repeat scroll right bottom transparent;
    left: -4px;
    padding: 0 4px 7px;
    position: relative;
}
.SWRight-bg {
    background: url("images/SWRight-bg.png") no-repeat scroll right bottom transparent;
    display: inline-block;
    height: 10px;
    width: 505px;
}
.SWCenter-bg {
    background: url("images/SWCenter-bg.png") repeat-x scroll center bottom transparent;
    height: 10px;
    margin-right: 7px;
}
.SWLeft {
    background: url("images/SWLeft.png") no-repeat scroll left top transparent;
    display: inline-block;
    height: 31px;
    position: absolute;
}
.SWRight {
    background: url("images/SWRight.png") no-repeat scroll right top transparent;
    height: 31px;
}
.SWCenter-bg {
    background: url("images/SWCenter-bg.png") repeat-x scroll center bottom transparent;
    height: 10px;
    margin-right: 7px;
}
.SWContent {
    background: url("images/bg-SW.png") repeat-x scroll center top transparent;
    height: 31px;
    margin: 0 18px 0 6px;
    position: relative;
}
a {
    cursor: pointer;
    outline-style: none;
}
.SWBut {
    background: url("images/bg-SWBut.png") no-repeat scroll right center transparent;
    bottom: 0;
    float: left;
    height: 23px;
    position: relative;
    width: 51px;
}
.SWBut a {
    -moz-user-select: none;
    color: #FFFFFF;
    display: block;
    font-size: 11px;
    padding: 4px 0 2px 4px;
    text-shadow: 0 1px 0 #005AE7;
}
.SWBut a:hover {
    background: url("images/bg-SWBut-hover.png") no-repeat scroll 4px 3px transparent;
    text-shadow: 0 1px 0 #000000;
}
#TreeFilter {
    color: #FFFFFF;
    display: inline;
    float: left;
    font-size: 9px;
    padding: 4px 0 0 9px;
    white-space: normal;
}
#TreeFilter a {
    -moz-user-select: none;
    color: #FFFFFF;
    font-size: 11px;
}
.SWCloseArea {
    background: url("images/closeArea.png") no-repeat scroll 0 0 transparent;
    display: block;
    height: 8px;
    position: absolute;
    right: 6px;
    top: 6px;
    width: 8px;
}

</style>
<script>
function OnblurTextBoxAB(a){
	a=$(a);
	var b=a.parent().parent()[0].id;
	var c=parseInt(b.substring(9,b.length));
	if(a.val()==""){
		a.val("Nhập vào địa danh, địa chỉ...")
	}
}
function OnforcusTextBoxAB(a){
			a=$(a);
			//if(a.val()==inputDirHelp){
				a.val("");
			//}
			HideSelectPlaceBox();
			prev_selectedResAB_Text=selectedResAB_Text=a.val()
}
function HideSelectPlaceBox(){
		$("#SelectPlace").css("display","none")
}
function moveIconClick(){
  alert($("#left_content").css("left").replace("px",""));
	if($("#left_content").css("left").replace("px","")<0){
		shrinkMap()
		}
	else{
		expandMap()
	}
}
function expandMap(){
	
	var a=document.getElementById("right_content");
	a.style.left="5px";
	a.style.width="100%";
	
	$("#left_content").stop().animate({left:-350},350,"linear");
	//alert("expandMap");
	$("#centerSplit").stop().animate({left:-2},350,"linear",function(){
																	 $("#"+activeElementID).attr("class","active3");
																	 $("#moveicon").attr("class","moveicon-out")
															}
									)
									//map.checkResize();
}
function shrinkMap(){
	alert("shrinkMap");
	if($("#moveicon")[0].className=="moveicon-out"){
		$("#"+activeElementID).attr("class","active2");
		$("#moveicon").attr("class","moveicon");
		$("#left_content").stop().animate({left:0},350,"linear");
		$("#centerSplit").stop().animate({left:343},350,"linear",function(){});
		setTimeout(function(){
							var a=document.getElementById("right_content");
							a.style.left="352px";
							a.style.width=myWidth-a.offsetLeft+"px";
							map.checkResize()
					         },350)
	}
}
  
</script>



<script type="text/javascript" src="libs/jquery/contextmenu/jquery.contextMenu.js"></script>
<link type="text/css" rel="stylesheet" href="libs/jquery/contextmenu/jquery.contextMenu.css"></link>
<script type="text/javascript" src="libs/web/DrawPoints.js"></script>
<script type="text/javascript" defer="defer">
	
	$(document).ready(function(){
							   $("#map").contextMenu({menu:'myMenu'},
													 function(action,el,pos){contextMenuWork(action,el,pos);}
													 );
							   
							   function contextMenuWork(action,el,pos)
							   {
									switch(action)
									{
										case "tu_day":
										{
											//alert("action firstpoint at position: X="+pos.x+': y='+pos.y+'\n'+'Element ID: '+$(el).attr('id'));
											/*create marker for first point*/											
											var pixel= new OpenLayers.Pixel(pos.x,pos.y);											
											alert('position: '+pixel);
											var lonlat = map.getLonLatFromViewPortPx(pixel);
																																	
											break;
										}
										case "den_day":
										{
											break;
										}										
									}
							   }
							   
							   });//end $(document).ready(function()
	
	
	function init()
	{
		//KHAI BAO MARKER
		var SHADOW_Z_INDEX = 10;
		var MARKER_Z_INDEX = 11;
		var DIAMETER = 200;
		var NUMBER_OF_FEATURES = 15;
		var map;
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
		truong = new OpenLayers.Layer.WMS(
					 "truong",
					 "http://localhost:8080/geoserver/wms",
					 {
						 layers: 'ws_cantho:truong',
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
		
		map.addLayers([quan_huyen,giao_thong,truong]);
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
<body  onload="init()">
 	<div class = "header_content" id = "header_content">
			<div id = "canthomap_logo" class = "canthomap_logo"> </div>
			<div id="header" style="z-index: 930;">
			<div id="search" style="z-index: 916;">
            	<div class="SLeft" style="z-index: 914;"></div>
                <div class="SCenter" style="z-index: 912;">
                	<div class="SBox" style="z-index: 910;">
                    	<div class="SBoxLeft" style="z-index: 908;"></div>
                        <script src="js/Avim.js" type="text/javascript"></script>
						
                        <input type="text" onblur="showInputTextHelp()" onfocus="inputTextClick()" 
						value="Tìm địa chỉ, dịch vụ và số điện thoại..." id="mapinput" class="SText keyboardInput" name="mapinput">
						<img class="keyboardInputInitiator" src="images/keyboard.png" style="z-index: 906;">
                        <div class="SHelpClose" id="s-help" style="z-index: 904;"><a onclick="LoadHelp()">Ví dụ</a></div>
                        <input type="submit" onclick="return doSearch()" value="Tìm" class="SButton">
                    </div>
                    <div class="SHelpDiv" onclick="clickHelp()" id="HelpDiv" style="z-index: 902;">
                    	<div class="SHelpDiv-div" style="z-index: 900;">
                            <h3>Ví dụ tìm kiếm</h3>
                            <a href="/Maps/Help/Web.aspx" target="_blank" class="btn-xemthem">Xem thêm...</a>
                            <ul class="SHelpDiv-div-ul" style="z-index: 898;">
                                <li class="favicon">Tìm vị trí:
                                    <ul style="z-index: 896;">
                                        <li><a onclick="MapExampleClick('hn')" id="hn">Hà Nội</a></li>
                                        <li><a onclick="MapExampleClick('q1')" id="q1">Quận 1, TPHCM</a></li>
                                        <li><a onclick="MapExampleClick('nvc')" id="nvc">Nguyễn Huệ, TPHCM</a></li>
                                        <li><a onclick="MapExampleClick('gl')" id="gl">Giao lộ Cách Mạng Tháng Tám &amp; Nguyễn 
                                            Đình Chiểu</a></li>
                                        <li><a onclick="MapExampleClick('ll')" id="ll">10.775659, 106.702351</a></li>
                                        <li><a onclick="MapExampleClick('dg')" id="dg">10°46'32.376", 106°42'8.4672"</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm xung quanh vị trí:
                                    <ul style="z-index: 894;">
                                        <li><a onclick="MapExampleClick('nhgks')" id="nhgks">Nhà hàng gần Khách sạn 
                                            Caravelle</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm địa chỉ:
                                    <ul style="z-index: 892;">
                                    	<li><a onclick="MapExampleClick('hvb')" id="hvb">31A Huỳnh Văn Bánh, Quận Phú Nhuận, 
                                            TPHCM</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm số điện thoại:
                                    <ul id="ullasthelp" style="z-index: 890;">
                                        <li>Vietbando: <a onclick="MapExampleClick('dt39956665')" id="dt39956665">39956665</a></li>
                                        <li>Khách sạn Rex: <a onclick="MapExampleClick('dt38293115')" id="dt38293115">
                                            38293115</a></li>
                                    </ul>
                                </li>
                            </ul>
                    	</div>
                        <a onclick="UnLoadHelp()" class="close">Close</a>
                    </div>
                </div>
                <div class="SRight" style="z-index: 888;"></div>
                <div onclick="clickTree()" class="SWTrans" style="z-index: 886;">
                	<div class="boundTree" id="boundTree" style="z-index: 884;">
                    	<div id="Tree" style="overflow: auto; z-index: 882;"></div>
                        <div class="SW-img" style="z-index: 880;"></div>
                    </div>
                    <div class="SWRight-bgShadow" style="z-index: 878;">
                        <div class="SWRight-bg" style="z-index: 876;">
                            <div class="SWCenter-bg" style="z-index: 874;">
                            	<div class="SWLeft" style="z-index: 872;">
                                    <div class="SWRight" style="z-index: 870;">
                                        <div class="SWContent" style="z-index: 868;">
                                            <div class="SWBut" style="z-index: 866;"><a onclick="LoadTree()">Tìm ở</a></div>
                                            <div id="TreeFilter" style="z-index: 864;"><div style="display: inline; white-space: normal; z-index: 862;" id="map_path_div"><a onclick="TreeBinding.NavigatorClick(event,0,'Việt Nam','VN')">Cần Thơ</a></div></div>
                                            <br style="clear: both;">
                                        </div>
                                        <a onclick="TreeBinding.ResetTree()" style="display: none;" class="SWCloseArea"></a>
                                    </div>
                            	</div>
                            </div>
                        </div>
                	</div>
                </div>
            </div>
			</div>
			<div id="login">	
					<a href="#" class="a_help" id="a_help">Hướng dẫn </a>	&nbsp;|	
					<a href="#" class="a_login" id="a_login">Đăng nhập </a>				
			</div>	
			<div id="centerSplit1" class="splExpand1">
            <a id="moveicon1" class="moveicon1" onclick="moveIconClick1()"></a>
        	</div>		
	</div>                
	<div class = "left_content"  id = "left_content"> 
		<div class = "left_top_content" id = "left_top_content">
		<script>
		$(function() {
 				$(".tabs").tabs(".panes > div",{
			effect: 'fade',
			fadeOutSpeed: "slow",
			rotate: true});
			});		
		</script>
			<ul class="tabs">
				<li><a href="#">Tìm đường</a></li>
				<li><a href="#">Tìm địa điểm</a></li>
				<li><a href="#">Tìm dịch vụ</a></li>
			</ul>
			
			<!-- tab "panes" -->
			<div class="panes">
				<div class= "panes-div">
					<div id="listDirection">
						<div class="direction-item" id="direction0">
							<div class="swrap-timduong">
								<span class="a-z">a</span>
								<input type="text" value="Nhập vào địa danh, địa chỉ..." 
								onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" 
								onkeydown="return SearchPlaceEnter(event,0)" class="boxtimduong timduong-default">
								<a onclick="ClickRemovePlaceButton(this)" class="del-timduong" style="display: none;">
								Xóa</a>
								<a onclick="doSearchPlace(0)" class="btn-timduong" id="btnSearchPlace0">Tìm</a>
							</div>
							<div id="guide0"></div>
						</div>
						<div class="direction-item" id="direction1">
								<div class="swrap-timduong">
									<span class="a-z">b</span>
									<input type="text" value="Nhập vào địa danh, địa chỉ..." onblur="OnblurTextBoxAB(this)" 
									onfocus="OnforcusTextBoxAB(this)" onkeydown="return SearchPlaceEnter(event,1)" 
									class="boxtimduong timduong-default">
									<a onclick="ClickRemovePlaceButton(this)" class="del-timduong" style="display: none;">
									Xóa</a>
									<a onclick="doSearchPlace(1)" class="btn-timduong" id="btnSearchPlace1">Tìm</a>
								</div>
								<div id="guide1"></div>
						 </div>
					</div>
				</div>
				<div class= "panes-div"></div>
				<div class= "panes-div"></div>
			</div>	
		</div>	
		<div class = "left_bottom_content" id = "left_bottom_content">		</div>
		<div class="splExpand" id="centerSplit">
            <a onclick="moveIconClick()" class="moveicon" id="moveicon"></a>
        </div>
	</div>

	<div class = "right_content" id = "right_content"> 
   		<div class = "right_top_content" id = "right_top_content">
		<div style="background: url('images/reverse.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">&nbsp;</a></div>
			<div style="background: url('images/printIcon.gif') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">&nbsp;</a></div>
			<div style="background: url('images/ZoomIn.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">&nbsp;</a>			</div>
			<div style="background: url('images/ZoomOut.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">&nbsp;</a>			</div>		
		</div>
		<div class = "right_middle_content" id = "map"> </div>
		<div id="wrapper"></div>
		<div id="location"></div>
		<div id="scale"></div>
		<!-- Right Click Menu -->
		<ul id="myMenu" class="contextMenu">    
			<li class="tu_day"><a href="#tu_day">Từ đây</a></li>
			<li class="den_day"><a href="#den_day">Đến đây</a></li>            
		</ul>
		<div class = "right_bottom_content" class = "right_bottom_content">
					<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Cơ Quan</a>
					</div>
					<div style="background: url('images/hospital.gif') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Bệnh Viện</a>			
					</div>
					<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Khách Sạn</a>			
					</div>
					<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Trường Học</a>			
					</div>
						<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Công Ty</a>			
					</div>
					<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Chợ</a>			
					</div>
					
					<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_title">
						<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
					</div>
					<div class="taskbar_vip">
						<div style="margin-left: 40px; margin-right: 3px;">
							<marquee scrolldelay="1" scrollamount="1" behavior="scroll" onmouseout="this.start();" onmouseover="this.stop();">
								<a title="" href="http://vinhlonginfo.com/ads/category/7/detail/1002" 
								class="menu_taskbar">• QUAN NINH KIEU</a>
								<a title="" href="http://vinhlonginfo.com/ads/category/30/detail/986" 
								class="menu_taskbar">• QUAN BINH THUY</a>
								<a title="" href="http://vinhlonginfo.com/ads/category/26/detail/405" 
								class="menu_taskbar">• QUAN CAI RANG</a>
							</marquee>
						</div>
					</div>
		</div>
	</div>
		<!--div class = "right_right_content" class = "right_right_content">
		
		</div-->
</body>
</html>
