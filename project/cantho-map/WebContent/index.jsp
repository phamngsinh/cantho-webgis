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
<body onload="init();javascript:getQuanHuyen();">
<div class="header" id="header">
	<a class= 'a-logo' href='http://localhost:8888/cantho-map/index.jsp'><img class='image-logo' src="images/logo.png" /></a>
	<div id="search" style="z-index: 916;">            	
		    <div class="SLeft" style="z-index: 914;"></div>
            <div class="SCenter" style="z-index: 912;">
              	<div class="SBox" style="z-index: 910;">
                    <div class="SBoxLeft" style="z-index: 908;"></div>
                      <script src="js/Avim.js" type="text/javascript"></script>	
                     <input type="text" onblur="" onfocus="" 
					            value="" id="mapinput"
					            class="SText keyboardInput" name="mapinput">
						<img class="keyboardInputInitiator" src="images/keyboard.png" style="z-index: 906;">
                        <div class="SHelpClose" id="s-help" style="z-index: 904;"><a onclick="LoadHelp()">Ví dụ</a></div>
                        <input id = "btnTim" type="submit" value="Tìm" class="SButton">
                    </div>
                    <div class="SHelpDiv" onclick="clickHelp()" id="HelpDiv" style="z-index: 902;"><a onclick="UnLoadHelp()" class="close">Close</a></div>
                </div>
                <div class="SRight" style="z-index: 888;"></div>
                <div onclick="" class="SWTrans" style="z-index: 886;">
				    <div class="boundTree" id="boundTree" style="z-index: 884; padding: 8px; margin: 0px; border-bottom: 1px solid rgb(17, 99, 201); border-top: 1px solid rgb(0, 71, 124); display: none;">
	                 <div id="Tree" style="overflow: auto; z-index: 882; height: 180px; padding: 5px 7px; border: 1px solid rgb(204, 204, 204); display: block;">
	                    <div style="float: right;"><a onclick="HideMapList()" class="TreeClose">X</a></div>
		                <div style="padding: 0px 10px 10px;">
		                    <div class="dtree">
								<div class="dTreeNav" style="background: url('images/ThanhPhoCanTho.png') no-repeat scroll 0% 0% transparent;">
									<div id="map_path_div" style="display: inline; white-space: normal;" >
									<a class = "cantho">Cần Thơ</a>
									</div>
								</div>
								<div style="display: block;" class="clip" id="tree_Huyen">
								<!-- Se bo noi dung vao day -->
								</div>
						   </div>
					   </div>
					</div>
	                <div class="SW-img" style="z-index: 880;"></div>
	              </div>

                   <div class="SWRight-bgShadow" style="z-index: 878;">
                        <div class="SWRight-bg" style="z-index: 876;">
                            <div class="SWCenter-bg" style="z-index: 874;">
                            	<div class="SWLeft" style="z-index: 872;">
                                    <div class="SWRight" style="z-index: 870;">
                                        <div class="SWContent" style="z-index: 868;">
                                            <div class="SWBut" style="z-index: 866;"><a onclick="LoadTree()">Tìm ở</a></div>
                                            <div id="TreeFilter" style="z-index: 864;">
												<div style="display: inline; white-space: normal; z-index: 862;" id="map_path_div"><a onclick="TreeBinding.NavigatorClick(event,0,'Việt Nam','VN')">Cần Thơ</a></div>	
											</div>
                                            <br style="clear: both;">
                                        </div>
                                        <a onclick="" style="display: none;" class="SWCloseArea"></a>
                                    </div>
                            	</div>
                            </div>
                        </div>
                	</div>
                </div>
            </div>
</div>



<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>
<div class = "map" id = "map"> </div>
<div class = "left_content"  id = "left_content"> 
		<div class = "left_top_content" id = "left_top_content">	
			<ul class="tabs">
				<li><a href="#">Tìm đường</a></li>
				<li><a href="#">Tìm vị trí</a></li>
				<li><a href="#">Hướng dẫn</a></li>
			</ul>
			<div class="panes">
				<div class= "panes-div body-find-path">
					<div id="listDirection">
							<div class="swrap-timduong">
								<span class="a-z">a</span>
								<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong tim-a">
								<a onclick="" class="del-timduonga" style="display: block;"> Xóa</a><a class="btn-timduong searchA" id="">Tìm</a>
							</div>
							<a onclick="" title="Click vào đây để đảo chiều đường đi." class="btn-refresh" style="display: block;">dc</a>
							<div class="swrap-timduong">
								<span class="a-z">b</span>
								<input type="text" value="Nhập vào địa danh..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="" class="boxtimduong tim-b">
								<a onclick="" class="del-timduongb" style="display: block;">Xóa</a><a class="btn-timduong searchB" id="">Tìm</a>
							</div>
					</div>
					<div class="search-result"></div>
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
		<tr><td><a style="background:url('map-icon/coquan16.png') no-repeat scroll left center" id = "coquan"           href="javascript:getLopDiaDiem('coquan')"            class="right-item coquan"       onmouseover= "blinklink_coquan()"      onmouseout= "stoptimer_coquan()"      >Cơ Quan</a>	    </td></tr>		
		<tr><td><a style="background:url('map-icon/truonghoc.png') no-repeat scroll left center" id = "truonghoc"           href="javascript:getLopDiaDiem('truong')"            class="right-item truonghoc"    onmouseover= "blinklink_truonghoc()"   onmouseout= "stoptimer_truonghoc()"   >Trường Học</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/benhvien16.png') no-repeat scroll left center" id = "benhvien"       href="javascript:getLopDiaDiem('benhvien')"          class="right-item benhvien"     onmouseover= "blinklink_benhvien()"    onmouseout= "stoptimer_benhvien()"    >Bệnh Viện</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/cho16.png') no-repeat scroll left center" id = "cho"                 href="javascript:getLopDiaDiem('cho')"               class="right-item cho"          onmouseover= "blinklink_cho()"         onmouseout= "stoptimer_cho()"         >Chợ</a>			</td></tr>	
		<tr><td><a style="background:url('map-icon/ben16.png') no-repeat scroll left center" id = "bentauxe"            href="javascript:getLopDiaDiem('ben')"               class="right-item bentauxe"     onmouseover= "blinklink_bentauxe()"    onmouseout= "stoptimer_bentauxe()"    >Bến Tàu Xe</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/khachsan16.png') no-repeat scroll left center" id = "khachsan"       href="javascript:getLopDiaDiem('khachsan')"          class="right-item khachsan "    onmouseover= "blinklink_khachsan()"    onmouseout= "stoptimer_khachsan()"    >Khách Sạn</a>   </td></tr>	
		<tr><td><a style="background:url('map-icon/congty.png') no-repeat scroll left center" id = "congty"              href="javascript:getLopDiaDiem('congty')"            class="right-item congty"       onmouseover= "blinklink_congty()"      onmouseout= "stoptimer_congty()"      >Công Ty</a>		</td></tr>		
		<tr><td><a style="background:url('map-icon/giaitri16.png') no-repeat scroll left center" id = "giaitri"         href="javascript:getLopDiaDiem('giaitri')"           class="right-item giaitri"      onmouseover= "blinklink_giaitri()"     onmouseout= "stoptimer_giaitri()"     >Giải Trí</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/denchua16.png') no-repeat scroll left center" id = "denchua"         href="javascript:getLopDiaDiem('denchua')"           class="right-item denchua"      onmouseover= "blinklink_denchua()"     onmouseout= "stoptimer_denchua()"     >Đền Chùa</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/truyenthong16.png') no-repeat scroll left center" id = "truyenthong" href="javascript:getLopDiaDiem('truyenhinhbaochi')"  class="right-item truyenthong"  onmouseover= "blinklink_truyenthong()" onmouseout= "stoptimer_truyenthong()" >Truyền Thông</a></td></tr>				
		<tr><td><a style="background:url('map-icon/nganhang16.png') no-repeat scroll left center" id = "nganhang"       href="javascript:getLopDiaDiem('nganhang')"          class="right-item nganhang"     onmouseover= "blinklink_nganhang()"    onmouseout= "stoptimer_nganhang()"    >Ngân Hàng</a>	</td></tr>			
   		<tr><td><a style="background:url('map-icon/congvien16.png') no-repeat scroll left center" id = "congvien"       href="javascript:getLopDiaDiem('congvien')"          class="right-item congvien"     onmouseover= "blinklink_congvien()"    onmouseout= "stoptimer_congvien()"    >Công Viên</a>	</td></tr>			
   		<tr><td><a style="background:url('map-icon/cau.png') no-repeat scroll left center" id = "cau"                 href="javascript:getLopDiaDiem('cau')"               class="right-item cau"          onmouseover= "blinklink_cau()"         onmouseout= "stoptimer_cau()"         >Cầu</a>			</td></tr>	
		<tr><td><a style="background:url('map-icon/thuvien16.png')   no-repeat scroll left center" id = "thuvien"       href="javascript:getLopDiaDiem('thuvien')"           class="right-item thuvien"      onmouseover= "blinklink_thuvien()"     onmouseout= "stoptimer_thuvien()"     >Thư Viện</a>	</td></tr>
   		</table>
</div>
<div class = "bottom_content" class = "bottom_content">	
			<table><tr>
			<td class = 'tim-duong not-clicked'> <a href="javascript:timDuong()"   class="menu_taskbar">Tìm đường</a></td>			
			<td class = 'in-ban-do not-clicked'> <a href="javascript:inBanDo()"  class="menu_taskbar">In bản đồ</a></td>		
			<td class = 'do-khoang-cach not-clicked'> <a href="javascript:doKhoangCach()" class="menu_taskbar">Đo khoảng cách</a></td>			
		    <td class = 'chon-vung not-clicked'> <a href="javascript:getQuanHuyen()"  class="menu_taskbar">Chọn vùng</a></td>
			</tr></table>	
	</div>
<!--  label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />-->
</body>
</html>