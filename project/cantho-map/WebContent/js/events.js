/**
 * 
 */
var timduong_clicked = 0;
var dokhoangcach_clicked = 0;
var flag_end = 0;// kiem tra: truong hop da co mot diem tren lop_diem_chon la
// start hay end
$(document).ready(function() {  
	$("#btnTim").click(function() {
		var ten=$("#mapinput").val();
		if(ten!=""){
			var ds_ma="";
			$(".dTreeNode").each(function(){
				  if ($(this).children(":first").attr("checked")==true)
					  if(ds_ma==""){
						  ds_ma=ds_ma + $(this).children(":first").val();
					  }else{
						  ds_ma=ds_ma+"$" + $(this).children(":first").val();
					  }
				  });
			if($("#map_path_div").attr("name")=="huyen"){
				find_Place_By_Text_And_Huyen(ten,ds_ma);
			}else if($("#map_path_div").attr("name")=="xa"){
				if(ds_ma==""){
					var mahuyen_hientai=$("#path_huyen").attr("value");
					find_Place_By_Text_And_Huyen(ten,mahuyen_hientai);
				}else{
					find_Place_By_Text_And_Xa(ten,ds_ma);
				}
			}
			HideMapList();
		}
	});
	$('#mapinput').keyup(function(e) {
	     if(e.keyCode == 13) {
	    	    var ten=$("#mapinput").val();
	    		if(ten!=""){
	    			var ds_ma="";
	    			$(".dTreeNode").each(function(){
	    				  if ($(this).children(":first").attr("checked")==true)
	    					  if(ds_ma==""){
	    						  ds_ma=ds_ma + $(this).children(":first").val();
	    					  }else{
	    						  ds_ma=ds_ma+"$" + $(this).children(":first").val();
	    					  }
	    				  });
	    			if($("#map_path_div").attr("name")=="huyen"){
	    				find_Place_By_Text_And_Huyen(ten,ds_ma);
	    			}else if($("#map_path_div").attr("name")=="xa"){
	    				if(ds_ma==""){
	    					var mahuyen_hientai=$("#path_huyen").attr("value");
	    					find_Place_By_Text_And_Huyen(ten,mahuyen_hientai);
	    				}else{
	    					find_Place_By_Text_And_Xa(ten,ds_ma);
	    				}
	    			}
	    			HideMapList();
	    		}
	     }
	});
	$('.del-timduonga').live('click', function()  {  
		$('.tim-a').val('');
     }); 
	$('.del-timduongb').live('click', function()  {  
		$('.tim-b').val('');
     });
	
	$('#clearSearchResultText').live('click', function()  {  
		$("#tab_content2").html("");
		//xoa cac features tren lop_dia_diem khi nhan len nut X
		var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
		lop_dia_diem.destroyFeatures();
     });
	$('#txt_bk_lt').bind("keypress",function (e) {
        //if the letter is not digit then display error and don't type anything
        if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57)) {
            return false;
        }
	});	
});

/*******************DINH NGHIA CHO CAC SU KIEN NHAN TREN CAC NUT TREN BOTTOM BAR*******************/
/*******Do Khoang Do Nguoi Duong Ve: ControlMeasure**********/
function timDuong(){
	//alert("Bat dau tim duong");
	timduong_clicked =1;
	dokhoangcach_clicked=0;
	$(".kq-doKC").stop().animate({right:-199},350,"linear");
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
			if (map.controls[i].displayClass == "olControlNavigation") {
				map.controls[i].activate();
			}
			/*
			if (map.controls[i].displayClass == "olControlSelectFeature") {
				map.controls[i].activate();
			}
			*/			
		}
		control_select.activate();
	} else {
		// alert("active");
		// alert("Activate olDrawFeature, Deactivate olNavigation");
		if (num_points < 2) {
			for ( var i = 0; i < map.controls.length; i++) {
				if (map.controls[i].displayClass == "olControlDrawFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlDragFeature") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlNavigation") {
					map.controls[i].activate();
				}
				if (map.controls[i].displayClass == "olControlMeasure") {
					map.controls[i].deactivate();
				}
				/*
				if (map.controls[i].displayClass == "olControlSelectFeature") {
					map.controls[i].activate();
				}
				*/
			}
			control_select.activate();
			//control_hover.activate();
		}
	}

}

function timDiaDiem() {
	alert("Tim dia diem");
}

function huongDan() {
	alert("Huong dan");
}

function inBanDo() {
	alert("In ban do");
}
/*
function chonVung() {
	//An/ hien lop_quan_huyen cho nguoi dung chon
	var lop_quan_huyen = map.getLayersByName('lop_quan_huyen')[0];
	var visibility = lop_quan_huyen.visibility;
	//alert(lop_quan_huyen.visibility);
	if (visibility == true){
		lop_quan_huyen.setVisibility(false);
		control_select_quan_huyen.deactivate();
		//control_drag.activate();		
		control_hover.activate();
		//control_select.activate();		
	}else{
		lop_quan_huyen.setVisibility(true);
		control_select_quan_huyen.activate();
	}
	//alert("So features hien tai: "+lop_quan_huyen.features.length);
	//alert("Ten feature[0] : "+lop_quan_huyen.features[0].attributes.ten);
	//alert("gidfeature[0] : "+lop_quan_huyen.features[0].attributes.id);
	//alert("Area feature[0] : "+lop_quan_huyen.features[0].geometry.getArea());	
}
*/
function doKhoangCach() {
	timduong_clicked = 0;
	dokhoangcach_clicked = 1;
	$(".tim-duong").removeClass("clicked");
	$(".tim-duong").addClass("not-clicked");
	$(".do-khoang-cach").removeClass("not-clicked");
	$(".do-khoang-cach").addClass("clicked");
	$(".div-dv-lt").stop().animate({right:-199},350,"linear");
	if($(".kq-doKC").css("right").replace("px","")<0){
		$(".kq-doKC").stop().animate({right:115},350,"linear");
		$(".tong-kc-m").html("0 km");
		}
	else{
		$(".kq-doKC").stop().animate({right:-199},350,"linear");
	}
	if (control_measure.active) {
		// alert("da duoc active");
		for ( var i = 0; i < map.controls.length; i++) {
			if (map.controls[i].displayClass == "olControlMeasure") {
				map.controls[i].deactivate();
			}
		}
	} else {
		// alert("da duoc deactive");
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
		if($("#left_content").css("left").replace("px","")<0){
			$("#left_content").stop().animate({left:0},350,"linear");
			$(".olControlPanZoomBar").stop().animate({left:300},350,"linear");
			$(".olControlScaleLine").stop().animate({left:305},350,"linear");
			
			}
		else{
			$("#left_content").stop().animate({left:-295},350,"linear");
			$(".olControlPanZoomBar").stop().animate({left:5},350,"linear");
			$(".olControlScaleLine").stop().animate({left:10},350,"linear");
		
			
		}
	}
function showLeftContent1(){
	$("#left_content").stop().animate({left:0},350,"linear");
	$(".olControlPanZoomBar").stop().animate({left:300},350,"linear");
	$(".olControlScaleLine").stop().animate({left:305},350,"linear");
	$("#tab1").click();
}
function showLeftContent2(){
	$("#left_content").stop().animate({left:0},350,"linear");
	$(".olControlPanZoomBar").stop().animate({left:300},350,"linear");
	$(".olControlScaleLine").stop().animate({left:305},350,"linear");
	$("#tab2").click();
	$("#clearSearchResultText").css("display","block");
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
/*
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
	//Tao icon cho start_point/
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
*/
function popup_TuDay(x,y){
	//alert($(".maker-popup-ten").html());
	//gan ten cho muc nhap A
	$(".tim-a").val($(".maker-popup-ten").html());
	var wkt = "POINT("+x+" "+y+")";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	//var point = new OpenLayers.Geometry.Point(x,y);
	var point = wkt_format.read(wkt);
	// alert("point: "+point.geometry);
	if (num_points == 0) {
		// alert("num_points= "+num_points);
		lop_diem_chon.addFeatures(point);
		// Dat lai gia tri cho end_flag
		flag_end = 0;
	} else if (num_points == 1) {
		if (flag_end == 1) {
			//alert("flag_end"+flag_end);
			// lay diem dau tien ra
			var wkt_point_end = lop_diem_chon.features[0].geometry;
			//alert("point_end: "+wkt_point_end);
			// xoa lop_diem_chon
			lop_diem_chon.destroyFeatures();
			// Them diem moi chon vao
			lop_diem_chon.addFeatures(point);
			// them diem thu hai
			lop_diem_chon.addFeatures(wkt_format.read(wkt_point_end));			
			/** *Tao icon cho end_point*** */
			// Lay feature vua them vao lop lop_diem_chon ra
			var e_point = lop_diem_chon.features[1];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// Set the unique style to the feature
			e_point.style = symbolizer;
			// Ve lai diem voi style moi
			e_point.layer.drawFeature(e_point);
			//alert("seconde feature : "+lop_diem_chon.features[1].geometry);
		} else {
			// di chuyen diem cu den vi tri moi
			var first_point = lop_diem_chon.features[0];
			var new_x = point.geometry.x;
			var new_y = point.geometry.y;
			var x = first_point.geometry.x;
			var y = first_point.geometry.y;
			// dich chuyen diem dau den vi tri moi
			first_point.geometry.move(new_x - x, new_y - y);
			first_point.layer.drawFeature(first_point);
		}
	} else if (num_points == 2) {
		// di chuyen diem cu den vi tri moi
		var first_point = lop_diem_chon.features[0];
		var new_x = point.geometry.x;
		var new_y = point.geometry.y;
		var x = first_point.geometry.x;
		var y = first_point.geometry.y;
		// dich chuyen diem dau den vi tri moi
		first_point.geometry.move(new_x - x, new_y - y);
		first_point.layer.drawFeature(first_point);
		// alert("num_points: "+num_points);
		/** *Tao icon cho end_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var e_point = lop_diem_chon.features[1];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		// Set the unique style to the feature
		e_point.style = symbolizer;
		// Ve lai diem voi style moi
		e_point.layer.drawFeature(e_point);
		// Dat lai gia tri cho end_flag
		flag_end = 0;
	}
	/** Dich chuyen ban do lai vi tri cua diem do* */
	/*
	var lonlat = new OpenLayers.LonLat(point.geometry.x, point.geometry.y);
	map.setCenter(lonlat);
	*/
	/** *Tao icon cho start_point*** */
	// Lay feature vua them vao lop lop_diem_chon ra
	var s_point = lop_diem_chon.features[0];
	// Tao symbolizer tu stylemap cua lop_diem_chon
	var symbolizer = s_point.layer.styleMap.createSymbolizer(s_point);
	// Thay doi icon cho feature
	symbolizer['externalGraphic'] = 'images/tuday.png';
	// Set the unique style to the feature
	s_point.style = symbolizer;
	// Ve lai diem voi style moi
	s_point.layer.drawFeature(s_point);
	num_points = lop_diem_chon.features.length;	
	if (num_points == 2) {
		//alert("num_points: "+num_points+"- flag_end: "+flag_end);
		// goi webservice cap nhat duong di moi
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}	
	/** *them chuoi vao o nhap lieu A** */
	for ( var i = 0; i < map.controls.length; i++) {
		if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}
		if (map.controls[i].displayClass == "olControlDragFeature") {
			map.controls[i].activate();
		}
		
		/*
		if (map.controls[i].displayClass == "olControlSelectFeature") {
			map.controls[i].activate();
		}
		*/
		control_select.activate();
	}	
	$("#chicken").hide();
}
/*
function popup_DenDay(x,y){
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;	
	//Tao feature tai vi tri x,y
	var point = new OpenLayers.Geometry.Point(x,y);
	var new_feature = new OpenLayers.Feature.Vector(point);
	if (num_points == 1){		
		//Them feature vua tao vao lop_diem_chon
		lop_diem_chon.addFeatures(new_feature);
		//Tao icon cho start_point
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
		//Tao icon cho start_point
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
*/
function popup_DenDay(x,y){
	//gan ten cho muc nhap B
	$(".tim-b").val($(".maker-popup-ten").html());
	var wkt = "POINT("+x+" "+y+")";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	var point = wkt_format.read(wkt);
	if (num_points == 0) {
		lop_diem_chon.addFeatures(point);
		flag_end = 1;
		/** *Tao icon cho end_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var e_point = lop_diem_chon.features[0];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		// Set the unique style to the feature
		e_point.style = symbolizer;
		// Ve lai diem voi style moi
		e_point.layer.drawFeature(e_point);
		//alert("num_points sau khi them: "+lop_diem_chon.features.length);
		//alert("flag_end :"+flag_end);
	} else if (num_points == 1) {
		if (flag_end == 1) {
			// dich chuyen end_point den vi tri moi
			var first_point = lop_diem_chon.features[0];
			var new_x = point.geometry.x;
			var new_y = point.geometry.y;
			var x = first_point.geometry.x;
			var y = first_point.geometry.y;
			// dich chuyen diem dau den vi tri moi
			first_point.geometry.move(new_x - x, new_y - y);
			first_point.layer.drawFeature(first_point);
		} else {
			// Them moi binh thuong
			lop_diem_chon.addFeatures(point);
			/** *Tao icon cho end_point*** */
			// Lay feature vua them vao lop lop_diem_chon ra
			var e_point = lop_diem_chon.features[1];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// Set the unique style to the feature
			e_point.style = symbolizer;
			// Ve lai diem voi style moi
			e_point.layer.drawFeature(e_point);
		}
	} else if (num_points == 2) {
		//dich chuyen end_point den vi tri moi
		var second_point = lop_diem_chon.features[1];
		var new_x = point.geometry.x;
		var new_y = point.geometry.y;
		var x = second_point.geometry.x;
		var y = second_point.geometry.y;
		// dich chuyen diem dau den vi tri moi
		second_point.geometry.move(new_x - x, new_y - y);
		second_point.layer.drawFeature(second_point);
	}
	//kiem tra la neu du hai diem thi goi webservices
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		// goi webservice cap nhat duong di moi
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}	
	/** *them chuoi vao o nhap lieu A** */
	for ( var i = 0; i < map.controls.length; i++) {
		if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}
		if (map.controls[i].displayClass == "olControlDragFeature") {
			map.controls[i].activate();
		}
		/*
		if (map.controls[i].displayClass == "olControlSelectFeature") {
			map.controls[i].activate();
		}
		*/		
	}
	control_select.activate();
	$("#chicken").hide();
}
function popup_PhongTo(x,y){
	//dich chuyen tam ban do ve diem duoc chon
	var zoom_level = map.getZoom();
	if (zoom_level < 7){
		var lonlat = new OpenLayers.LonLat(x,y);
		map.setCenter(lonlat, 7 , false, false);
	}	
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
/** **********END POPUP EVENTS*************** */

/*******************************************************************************
 * Neu so feature hien tai == 0 -> Them moi binh thuong Neu so feature hien tai ==
 * 1 , kiem tra bien end_flag xem diem hien tai co phai la diem cuoi hay khong -
 * Neu la diem cuoi thi lay ra va them theo thu tu diem_moi, diem_cuoi - Neu
 * khong phai thi dich chuyen diem do den vi tri moi (vi tri nguoi dung chon)
 * Neu so feature hien tai == 2, dich chuyen diem dau den vi tri moi(vi tri
 * nguoi dung chon) Them phan tu duoc chon vao vao o nhap diem A
 ******************************************************************************/
function chonDiemA(i) {	
	a = $('.result_' + i);
	//gan ten cho muc nhap A
	$(".tim-a").val(a.attr('name'));
	var wkt = a.attr('id');	
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	var point = wkt_format.read(wkt);
	// alert("point: "+point.geometry);
	if (num_points == 0) {
		// alert("num_points= "+num_points);
		lop_diem_chon.addFeatures(point);
		// Dat lai gia tri cho end_flag
		flag_end = 0;
	} else if (num_points == 1) {
		if (flag_end == 1) {
			// lay diem dau tien ra
			var wkt_point_end = lop_diem_chon.features[0].geometry;
			//alert("point_end: "+wkt_point_end);
			// xoa lop_diem_chon
			lop_diem_chon.destroyFeatures();
			// Them diem moi chon vao
			lop_diem_chon.addFeatures(point);
			// them diem thu hai
			lop_diem_chon.addFeatures(wkt_format.read(wkt_point_end));			
			/** *Tao icon cho end_point*** */
			// Lay feature vua them vao lop lop_diem_chon ra
			var e_point = lop_diem_chon.features[1];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// Set the unique style to the feature
			e_point.style = symbolizer;
			// Ve lai diem voi style moi
			e_point.layer.drawFeature(e_point);
			//alert("seconde feature : "+lop_diem_chon.features[1].geometry);
			flag_end = 0;
		} else {
			// di chuyen diem cu den vi tri moi
			var first_point = lop_diem_chon.features[0];
			var new_x = point.geometry.x;
			var new_y = point.geometry.y;
			var x = first_point.geometry.x;
			var y = first_point.geometry.y;
			// dich chuyen diem dau den vi tri moi
			first_point.geometry.move(new_x - x, new_y - y);
			first_point.layer.drawFeature(first_point);
		}
	} else if (num_points == 2) {
		// di chuyen diem cu den vi tri moi
		var first_point = lop_diem_chon.features[0];
		var new_x = point.geometry.x;
		var new_y = point.geometry.y;
		var x = first_point.geometry.x;
		var y = first_point.geometry.y;
		// dich chuyen diem dau den vi tri moi
		first_point.geometry.move(new_x - x, new_y - y);
		first_point.layer.drawFeature(first_point);
		// alert("num_points: "+num_points);
		/** *Tao icon cho end_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var e_point = lop_diem_chon.features[1];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		// Set the unique style to the feature
		e_point.style = symbolizer;
		// Ve lai diem voi style moi
		e_point.layer.drawFeature(e_point);
		// Dat lai gia tri cho end_flag
		flag_end = 0;
	}
	/** Dich chuyen ban do lai vi tri cua diem do* */
	var lonlat = new OpenLayers.LonLat(point.geometry.x, point.geometry.y);
	map.setCenter(lonlat);
	/** *Tao icon cho start_point*** */
	// Lay feature vua them vao lop lop_diem_chon ra
	var s_point = lop_diem_chon.features[0];
	// Tao symbolizer tu stylemap cua lop_diem_chon
	var symbolizer = s_point.layer.styleMap.createSymbolizer(s_point);
	// Thay doi icon cho feature
	symbolizer['externalGraphic'] = 'images/tuday.png';
	// Set the unique style to the feature
	s_point.style = symbolizer;
	// Ve lai diem voi style moi
	s_point.layer.drawFeature(s_point);
	num_points = lop_diem_chon.features.length;	
	if (num_points == 2) {
		//alert("num_points: "+num_points+"- flag_end: "+flag_end);
		// goi webservice cap nhat duong di moi
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}	
	/** *them chuoi vao o nhap lieu A** */
	for ( var i = 0; i < map.controls.length; i++) {
		if (map.controls[i].displayClass == "olControlNavigation") {
			map.controls[i].activate();
		}
		if (map.controls[i].displayClass == "olControlDragFeature") {
			map.controls[i].activate();
		}
		/*
		if (map.controls[i].displayClass == "olControlSelectFeature") {
			map.controls[i].activate();
		}
		*/
	}
	control_select.activate();
	// alert(a.attr('id'));
	 $('#searchPopupContainer').css('display', 'none');
}
/*******************************************************************************
 * Neu so feature hien tai == 0, thi them vao binh thuong, dinh dang icon la
 * diem cuoi, dong thoi gan bien end_flag =1 Neu so feature hien tai == 1, - Neu
 * end_flag == 1 (end_point), dich chuyen diem do den vi tri moi - Neu end_flag ==
 * 0 (start_point), them diem moi (end_point) vao binh thuong Neu so feature
 * hien tai == 2, dich chuyen diem hai den vi tri moi (vi tri nguoi dung chon)
 ******************************************************************************/
function chonDiemB(i) {
	// i=document.getElementById(a);	
	a = $('.result2_' + i);
	//gan ten cho muc nhap A
	$(".tim-b").val(a.attr('name'));
	var wkt = a.attr('id');	
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	var point = wkt_format.read(wkt);
	if (num_points == 0) {
		lop_diem_chon.addFeatures(point);
		flag_end = 1;
		/** *Tao icon cho end_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var e_point = lop_diem_chon.features[0];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		// Set the unique style to the feature
		e_point.style = symbolizer;
		// Ve lai diem voi style moi
		e_point.layer.drawFeature(e_point);
		//alert("num_points sau khi them: "+lop_diem_chon.features.length);
		//alert("flag_end :"+flag_end);
	} else if (num_points == 1) {		
		if (flag_end == 1) {
			// dich chuyen end_point den vi tri moi
			var first_point = lop_diem_chon.features[0];
			var new_x = point.geometry.x;
			var new_y = point.geometry.y;
			var x = first_point.geometry.x;
			var y = first_point.geometry.y;
			// dich chuyen diem dau den vi tri moi
			first_point.geometry.move(new_x - x, new_y - y);
			first_point.layer.drawFeature(first_point);
		} else if (flag_end == 0){
			//alert("Them binh thuong");			
			// Them moi binh thuong			
			lop_diem_chon.addFeatures(point);			
			//Tao icon cho end_point		
			// Lay feature vua them vao lop lop_diem_chon ra
			var e_point = lop_diem_chon.features[1];
			// Tao symbolizer tu stylemap cua lop_diem_chon
			var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
			// Thay doi icon cho feature
			symbolizer['externalGraphic'] = 'images/denday.png';
			// Set the unique style to the feature
			e_point.style = symbolizer;
			// Ve lai diem voi style moi
			e_point.layer.drawFeature(e_point);
		
		}
	} else if (num_points == 2) {
		//dich chuyen end_point den vi tri moi
		var second_point = lop_diem_chon.features[1];
		var new_x = point.geometry.x;
		var new_y = point.geometry.y;
		var x = second_point.geometry.x;
		var y = second_point.geometry.y;
		// dich chuyen diem dau den vi tri moi
		second_point.geometry.move(new_x - x, new_y - y);
		second_point.layer.drawFeature(second_point);
	}
	/** Dich chuyen ban do lai vi tri cua diem do* */
	var lonlat = new OpenLayers.LonLat(point.geometry.x, point.geometry.y);
	map.setCenter(lonlat);
	control_ve_diem.deactivate();
	/*
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
	*/
	control_select.activate();
	//kiem tra la neu du hai diem thi goi webservices
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		// goi webservice cap nhat duong di moi
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
	}		
	 $('#searchPopupContainer2').css('display', 'none');
}
function chonViTri(i) {	
	//Lay ra cac element cua document
	var a = $('.result3_' + i);
	var class_dc = $('.diachi_'+i);
	var class_sdt = $('.sodienthoai_'+i);
	//Lay noi dung cua cac thanh phan element
	var wkt = a.attr('id');	
	var ten = a.html();
	var diachi = class_dc.html();
	var sodienthoai = class_sdt.html();		
	//Tao doi tuong feature tu chuoi wkt
	var wkt_format = new OpenLayers.Format.WKT();
	var point_geometry = wkt_format.read(wkt);
	var x = point_geometry.geometry.x;
	var y = point_geometry.geometry.y;
	//alert(point_geometry.geometry.x);
	var lonlat = new OpenLayers.LonLat(x,y);
	//map.setCenter(lonlat , false, false);
	/*****Hien thi Popup, cho biet thong tin cua vi tri duoc chon****/
	//tao noi dung cho popup
	var content= "<div class = 'maker-popup-ten'>" + ten +"</div>" + 	
	"<div class='maker-popup-div1'> " +
		"<div class = 'maker-popup-diachi'>"+ diachi + "</div>"+
		"<div class = 'maker-popup-sdt'>"+ sodienthoai + "</div>" +
		"<div class = 'maker-popup-footer' > " +
			"<a class='maker-popup-tuday' href='javascript:popup_TuDay("+ x +","+ y +")'>Tu day</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-denday' href='javascript:popup_DenDay("+ x +","+ y +")'>Den day</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-phongto' href='javascript:popup_PhongTo("+ x +","+ y +")'>Phong to</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-timxungquanh' href='javascript:popup_TimXungQuanh()'>Tim xung quanh</a>" +
		"</div>"+
	"</div> " +
	"<div class='maker-popup-div2'> " +
		"<!--div  class  = 'maker-popup-timdv'>Tim dich vu o gan vi tri nay</div-->" +
		"<table>" +
			"<tr>" +
				"<td>Ten</td>" +
				"<td   class = 'maker-popup-tendv'><input class = 'maker-popup-textdichvu' name='textdichvu' type='text' value='' /></td>" +
			"</tr>" +
			"<tr>" +
				"<td>Ban kinh</td>" +
				"<td   class = 'maker-popup-bankinh' ><input id='txt_bk' maxlength='10' class = 'maker-popup-textbankinh' name='textbankinh' type='text' value='' /> met </td>" +
			"</tr>" +
		"</table>" +
		"<div class = 'maker-popup-footer' >" +
			"<input class = 'maker-popup-quaylai' name='buttonquaylai'     type='button' value='Quai lai' onclick='popup_QuayLai()' />" +
			"<input class = 'maker-popup-tim'     name='buttonTim'         type='button' value='Tim' onclick='popup_Tim("+ x +","+ y +")'/>" +
		"</div>" +
	"</div>" ;
	//Tao popup voi noi dung tren
	var popup = new OpenLayers.Popup.FramedCloud("chicken", lonlat,
			new OpenLayers.Size(100, 100), content, null, true);
	//them popup vao ban do
	map.addPopup(popup, true);
	$('#txt_bk').bind("keypress",function (e) {
        //if the letter is not digit then display error and don't type anything
        if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57)) {
            return false;
        }
	});	
}
function clickHuyen(i){
	a = $('.huyen_' + i);
	var mahuyen=a.attr("value");
	getXaPhuong(mahuyen);
	var html="    <a  class = 'cantho' href='javascript:getQuanHuyen()'>Can Tho</a> " +
			 "&gt <label id='path_huyen' value='"+mahuyen+">"+a.attr("name")+"</label>";
	$("#map_path_div").attr("name","xa");
	$("#map_path_div").html(html);
}
function clickXa(i){
	if($('input[name=check'+i +']').attr('checked')==true){
		$('input[name=check'+i +']').attr('checked',false);
	}else{
		$('input[name=check'+i +']').attr('checked',true);
	}	
}
function daoChieu(){
	//kiem tra xem neu tren lop_diem_chon co tu 2 diem tro len thi bat dau dao chieu
	var lop_diem_chon = map.getLayersByName('lop_diem_chon')[0];
	var num_points = lop_diem_chon.features.length;
	var wkt_format = new OpenLayers.Format.WKT();
	if (num_points == 2){		
		//lay hai features tren lop_diem_chon, sau do doi thu tu
		var first_point = lop_diem_chon.features[0].geometry.clone();
		var last_point = lop_diem_chon.features[1].geometry.clone();
		lop_diem_chon.destroyFeatures();
		lop_diem_chon.addFeatures(wkt_format.read(last_point));
		lop_diem_chon.addFeatures(wkt_format.read(first_point));
		//Dinh dang cho start_point va end_point
		/** *Tao icon cho start_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var s_point = lop_diem_chon.features[0];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = s_point.layer.styleMap.createSymbolizer(s_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/tuday.png';
		// Gan lai style moi feature
		s_point.style = symbolizer;
		//Ve lai diem voi style moi
		s_point.layer.drawFeature(s_point);
		/** *Tao icon cho end_point*** */
		// Lay feature vua them vao lop lop_diem_chon ra
		var e_point = lop_diem_chon.features[1];
		// Tao symbolizer tu stylemap cua lop_diem_chon
		var symbolizer = e_point.layer.styleMap.createSymbolizer(e_point);
		// Thay doi icon cho feature
		symbolizer['externalGraphic'] = 'images/denday.png';
		// Gan lai style moi feature
		e_point.style = symbolizer;
		// Ve lai diem voi style moi
		e_point.layer.drawFeature(e_point);		
		/**Goi webservice**/
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		callService(start_point.x, start_point.y, end_point.x, end_point.y);
		//Doi text trong textbox
		var temp = '';
		temp = $('.tim-a').val();
		$('.tim-a').val($('.tim-b').val());
		$('.tim-b').val(temp);
	}
}
function dvLoTrinh(){
	$(".kq-doKC").stop().animate({right:-199},350,"linear");
	if($(".div-dv-lt").css("right").replace("px","")<0){
		$(".div-dv-lt").stop().animate({right:115},350,"linear");
		}
	else{
		$(".div-dv-lt").stop().animate({right:-199},350,"linear");
	}
}
function timDichVuLoTrinh(){
	var text = $("#txt_ten_lt").val();
	var radius = $("#txt_bk_lt").val();	
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	//xoa cac dia diem hien co
	lop_dia_diem.destroyFeatures();
	var lop_duong_di = map.getLayersByName('lop_duong_di')[0];
	var num_segment = lop_duong_di.features.length;
	for (var i=0; i<num_segment ; i++ ){
		//alert(lop_duong_di.features[i].geometry.clone());
		var seg = lop_duong_di.features[i].geometry.clone();
		find_Place_Around_Streeet(seg, text, radius);
	}
}
