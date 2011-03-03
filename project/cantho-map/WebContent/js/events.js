/**
 * 
 */
$(document).ready(function() {
	// Code that uses jQuery's $ can follow here.
	//alert('hoang');		
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
				/*
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].deactivate();
				}
				*/
			}
		} 
		else {
			// alert("Deactivate olDrawFeature, Activate olNavigation");
			reset_DuongDi();
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].deactivate();
				}
				/*
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].deactivate();
				}
				*/
				/*
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}
				*/
			}
		}
	});
});

function reset_DuongDi() {
	
	list_layer_diem_chon = map.getLayersByName('lop_diem_chon');
	lop_diem_chon = list_layer_diem_chon[0];
	lop_diem_chon.destroyFeatures();
	checked = $("#chk_timduong").attr("checked");
	if (checked == true) {
		//alert("Activate olDrawFeature, Deactivate olNavigation");
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].activate();
			}
			/*
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].deactivate();
			}
			*/
		}
	} else {
		//alert("Deactivate olDrawFeature, Activate olNavigation");
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlDrawFeature") {
				map.controls[i].deactivate();
			}
			/*
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
			*/
		}
	}
	//xoa lop duong di
	list_layer_duong_di = map.getLayersByName('lop_duong_di');
	lop_duong_di=list_layer_duong_di[0];
	lop_duong_di.destroyFeatures();
}
/*******Do Khoang Do Nguoi Duong Ve: ControlMeasure**********/
function doKhoangCach(){
	for ( var i = 0; i < map.controls.length; i++) {
		if (map.controls[i].displayClass == "olControlMeasure") {
			map.controls[i].activate();
		}
		else if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}
		else {
			//deactivate cac control con lai
			map.controls[i].deactivate();
		}		
	}
}

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
function getLopDiaDiem(ten_lop){
	alert(ten_lop);	
}

/************POPUP EVENTS****************/
function popup_TuDay(x,y){
	//alert("x: "+x+"- y: "+y);
	//xoa cac feature dang co tren lop_diem_chon
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];	
	var num_points = lop_diem_chon.features.length; 
	if (num_points > 0){
		//xoa cac feature tren lop_diem_chon
		lop_diem_chon.destroyFeatures();
	}
	//tao feature tai vi tri x,y
	var point = new OpenLayers.Geometry.Point(x,y);	
	var feature = new OpenLayers.Feature.Vector(point);
	//Them feature vua tao vao lop_diem_chon
	lop_diem_chon.addFeatures(feature);	
	/***Tao icon cho start_point****/
	//lay feature vua them vao lop lop_diem_chon ra
	var new_point = lop_diem_chon.features[0];	
	//Dinh dang icon cho new_point		
	//Tao symbolizer tu stylemap cua lop_diem_chon
	var symbolizer = new_point.layer.styleMap.createSymbolizer(new_point);	
	//Thay doi icon cho feature
	symbolizer['externalGraphic'] = 'images/tuday.png';
	//Set the unique style to the feature
	new_point.style = symbolizer;	
	//Ve lai diem voi style moi
	new_point.layer.drawFeature(new_point);
	lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	//lop_dia_diem.destroyFeatures();
	
	for ( var i = 0; i < map.controls.length; i++) {		
		if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}
		if (map.controls[i].displayClass == "olControlSelectFeature") {
			map.controls[i].activate();
		}		
	}
	
}

function popup_DenDay(x,y){
	
}
function popup_PhongTo(x,y){
	
}
function popup_TimXungQuanh(x,y){
	
}
/************END POPUP EVENTS****************/