/**
 * 
 */
var timduong_clicked=0;
var dokhoangcach_clicked=0;
$(document).ready(function() {
	// Code that uses jQuery's $ can follow here.
	//alert('hoang');		
});
/*******************DINH NGHIA CHO CAC SU KIEN NHAN TREN CAC NUT TREN BOTTOM BAR*******************/
/*******Do Khoang Do Nguoi Duong Ve: ControlMeasure**********/
function timDuong(){
	//alert("Bat dau tim duong");
	timduong_clicked =1;
	dokhoangcach_clicked=0;
	$(".tim-duong").removeClass("not-clicked");
	$(".do-khoang-cach").removeClass("clicked");
	$(".tim-duong").addClass("clicked");
	$(".do-khoang-cach").addClass("not-clicked");
	var lop_duong_di = map.getLayersByName('lop_duong_di')[0];
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	if (num_points == 2){
		lop_duong_di.destroyFeatures();
		lop_diem_chon.destroyFeatures();
	}	
	if (control_ve_diem.active) {		
		//alert("Deactivate olDrawFeature, Activate olNavigation");
		//Xoa duong di va cac diem duoc ve tren lop_duong_di va lop_diem_chon
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}				
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}			
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].activate();
			}				
		}			
	} 
	else {
		//alert("active");
		// alert("Activate olDrawFeature, Deactivate olNavigation");
		if (num_points < 2){
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlSelectFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}	
				if (map.controls[i].displayClass == "olControlMeasure") {
					map.controls[i].deactivate();
				}
			}
		}		
	}

}

function timDiaDiem(){
	alert("Tim dia diem");
}

function huongDan(){
	alert("Huong dan");
}

function inBanDo(){
	alert("In ban do");
}

function chonVung(){
	alert("Chon vung");
}

function doKhoangCach(){
	timduong_clicked =0;
	dokhoangcach_clicked=1;
	$(".tim-duong").removeClass("clicked");
	$(".tim-duong").addClass("not-clicked");
	$(".do-khoang-cach").removeClass("not-clicked");
	$(".do-khoang-cach").addClass("clicked");
	if (control_measure.active){
		//alert("da duoc active");
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlMeasure") {
				map.controls[i].deactivate();
			}			
		}
	}
	else{
		//alert("da duoc deactive");
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlMeasure") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}
		}
	}
	
}
/*******************END: DINH NGHIA CHO CAC SU KIEN NHAN TREN CAC NUT TREN BOTTOM BAR*******************/

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
		a.val("Nhap vao danh sach...");
	}
}
function OnforcusTextBoxAB(a){
			a=$(a);
			a.val("");
			prev_selectedResAB_Text=selectedResAB_Text=a.val();
}

/************POPUP EVENTS****************/
function popup_TuDay(x,y){
	//alert("x: "+x+"- y: "+y);
	//Xoa cac feature dang co tren lop_diem_chon
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var lop_duong_di = map.getLayersByName('lop_duong_di')[0];
	//Xoa cac features dang co tren lop_duong_di va lop_diem_chon
	lop_diem_chon.destroyFeatures();	
	lop_duong_di.destroyFeatures();
	//Tao feature tai vi tri x,y
	var point = new OpenLayers.Geometry.Point(x,y);	
	var feature = new OpenLayers.Feature.Vector(point);
	//Them feature vua tao vao lop_diem_chon
	lop_diem_chon.addFeatures(feature);	
	/***Tao icon cho start_point****/
	//Lay feature vua them vao lop lop_diem_chon ra
	var new_point = lop_diem_chon.features[0];	
	//Tao symbolizer tu stylemap cua lop_diem_chon
	var symbolizer = new_point.layer.styleMap.createSymbolizer(new_point);	
	//Thay doi icon cho feature
	symbolizer['externalGraphic'] = 'images/tuday.png';
	//Set the unique style to the feature
	new_point.style = symbolizer;	
	//Ve lai diem voi style moi
	new_point.layer.drawFeature(new_point);	
	for ( var i = 0; i < map.controls.length; i++) {		
		if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}				
		if (map.controls[i].displayClass == "olControlDragFeature") {
			map.controls[i].activate();
		}
		if (map.controls[i].displayClass == "olControlSelectFeature") {
			map.controls[i].activate();
		}
	}
	//An popup 
	$("#chicken").hide();
}

function popup_DenDay(x,y){
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;	
	//Tao feature tai vi tri x,y
	var point = new OpenLayers.Geometry.Point(x,y);
	var new_feature = new OpenLayers.Feature.Vector(point);
	if (num_points == 1){		
		//Them feature vua tao vao lop_diem_chon
		lop_diem_chon.addFeatures(new_feature);
		/***Tao icon cho start_point****/
		//Lay feature vua them vao lop lop_diem_chon ra
		var new_point = lop_diem_chon.features[1];	
		//Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = new_point.layer.styleMap.createSymbolizer(new_point);	
		//Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		//Set the unique style to the feature
		new_point.style = symbolizer;	
		//Ve lai diem voi style moi
		new_point.layer.drawFeature(new_point);
		//Goi service tim duong sau khi diem cuoi duoc them vao lop_diem_chon
		getDuongDi();
		//An popup 
		$("#chicken").hide();
	}
	else if (num_points == 2){
		//xoa feature thu hai tren lop_diem_chon sau do them diem moi vao
		//lay ra diem thu hai
		var end_point = lop_diem_chon.features[1];
		lop_diem_chon.removeFeatures(end_point);
		//alert('da remove xong');
		lop_diem_chon.addFeatures(new_feature);	
		/***Tao icon cho start_point****/
		//Lay feature vua them vao lop lop_diem_chon ra
		var new_point = lop_diem_chon.features[1];	
		//Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = new_point.layer.styleMap.createSymbolizer(new_point);	
		//Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		//Set the unique style to the feature
		new_point.style = symbolizer;	
		//Ve lai diem voi style moi
		new_point.layer.drawFeature(new_point);
		//Goi service tim duong sau khi diem cuoi duoc them vao lop_diem_chon
		getDuongDi();
		for ( var i = 0; i < map.controls.length; i++) {						
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
		}	
		//An popup 
		$("#chicken").hide();
	}	
}
function popup_PhongTo(x,y){
	//dich chuyen tam ban do ve diem duoc chon
	var lonlat = new OpenLayers.LonLat(x,y);
	map.setCenter(lonlat, 7 , false, false);
}
function popup_TimXungQuanh(){
	$(".maker-popup-div1").hide();
	$(".maker-popup-div2").show();	
}
function popup_QuayLai(){
	$(".maker-popup-div2").hide();
	$(".maker-popup-div1").show();
}
function popup_Tim(x,y){
	var chuoi = $(".maker-popup-textdichvu").val();
	var bankinh = $(".maker-popup-textbankinh").val();
	if (bankinh==""){
		bankinh = 0;
	}
	//goi dich vu tai day
	//alert(x+"-"+y+"-"+chuoi+"-"+bankinh);
	find_Place_Around_Point(x, y, chuoi, bankinh);
	//An popup 
	$("#chicken").hide();	
}
function HideMapList(){
	$("#boundTree").hide();
}
function LoadTree(){
	$("#boundTree").show();
}
/************END POPUP EVENTS****************/