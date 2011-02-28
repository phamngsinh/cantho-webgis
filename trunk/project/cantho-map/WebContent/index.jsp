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
<script type="text/javascript" src="js/popup.js"></script>
<script type="text/javascript" src="js/effect.js"></script>
<script type="text/javascript" src="js/functions.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css"></link>
<link type="text/css" rel="stylesheet" href="css/bottom_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/header_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/left_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/center_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/right_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/popup.css"></link>
<script type="text/javascript" defer="defer">

</script>
</head>
<body onload="init()">
<div class="header" id="header"></div>
<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>
<div class = "map" id = "map"> </div>
<div class = "left_content"  id = "left_content"> 
		<div class = "left_top_content" id = "left_top_content">	
			<ul class="tabs">
				<li><a href="#">Tìm đường</a></li>
				<li><a href="#">Tìm địa điểm</a></li>
				<li><a href="#">Tìm dịch vụ</a></li>
			</ul>
			<div class="panes">
				<div class= "panes-div body-find-path">
					<div id="listDirection">
						<div class="direction-item" id="direction0">
							<div class="swrap-timduong">
								<span class="a-z">a</span>
								<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong timduong-default">
								<a onclick="" class="del-timduong" style="display: none;"> Xóa</a><a class="btn-timduong searchA" id="">Tìm</a>
							</div>
						</div>
						<div class="direction-item" id="direction1">
								<div class="swrap-timduong">
									<span class="a-z">b</span>
									<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong timduong-default">
									<a onclick="" class="del-timduong" style="display: none;">Xóa</a><a class="btn-timduong search1" id="">Tìm</a>
								</div>
						</div>
						<div class="search-result"></div>
					</div>
				</div>
				<div class= "panes-div">
				
				</div>
				<div class= "panes-div"></div>
			</div>	
		</div>	
		<div class = "left_bottom_content" id = "left_bottom_content">		</div>
		<div class="splExpand" id="centerSplit">
            <a onclick="moveIconClick()" class="moveicon" id="moveicon"></a>        </div>
	</div>
<div class = "right_content"  id = "right_content"> 				
	<div style="background:  url('images/hotel.png') no-repeat scroll left center #FFDB69;" class="taskbar_right">
		<a  id = "coquan" href="#" class="menu_taskbar coquan"  onclick="" onmouseover= "blinklink_coquan()" onmouseout= "stoptimer_coquan()">Cơ Quan</a>			
	</div>
	<div style="background: url('images/school.png') no-repeat scroll left center #FFDB69;" class="taskbar_right">
		<a id = "truonghoc"  href="#" onclick=""  class="menu_taskbar truonghoc" onmouseover= "blinklink_truonghoc()" onmouseout= "stoptimer_truonghoc()">Trường Học</a>			
	</div>
	<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "benhvien" href="#" onclick="" class="menu_taskbar benhvien" onmouseover= "blinklink_benhvien()" onmouseout= "stoptimer_benhvien()" >Bệnh Viện</a>			
	</div>
	<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "cho" href="#" onclick="" class="menu_taskbar cho"  onmouseover= "blinklink_cho()" onmouseout= "stoptimer_cho()" >Chợ</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "bentauxe" href="#" onclick="" class="menu_taskbar bentauxe"  onmouseover= "blinklink_bentauxe()" onmouseout= "stoptimer_bentauxe()" >Bến Tàu Xe</a>			
    </div>
    <div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "khachsan" href=#" onclick="" class="menu_taskbar khachsan "  onmouseover= "blinklink_khachsan()" onmouseout= "stoptimer_khachsan()" >Khách Sạn</a>
	</div>
	<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "congty" href="#" onclick="" class="menu_taskbar congty"  onmouseover= "blinklink_congty()" onmouseout= "stoptimer_congty()" >Công Ty</a>			
	</div>
	<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "giaitri" href="#" onclick="" class="menu_taskbar giaitri"  onmouseover= "blinklink_giaitri()" onmouseout= "stoptimer_giaitri()" >Giải Trí</a>			
	</div>
	<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "denchua" href="#" onclick="" class="menu_taskbar denchua"  onmouseover= "blinklink_denchua()" onmouseout= "stoptimer_denchua()" >Đền Chùa</a>			
	</div>
	<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "truyenthong" href="#" onclick="" class="menu_taskbar truyenthong"  onmouseover= "blinklink_truyenthong()" onmouseout= "stoptimer_truyenthong()" >Truyền Thông</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "nganhang" href="#" onclick="" class="menu_taskbar nganhang"  onmouseover= "blinklink_nganhang()" onmouseout= "stoptimer_nganhang()" >Ngân Hàng</a>			
    </div>
    <div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "congvien" href="#" onclick="" class="menu_taskbar congvien"  onmouseover= "blinklink_congvien()" onmouseout= "stoptimer_congvien()" >Công Viên</a>			
    </div>
    <div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "cau" href="#" onclick="" class="menu_taskbar cau"  onmouseover= "blinklink_cau()" onmouseout= "stoptimer_cau()" >Cầu</a>			
	</div>		
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "thuvien" href="#" onclick="" class="menu_taskbar thuvien"  onmouseover= "blinklink_thuvien()" onmouseout= "stoptimer_thuvien()" >Thư Viện</a>			
    </div>
    <div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_right">
		<a id = "khac" href="#" onclick="" class="menu_taskbar khac"  onmouseover= "blinklink_khac()" onmouseout= "stoptimer_khac()" >Khác</a>			
    </div>
	
</div>
<div class = "bottom_content" class = "bottom_content">
			<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href=#" onclick=""  class="menu_taskbar">Tìm đường</a>
			</div>
			<div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Tìm địa điểm</a>			
			</div>
			<div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Hướng dẫn</a>			
			</div>
			<div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">In bản đồ</a>			
			</div>
			<div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="javascript:doKhoangCach()" class="menu_taskbar">Đo khoảng cách</a>			
			</div>		
			<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_title">
				<a href="#" onclick="" class="menu_taskbar">Chọn vùng</a>			
			</div>
			<input id="chk_timduong" type="checkbox" />
	</div>
<!--  label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />-->
</body>
</html>