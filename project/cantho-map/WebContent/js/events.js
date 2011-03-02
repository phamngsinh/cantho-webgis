/**
 * 
 */
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
			if (map.controls[i].displayClass == "olControlDragFeature") {
				map.controls[i].activate();
			}
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].deactivate();
			}
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].deactivate();
			}
		}
	} else {
		//alert("Deactivate olDrawFeature, Activate olNavigation");
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
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
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
			reset_DuongDi();
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
		a.val("Nhập vào danh sach...");
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