/**
 * 
 */
function reset_DuongDi() {
	alert("sdgsd");
	list_layer_diem_chon = map.getLayersByName('diem_chon');
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
		}
	}
	//xoa lop duong di
	list_layer_duong_di = map.getLayersByName('duong_di');
	lop_duong_di=list_layer_duong_di[0];
	lop_duong_di.destroyFeatures();
}

	
