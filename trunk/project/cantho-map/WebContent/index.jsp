<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bản Đồ Thành Phố Cần Thơ</title>
<link rel="icon" type="image/x-icon" href="images/icon-map.gif" />
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script src="libs/jquery/jquery-1.4.4.js" language="javascript"></script>
<script src="libs/jquery/jquery.tools.min.js" language="javascript"></script>
<script src="libs/jquery/jquery.watermark.js" language="javascript"></script>
<script type="text/javascript" src="js/styles.js"></script>
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
	<div id="search" style="z-index: 916;">            	
		    <div class="SLeft" style="z-index: 914;"></div>
            <div class="SCenter" style="z-index: 912;">
              	<div class="SBox" style="z-index: 910;">
                    <div class="SBoxLeft" style="z-index: 908;"></div>
                     <input type="text" onblur="" onfocus="" value="" id="mapinput"
					            class="SText keyboardInput" name="mapinput">
                        <input id = "btnTim" type="submit" value="Tìm" class="SButton">
                    </div>
                </div>
                <div class="SRight" style="z-index: 888;"></div>
                <div onclick="" class="SWTrans" style="z-index: 886;">
				    <div class="boundTree" id="boundTree" style="z-index: 884; padding: 8px; margin: 0px; border-bottom: 1px solid rgb(17, 99, 201); border-top: 1px solid rgb(0, 71, 124); display: none;">
	                 <div id="Tree" style="overflow: auto; z-index: 882; height: 180px; padding: 5px 7px; border: 1px solid rgb(204, 204, 204); display: block;">
	                    
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
	               	 <div class="div-TreeClose"><a title="Đóng" onclick="HideMapList()" class="TreeClose"></a></div>
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
												<div style="display: inline; white-space: normal; z-index: 862;" id="map_path_div2"><a onclick="getQuanHuyen()">Cần Thơ</a></div>	
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
    <div class = "flash-header">
		<object type="application/x-shockwave-flash"  data="images/header.swf" width="100%" height="100%">
                <param name="movie" value="images/header.swf" />
                <param name="quality" value="high"/>
                <param name="wmode" value="transparent"/>
            </object>
  </div>
</div>



<div id="wrapper"></div>
<div id="location"></div>
<div id="scale"></div>
<div class="kq-doKC" >
	<div class="kq-doKC-content" >
		<!-- label class= "kc-hienhanh">Khoang cach hien hanh : 0m</label-->
		<label class= "tong-kc">Tổng khoảng cách: </label>
		<label class= "tong-kc-m">0 km</label>
		<label class= "note-kc">Nhấp đúp để kết thúc việc đo.</label>
	</div>
</div>
<div class="div-dv-lt" >
		<table class="dv-content"> 
			<tr>
				<td>Tên</td>
				<td   class = 'tendv'><input id='txt_ten_lt' class = 'textdichvu' name='textdichvu' type='text' value='' /></td>
			</tr>
			<tr>
				<td>Bán kính</td>
				<td   class = 'bankinh' ><input id='txt_bk_lt' maxlength='10' class = 'textbankinh' name='textbankinh' type='text' value='' /> m </td>
			</tr>
		</table>
		<a href="javascript:closeDVLT()" class="close-dv-lt" style="display: block;"></a>
		<input class = 'btn-tim-dv' name='buttonTim' type='button' value='Tìm' onclick='timDichVuLoTrinh()'/>
</div>
<div class="div-tim-con-duong" >
		<table class="timcd-content"> 
			<tr>
				<td>Tên đường</td>
			</tr>
			<tr>
				<td   class = 'tencd'><input id='txt_ten_cd' class = 'textconduong' name='textconduong' type='text' value='' /></td>
			</tr>
		</table>
		<a href="javascript:closeTimConDuong()" class="close-tim-con-duong" style="display: block;"></a>
		<input class = 'btn-tim-duong' name='buttonTim' type='button' value='Tìm' onclick='timConDuongTheoTen()'/>
</div>
<div class = "map" id = "map">
	<div class = "loader-map" id = "loader_map">

 </div>
 </div>
<div class = "left_content"  id = "left_content"> 
		<div class = "left_top_content" id = "left_top_content">	
			<ul class="tabs">
				<li><a id="tab1" href="#">Tìm đường đi</a></li>
				<li><a id="tab2" href="#">Tìm vị trí</a></li>
				<li><a id="tab3" href="#">Tìm đường</a></li>
			</ul>
			<div class="panes">
				<div class= "panes-div body-find-path">
					<div id="listDirection">
							<div class="swrap-timduong">
								<span class="a-z">a</span>
								<input type="text"  onblur="" onfocus="" onkeydown="" class="boxtimduong tim-a">
								<a onclick="" class="del-timduonga" style="display: block;"> Xóa</a><a class="btn-timduong searchA" id="">Tìm</a>
							</div>
							<a onclick="" title="Click vào đây để đảo chiều đường đi." class="btn-refresh" href="javascript:daoChieu()" style="display: block;">dc</a>
							<div class="swrap-timduong">
								<span class="a-z">b</span>
								<input type="text"  onblur="" onfocus="" onkeydown="" class="boxtimduong tim-b">
								<a onclick="" class="del-timduongb" style="display: block;">Xóa</a><a class="btn-timduong searchB" id="">Tìm</a>
							</div>
					</div>	
					<div class="search-result"></div>
				</div>
				<div id="tab_content2" class= "panes-div">
				</div>
				<div id="tab_content3" class= "panes-div"></div>
			</div>	
		</div>	
		<div class = "left_bottom_content" id = "left_bottom_content">		</div>
		<div class="splExpand" id="centerSplit">
            <a onclick="moveIconClick()" class="moveicon" id="moveicon"></a>        </div>
	</div>
<div class = "right_content"  id = "right_content">
		<!--  table cellpadding="0" cellspacing="0"> 					
		<tr><td><a style="background:url('map-icon/coquan16.png') no-repeat scroll left center" id = "coquan"           href="javascript:getLopDiaDiem('coquan')"            class="right-item coquan"       onmouseover= "blinklink_coquan()"      onmouseout= "stoptimer_coquan()"      >Cơ Quan</a>	    </td></tr>		
		<tr><td><a style="background:url('map-icon/truonghoc.png') no-repeat scroll left center" id = "truonghoc"           href="javascript:getLopDiaDiem('truong')"            class="right-item truonghoc"    onmouseover= "blinklink_truonghoc()"   onmouseout= "stoptimer_truonghoc()"   >Trường Học</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/benhvien16.png') no-repeat scroll left center" id = "benhvien"       href="javascript:getLopDiaDiem('benhvien')"          class="right-item benhvien"     onmouseover= "blinklink_benhvien()"    onmouseout= "stoptimer_benhvien()"    >Bệnh Viện</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/cho16.png') no-repeat scroll left center" id = "cho"                 href="javascript:getLopDiaDiem('cho')"               class="right-item cho"          onmouseover= "blinklink_cho()"         onmouseout= "stoptimer_cho()"         >Chợ</a>			</td></tr>	
		<tr><td><a style="background:url('map-icon/ben16.png') no-repeat scroll left center" id = "bentauxe"            href="javascript:getLopDiaDiem('ben')"               class="right-item bentauxe"     onmouseover= "blinklink_bentauxe()"    onmouseout= "stoptimer_bentauxe()"    >Bến Tàu Xe</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/khachsan16.png') no-repeat scroll left center" id = "khachsan"       href="javascript:getLopDiaDiem('khachsan')"          class="right-item khachsan "    onmouseover= "blinklink_khachsan()"    onmouseout= "stoptimer_khachsan()"    >Khách Sạn</a>   </td></tr>	
		<tr><td><a style="background:url('map-icon/congty.png') no-repeat scroll left center" id = "congty"              href="javascript:getLopDiaDiem('congty')"            class="right-item congty"       onmouseover= "blinklink_congty()"      onmouseout= "stoptimer_congty()"      >Công Ty</a>		</td></tr>		
		<tr><td><a style="background:url('map-icon/giaitri16.png') no-repeat scroll left center" id = "giaitri"         href="javascript:getLopDiaDiem('giaitri')"           class="right-item giaitri"      onmouseover= "blinklink_giaitri()"     onmouseout= "stoptimer_giaitri()"     >Giải Trí</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/denchua16.png') no-repeat scroll left center" id = "denchua"         href="javascript:getLopDiaDiem('denchua')"           class="right-item denchua"      onmouseover= "blinklink_denchua()"     onmouseout= "stoptimer_denchua()"     >Đền Chùa</a>	</td></tr>			
		<tr><td><a style="background:url('map-icon/truyenthong16.png') no-repeat scroll left center" id = "truyenthong" href="javascript:getLopDiaDiem('buudien')"           class="right-item truyenthong"  onmouseover= "blinklink_truyenthong()" onmouseout= "stoptimer_truyenthong()" >Bưu Điện</a></td></tr>				
		<tr><td><a style="background:url('map-icon/nganhang16.png') no-repeat scroll left center" id = "nganhang"       href="javascript:getLopDiaDiem('nganhang')"          class="right-item nganhang"     onmouseover= "blinklink_nganhang()"    onmouseout= "stoptimer_nganhang()"    >Ngân Hàng</a>	</td></tr>			
   		<tr><td><a style="background:url('map-icon/congvien16.png') no-repeat scroll left center" id = "congvien"       href="javascript:getLopDiaDiem('congvien')"          class="right-item congvien"     onmouseover= "blinklink_congvien()"    onmouseout= "stoptimer_congvien()"    >Công Viên</a>	</td></tr>			
   		<tr><td><a style="background:url('map-icon/cau.png') no-repeat scroll left center" id = "cau"                 href="javascript:getLopDiaDiem('cau')"               class="right-item cau"          onmouseover= "blinklink_cau()"         onmouseout= "stoptimer_cau()"         >Cầu</a>			</td></tr>	
		<tr><td><a style="background:url('map-icon/thuvien16.png')   no-repeat scroll left center" id = "thuvien"       href="javascript:getLopDiaDiem('thuvien')"           class="right-item thuvien"      onmouseover= "blinklink_thuvien()"     onmouseout= "stoptimer_thuvien()"     >Thư Viện</a>	</td></tr>
   		</table-->
   		<object type="application/x-shockwave-flash"  data="images/left.swf" width="100%" height="100%">
                <param name="movie" value="images/left.swf" />
                <param name="quality" value="high"/>
                <param name="wmode" value="transparent"/>
            </object>
</div>
<div class = "bottom_content" class = "bottom_content">	
			<table><tr>
			 <td class = 'chon-vung not-clicked'> <a href="javascript:timConDuong()"  class="menu_taskbar">Tìm con đường</a></td>	
			<!-- td class = 'in-ban-do not-clicked'> <a href="javascript:inBanDo()"  class="menu_taskbar">In bản đồ</a></td-->		
			<td class = 'do-khoang-cach not-clicked'> <a href="javascript:doKhoangCach()" class="menu_taskbar">Đo khoảng cách</a></td>
			<td class = 'tim-duong not-clicked'> <a href="javascript:timDuong()"   class="menu_taskbar">Chọn điểm A,B</a></td>					
			</tr></table>
			<div class = "flash-footer">
				<object type="application/x-shockwave-flash"  data="images/footer.swf" width="100%" height="100%">
                	<param name="movie" value="images/footer.swf" />
                	<param name="quality" value="high"/>
                	<param name="wmode" value="transparent"/>
            	</object>
 	       </div>
			<!--  div class="taskbar_vip">
				<div>
				<marquee scrollamount="3" behavior="scroll" onmouseout="this.start();" onmouseover="this.stop();">
				<a title="" href="http://www.cit.ctu.edu.vn"> Lương Minh Liêm Pha - Trần Văn Hoàng - Luận Văn Tốt Nghiệp Đại Học. </a>
				</marquee>
				</div>
			</div-->	
	</div>
<!--  label>Tim Duong</label>
<input id="chk_timduong" type="checkbox" />
<input type="button" id="btn_getduongdi" value="Hien Thi" />
<input type="button" id="btn_reset" value="Reset" />-->
</body>
</html>