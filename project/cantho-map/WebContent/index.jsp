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
								<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong tim-a">
								<a onclick="" class="del-timduong" style="display: none;"> Xóa</a><a class="btn-timduong searchA" id="">Tìm</a>
							</div>
						</div>
						<div class="direction-item" id="direction1">
								<div class="swrap-timduong">
									<span class="a-z">b</span>
									<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong timduong-b">
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
		<table cellpadding="0" cellspacing="0"> 					
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "coquan"      href="#" onclick="" class="right-item coquan"       onmouseover= "blinklink_coquan()"      onmouseout= "stoptimer_coquan()"      >Cơ Quan</a>	    </td></tr>		
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "truonghoc"   href="#" onclick="" class="right-item truonghoc"    onmouseover= "blinklink_truonghoc()"   onmouseout= "stoptimer_truonghoc()"   >Trường Học</a>	</td></tr>			
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "benhvien"    href="#" onclick="" class="right-item benhvien"     onmouseover= "blinklink_benhvien()"    onmouseout= "stoptimer_benhvien()"    >Bệnh Viện</a>	</td></tr>			
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "cho"         href="#" onclick="" class="right-item cho"          onmouseover= "blinklink_cho()"         onmouseout= "stoptimer_cho()"         >Chợ</a>			</td></tr>	
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "bentauxe"    href="#" onclick="" class="right-item bentauxe"     onmouseover= "blinklink_bentauxe()"    onmouseout= "stoptimer_bentauxe()"    >Bến Tàu Xe</a>	</td></tr>			
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "khachsan"    href=#"  onclick="" class="right-item khachsan "    onmouseover= "blinklink_khachsan()"    onmouseout= "stoptimer_khachsan()"    >Khách Sạn</a>   </td></tr>	
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "congty"      href="#" onclick="" class="right-item congty"       onmouseover= "blinklink_congty()"      onmouseout= "stoptimer_congty()"      >Công Ty</a>		</td></tr>		
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "giaitri"     href="#" onclick="" class="right-item giaitri"      onmouseover= "blinklink_giaitri()"     onmouseout= "stoptimer_giaitri()"     >Giải Trí</a>	</td></tr>			
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "denchua"     href="#" onclick="" class="right-item denchua"      onmouseover= "blinklink_denchua()"     onmouseout= "stoptimer_denchua()"     >Đền Chùa</a>	</td></tr>			
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "truyenthong" href="#" onclick="" class="right-item truyenthong"  onmouseover= "blinklink_truyenthong()" onmouseout= "stoptimer_truyenthong()" >Truyền Thông</a></td></tr>				
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "nganhang"    href="#" onclick="" class="right-item nganhang"     onmouseover= "blinklink_nganhang()"    onmouseout= "stoptimer_nganhang()"    >Ngân Hàng</a>	</td></tr>			
   		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "congvien"    href="#" onclick="" class="right-item congvien"     onmouseover= "blinklink_congvien()"    onmouseout= "stoptimer_congvien()"    >Công Viên</a>	</td></tr>			
   		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "cau"         href="#" onclick="" class="right-item cau"          onmouseover= "blinklink_cau()"         onmouseout= "stoptimer_cau()"         >Cầu</a>			</td></tr>	
		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "thuvien"     href="#" onclick="" class="right-item thuvien"      onmouseover= "blinklink_thuvien()"     onmouseout= "stoptimer_thuvien()"     >Thư Viện</a>	</td></tr>			
   		<tr><td><a style="background:url('images/hotel.png') no-repeat scroll left center" id = "khac"        href="#" onclick="" class="right-item khac"         onmouseover= "blinklink_khac()"        onmouseout= "stoptimer_khac()"        >Khác</a>		</td></tr>		
		</table>
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