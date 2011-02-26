<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bản Đồ Thành Phố Cần Thơ</title>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script src="libs/jquery/jquery-1.4.4.js" language="javascript"></script>
<script src="libs/jquery/jquery.tools.min.js" language="javascript"></script>
<script type="text/javascript" src="js/map.js"></script>
<script type="text/javascript" src="js/events.js"></script>
<script type="text/javascript" src="js/services.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css"></link>
<link type="text/css" rel="stylesheet" href="css/bottom_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/header_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/left_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/center_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/right_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/popup.css"></link>
<script type="text/javascript" defer="defer">
$(document).ready(function() {
	// Code that uses jQuery's $ can follow here.
	// alert('hoang');
	$("#btn_getduongdi").click(function() {
		alert("sss");
		// alert("Bat dau goi webservice");
		var x1 = $("#txt_x1").val();
		var y1 = $("#txt_y1").val();
		var x2 = $("#txt_x2").val();
		var y2 = $("#txt_y2").val();
		callService(x1, y1, x2, y2);
	});
	$("#btn_reset").click(function() {
		// alert("Reset");
		reset_DuongDi();
	});
	$("#chk_timduong").click(function() {
		// kich hoat control ve diem chon
		checked = $("#chk_timduong").attr("checked");
		if (checked == true) {
			// alert("Activate olDrawFeature, Deactivate olNavigation");
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].deactivate();
				}
			}

		} else {
			// alert("Deactivate olDrawFeature, Activate olNavigation");
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].deactivate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].deactivate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}
			}
		}
	});
});
function moveIconClick(){
	  //alert($("#left_content").css("left").replace("px",""));
		if($("#left_content").css("left").replace("px","")<0){
			$("#left_content").stop().animate({left:0},350,"linear");
			}
		else{
			$("#left_content").stop().animate({left:-295},350,"linear");
		}
	}
	
function OnblurTextBoxAB(a){
	a=$(a);
	var b=a.parent().parent()[0].id;
	var c=parseInt(b.substring(9,b.length));
	if(a.val()==""){
		a.val("Nhập vào địa danh...")
	}
}
function OnforcusTextBoxAB(a){
			a=$(a);
			a.val("");
			prev_selectedResAB_Text=selectedResAB_Text=a.val();
}
</script>
</head>
<body onload="init()">
<div class="header" id="header"></div>
<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>
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
			<div class="panes">
				<div class= "panes-div">
					<div id="listDirection">
						<div class="direction-item" id="direction0">
							<div class="swrap-timduong">
								<span class="a-z">a</span>
								<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong timduong-default">
								<a onclick="" class="del-timduong" style="display: none;"> Xóa</a>
								<a class="btn-timduong" id="">Tìm</a>
							</div>
						</div>
						<div class="direction-item" id="direction1">
								<div class="swrap-timduong">
									<span class="a-z">b</span>
									<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong timduong-default">
									<a onclick="" class="del-timduong" style="display: none;">Xóa</a>
									<a class="btn-timduong" id="">Tìm</a>
								</div>
						</div>
					</div>
				</div>
				<div class= "panes-div"></div>
				<div class= "panes-div"></div>
			</div>	
		</div>	
		<div class = "left_bottom_content" id = "left_bottom_content">		</div>
		<div class="splExpand" id="centerSplit">
            <a onclick="moveIconClick()" class="moveicon" id="moveicon"></a>        </div>
	</div>
<div class = "map" id = "map"> 

</div>
<div class = "right_content"  id = "right_content"> 
	<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_right">
				<a href=#" onclick="" class="menu_taskbar">Cơ Quan</a>
	</div>
	<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_right">
				<a href="#" onclick="" class="menu_taskbar">Khách Sạn</a>			
	</div>
	<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Trường Học</a>			
	</div>
	<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Công Ty</a>			
	</div>
	<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Chợ</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
    </div>
    	<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_right">
				<a href=#" onclick="" class="menu_taskbar">Cơ Quan</a>
	</div>
	<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_right">
				<a href="#" onclick="" class="menu_taskbar">Khách Sạn</a>			
	</div>
	<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Trường Học</a>			
	</div>
	<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Công Ty</a>			
	</div>
	<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Chợ</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
    </div>
    <div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
    </div>
    <div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Chợ</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
    </div>
    <div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
    </div>
	
</div>
<div class = "bottom_content" class = "bottom_content">
			<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href=#" onclick="" class="menu_taskbar">Cơ Quan</a>
			</div>
			<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Khách Sạn</a>			
			</div>
			<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Trường Học</a>			
			</div>
			<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Công Ty</a>			
			</div>
			<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Chợ</a>			
			</div>		
			<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Bến Tàu Xe</a>			
			</div>
			<input id="chk_timduong" type="checkbox" />
	</div>
<!--  label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />-->
</body>
</html>