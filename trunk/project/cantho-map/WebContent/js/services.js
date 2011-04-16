/**
 * 
 * 
 */
var url = 'http://localhost:8888/cantho-service/services/CanThoMap?wsdl';

function callService(x1, y1, x2, y2) {
	/*
	 * x1 = 586406.15289; y1 = 1110178.56230; x2 = 586424.03201; y2 =
	 * 1110974.18319;
	 */
	// var url1 = "http://localhost:8888/axis2/services/CanThoMap?wsdl";
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getDuongDi>";
	soapMessage += "         <ser:x1>" + x1 + "</ser:x1>";
	soapMessage += "         <ser:y1>" + y1 + "</ser:y1>";
	soapMessage += "         <ser:x2>" + x2 + "</ser:x2>";
	soapMessage += "         <ser:y2>" + y2 + "</ser:y2>";
	soapMessage += "      </ser:getDuongDi>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBackGetDuongDi,
		error : errorGetDuongDi,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function getDiaDiem(ten_lop, ten_diadiem) {
	// alert("tenlop: "+ten_lop+"- ten_diadiem: "+ten_diadiem);
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getDiaDiem>";
	soapMessage += "         <ser:lop>" + ten_lop + "</ser:lop>";
	soapMessage += "         <ser:ten>" + ten_diadiem + "</ser:ten>";
	soapMessage += "      </ser:getDiaDiem>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";

	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBackGetDiaDiem,
		error : errorGetDiaDiem,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function getDiaDiemTheoViTri(the_geom_point) {

	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_Info_Of_Point>";
	soapMessage += "         <ser:the_geom_point>" + the_geom_point
			+ "</ser:the_geom_point>";
	soapMessage += "      </ser:find_Info_Of_Point>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBackGetDiaDiemTheoViTri,
		error : errorGetDiaDiemTheoViTri,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		data : soapMessage
	});
}

function find_Place_By_Text(ten_dia_diem) {
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_Place_By_Text>";
	soapMessage += "         <ser:text>" + ten_dia_diem + "</ser:text>";
	soapMessage += "      </ser:find_Place_By_Text>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_By_Text,
		error : error_Find_Place_By_Text,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function find_Place_By_Text_And_Huyen(ten_dia_diem,ds_ma) {
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "  <soapenv:Body>";
	soapMessage += "     <ser:find_Place_By_Text_And_Huyen>";
	soapMessage += "       <ser:text>"+ten_dia_diem+"</ser:text>";
	soapMessage += "        <ser:str_id>"+ds_ma+"</ser:str_id>";
    soapMessage += "    </ser:find_Place_By_Text_And_Huyen>";
    soapMessage += "</soapenv:Body>";
    soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_By_Text_And_Huyen,
		error : error_Find_Place_By_Text_And_Huyen,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function find_Place_By_Text_And_Xa(ten_dia_diem,ds_ma) {
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "  <soapenv:Body>";
	soapMessage += "     <ser:find_Place_By_Text_And_Xa>";
	soapMessage += "       <ser:text>"+ten_dia_diem+"</ser:text>";
	soapMessage += "        <ser:str_id>"+ds_ma+"</ser:str_id>";
    soapMessage += "    </ser:find_Place_By_Text_And_Xa>";
    soapMessage += "</soapenv:Body>";
    soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_By_Text_And_Xa,
		error : error_Find_Place_By_Text_And_Xa,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function find_Place_By_Text2(ten_dia_diem) {
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_Place_By_Text>";
	soapMessage += "         <ser:text>" + ten_dia_diem + "</ser:text>";
	soapMessage += "      </ser:find_Place_By_Text>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_By_Text2,
		error : error_Find_Place_By_Text2,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function find_Place_Around_Point(x, y, chuoi, bankinh) {			
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";	
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_Place_Around_Point>";
	soapMessage += "         <ser:x>"+ x +"</ser:x>";
	soapMessage += "         <ser:y>"+ y +"</ser:y>";
	soapMessage += "         <ser:text>"+ chuoi +"</ser:text>";
	soapMessage += "         <ser:radius>"+ bankinh +"</ser:radius>";
	soapMessage += "      </ser:find_Place_Around_Point>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	//alert("Bat dau goi dich vu...");
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_Around_Point,
		error : error_Find_Place_Around_Point,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function find_Address_XP_QH_A(x,y){
	//alert("x= "+x+"- y= "+y);
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_address_xp_qh>";	        
	soapMessage += "         <ser:x>"+x+"</ser:x>";
	soapMessage += "         <ser:y>"+y+"</ser:y>";
	soapMessage += "      </ser:find_address_xp_qh>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Address_XP_QH_A,
		error : error_Find_Address_XP_QH_A,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function find_Address_XP_QH_B(x,y){
	//alert("x= "+x+"- y= "+y);
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:find_address_xp_qh>";	        
	soapMessage += "         <ser:x>"+x+"</ser:x>";
	soapMessage += "         <ser:y>"+y+"</ser:y>";
	soapMessage += "      </ser:find_address_xp_qh>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Address_XP_QH_B,
		error : error_Find_Address_XP_QH_B,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
/*********Goi Dich Vu Tra Ve Danh Sach Cac Dia Diem Theo Ten Lop************/
function getLopDiaDiem(ten_lop) {
	// alert(ten_lop);
	//Kiem tra xem nguoi dung co chon vung hay chua
	//neu co chon vung thi chi tim trong vung ma nguoi dung chon
	//Lay ra danh sach cac vung duoc chon
	$("#chicken").hide();
	var ds_ma="";
	var cap ="";
	$(".dTreeNode").each(function(){
		  if ($(this).children(":first").attr("checked")==true)
			  if(ds_ma==""){
				  ds_ma=ds_ma + $(this).children(":first").val();
			  }else{
				  ds_ma=ds_ma+"$" + $(this).children(":first").val();
			  }
		  });
	if($("#map_path_div").attr("name")=="huyen"){
		//find_Place_By_Text_And_Huyen(ten,ds_ma);
		cap = "huyen";
	}else if($("#map_path_div").attr("name")=="xa"){
		cap = "xa";
		if(ds_ma==""){
			//nguoi dung chon den cap xa nhung chua chon xa nao thi lay huyen hien tai cua no
			var ds_ma=$("#path_huyen").attr("value");
			cap = "huyen";
			//find_Place_By_Text_And_Huyen(ten,mahuyen_hientai);
		}
	}	
	HideMapList();
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	if (ds_ma == ""){
		
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "   <soapenv:Header/>";
		soapMessage += "   <soapenv:Body>";
		soapMessage += "      <ser:getLop>";
		soapMessage += "         <ser:ten_lop>" + ten_lop + "</ser:ten_lop>";
		soapMessage += "      </ser:getLop>";
		soapMessage += "   </soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
		
	}else{
		//alert("cap: "+cap+" - ds_ma: "+ds_ma+" -ten_lop: "+ten_lop);
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "   <soapenv:Header/>";
		soapMessage += "   <soapenv:Body>";
		soapMessage += "      <ser:find_place_by_text_and_lop>";
		soapMessage += "         <ser:str_id>"+ds_ma+"</ser:str_id>";
		soapMessage += "         <ser:ten_lop>"+ten_lop+"</ser:ten_lop>";
		soapMessage += "         <ser:cap>"+cap+"</ser:cap>";
		soapMessage += "      </ser:find_place_by_text_and_lop>";
		soapMessage += "   </soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
	}	
	
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_getLopDiaDiem,
		error : error_getLopDiaDiem,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function getQuanHuyen(){
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getQuanHuyen>";
	soapMessage += "      </ser:getQuanHuyen>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	//alert(soapMessage);
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_getQuanHuyen,
		error : error_getQuanHuyen,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function getXaPhuong(mahuyen){
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getXaPhuong>"; 
	soapMessage += "      <ser:mahuyen>"+mahuyen+"</ser:mahuyen>";
	soapMessage += "      </ser:getXaPhuong>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	//alert(soapMessage);
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_getXaPhuong,
		error : error_getXaPhuong,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function getLopCoQuan() {
	// alert(ten_lop);
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getLop>";
	soapMessage += "         <ser:ten_lop>coquan</ser:ten_lop>";
	soapMessage += "      </ser:getLop>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_getLopCoQuan,
		error : error_getLopCoQuan,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}
function getLopBenhVien() {
	// alert(ten_lop);
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
	soapMessage += "   <soapenv:Header/>";
	soapMessage += "   <soapenv:Body>";
	soapMessage += "      <ser:getLop>";
	soapMessage += "         <ser:ten_lop>benhvien</ser:ten_lop>";
	soapMessage += "      </ser:getLop>";
	soapMessage += "   </soapenv:Body>";
	soapMessage += "</soapenv:Envelope>";
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_getLopBenhVien,
		error : error_getLopBenhVien,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function find_Place_Around_Streeet(street, text, radius) {			
	var soapMessage  = "<\?xml version='1.0' encoding='utf-8'\?>";
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "<soapenv:Header/>";
		soapMessage += "<soapenv:Body>";
		soapMessage += "  <ser:find_Place_Around_Street>";
		soapMessage += "     <ser:street>"+street+"</ser:street>";
		soapMessage += "     <ser:text>"+text+"</ser:text>";
		soapMessage += "     <ser:radius>"+radius+"</ser:radius>";
		soapMessage += "  </ser:find_Place_Around_Street>";
		soapMessage += "</soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
	//alert(soapMessage);	
	//alert("Bat dau goi dich vu...");
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Place_Around_Street,
		error : error_Find_Place_Around_Street,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function find_Street_By_Name(text) {			
	var soapMessage  = "<\?xml version='1.0' encoding='utf-8'\?>";
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "   <soapenv:Header/>";
		soapMessage += "   <soapenv:Body>";
		soapMessage += "      <ser:find_Street_By_Name>";
		soapMessage += "         <ser:ten_duong>"+text+"</ser:ten_duong>";
		soapMessage += "      </ser:find_Street_By_Name>";
		soapMessage += "   </soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
		//alert(soapMessage);	
	//alert("Bat dau goi dich vu...");
	$.ajax({
		type : 'POST',
		url : url,
		cache : false,
		success : callBack_Find_Street_By_Name,
		error : error_Find_Street_By_Name,
		dataType : 'xml',// kieu du lieu tra ve (response)
		contentType : 'text/xml; charset=\"utf-8\"', // kieu du lieu gui di
		// (request)
		data : soapMessage
	});
}

function callBackGetDuongDi(xml_result, status) {

	// list_lop_duong = map.getLayersByName('lop_duong_di');
	lop_duong_di = map.getLayersByName('lop_duong_di')[0];
	// xoa cac feature cu tren lop duong di
	lop_duong_di.destroyFeatures();// xoa di cac feature hien tai tren lop
	// duong di
	var wkt_format = new OpenLayers.Format.WKT();
	var result = " <ol class='stepsList'>";
	var tenduong;
	var dodai;
	var tongdodai = 0;
	var direction="";
	var li;
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		//alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue);
		li = "";
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		tenduong = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		dodai = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		direction = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		tongdodai = (tongdodai * 1) + (dodai * 1);
		lop_duong_di.addFeatures(wkt_format.read(wkt));
		li= li+ "<li id='li' class='result-path-item'>" + "<a>" +(i+1)+ ".</a>"+
					"<span class='instruction'>" + 
						"<span>" +
							"<pan class='instructionKeyword'>" + direction + " "  + tenduong +"</span>" +
						"</span" +
					"</span" +
					"<span class='distance'>"+ Math.round(dodai)+" m</span>" +
				"</li>";	
		result= result + li;
	}
	
	result= result + "</ol>";
	tongdodai= "<div class='sumary'>" +
			"<div class='sumary-item'>Tong do dai: "+ Math.round(tongdodai) + " m</div>" +
			"<div class='sumary-item'>Di qua: "+ (xml_result.getElementsByTagName('ns:return').length) + " con duong.</div>" +
			"</div>";
	result=tongdodai+result;
	$('.search-result').html(result);
	/*
	 * var gml =
	 * xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
	 * var gml_format = new OpenLayers.Format.GML();
	 */
	 $('.btn-lo-trinh').show();
	 showLeftContent1();
}
/*******************************************************************************
 * Khi co loi xay ra: tao duong thang noi truc tiep giua start_point va
 * end_point Hien thi duong thang vua tao va tinh do dai cua no Xoa cac feature
 * tren lop_duong_di
 ******************************************************************************/
function errorGetDuongDi(xml_error) {	
	// lay ra hai diem duoc chon
	lop_diem_chon = map.getLayersByName("lop_diem_chon")[0];
	// lop_diem_chon = list_lop_diem_chon[0];
	num_points = lop_diem_chon.features.length;
	if (num_points == 2) {
		// lay toa do hai diem duoc chon
		var start_point = lop_diem_chon.features[0].geometry.clone();
		var end_point = lop_diem_chon.features[1].geometry.clone();
		// tao mot linestring moi noi start_point va end_point
		line_string = new OpenLayers.Geometry.LineString([ start_point,
				end_point ]);
		// alert("line_string: "+line_string);
		// khoi tao doi tuong parser Well-Know-Text de doc chuoi linestring vua
		// tao
		wkt_format = new OpenLayers.Format.WKT();
		// lay ra lop duong di
		lop_duong_di = map.getLayersByName("lop_duong_di")[0];
		// xoa tat ca cac features cu tren lop duong di
		lop_duong_di.destroyFeatures();
		// hien thi chuoi linestring vua tao len lop_duong di
		lop_duong_di.addFeatures(wkt_format.read(line_string));
		// tinh do dai cua chuoi line string vua tao
		var do_dai = line_string.getLength();
		//alert("Do dai duong di: " + do_dai + " m");
		$('.btn-lo-trinh').hide();
		$('.search-result').html("&nbsp&nbsp KhÃ´ng tÃ¬m Ä‘Æ°á»£c Ä‘Æ°á»�ng Ä‘i trÃªn Ä‘oáº¡n nÃ y.");
	}
}
function callBackGetDiaDiem(xml_result, status) {
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var ma="";
	var result = "<div class='SelectPlaceTitle' style='z-index: 848;'>"
			+ "<h3 class='SPTitText'>Hay chon vi tri cho diem </h3>"
			+ "<span class='idiem-a-icon TitFlag'>A</span>" + "</div>"
			+ "<br/> "
			+ "<div id='SelectPlaceContent' class='SelectPlaceContent' >";
	//alert("getDiaDiem thanh cong");
	list_lop_dia_diem = map.getLayersByName('lop_dia_diem');
	lop_dia_diem = list_lop_dia_diem[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();

	//alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;		
		ten = "<a id ='" + wkt + "' href='javascript:chonDiemA(" + "wkt" + ")' onclick= ''>" + ten + "</a>";	
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		diachi = "<br/>" + "<p> " + diachi + "</p>";
		// sodienthoai=xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		result = result + ten + diachi + "<br/>";
		lop_dia_diem.addFeatures(wkt_format.read(wkt));		
	}
	//dich chuyen ban do ve dia diem dau tien duoc tim thay
	//di chuyen diem dau tien ve trung tam cua ban do	
	var first_feature = lop_dia_diem.features[0].geometry;
	var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
	//map.setCenter(lonlat);
	result = result + " </div>";
	$('#searchPopupContent').html(result);

	// dong controlDrawFeature va control DragFeature, setDuongDi, xoa duong di cu
	
}
function errorGetDiaDiem(xml_error) {
	alert("Loi getDiaDiem");
}

function callBackGetDiaDiemTheoViTri(xml_result, status) {
	//lay ra thong tin tu tap tin xml
	ten = xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
	diachi = xml_result.getElementsByTagName('ns:return')[1].childNodes[0].nodeValue;
	sodienthoai = xml_result.getElementsByTagName('ns:return')[2].childNodes[0].nodeValue;
	x = xml_result.getElementsByTagName('ns:return')[3].childNodes[0].nodeValue;
	y = xml_result.getElementsByTagName('ns:return')[4].childNodes[0].nodeValue;
	ma = xml_result.getElementsByTagName('ns:return')[5].childNodes[0].nodeValue;
	if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
	if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
	//tao noi dung cho popup
	var content= "<div class = 'maker-popup-ten "+ma+"'>" + ten +"</div>" + 	
	"<div class='maker-popup-div1'> " +
		"<div class = 'maker-popup-diachi'>"+ diachi + "</div>"+
		"<div class = 'maker-popup-sdt'>"+ sodienthoai + "</div>" +
		"<div class = 'maker-popup-footer' > " +
			"<a class='maker-popup-tuday' href='javascript:popup_TuDay("+ x +","+ y +")'>Tá»« Ä‘Ã¢y</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-denday' href='javascript:popup_DenDay("+ x +","+ y +")'>Ä�áº¿n Ä‘Ã¢y</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-phongto' href='javascript:popup_PhongTo("+ x +","+ y +")'>PhÃ³ng to</a>&nbsp&nbsp&nbsp" +
			"<a class='maker-popup-timxungquanh' href='javascript:popup_TimXungQuanh()'>TÃ¬m xung quanh</a>" +
		"</div>"+
	"</div> " +
	"<div class='maker-popup-div2'> " +
		"<!--div  class  = 'maker-popup-timdv'>TÃ¬m dá»‹ch vá»¥ á»Ÿ gáº§n vá»‹ trÃ­ nÃ y</div-->" +
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
	var lonlat = new OpenLayers.LonLat(x, y);
	//khai bao popup--> cho nay co the thanh lap han createPopup(content,lolat);
	var popup = new OpenLayers.Popup.FramedCloud("chicken", lonlat,
				new OpenLayers.Size(100, 100), content, null, true);
	//them popup vao ban do
	map.addPopup(popup, true);
	//dich chuyen tam ban do ve diem duoc chon
	//map.setCenter(lonlat, 6, false, false);
	$('#txt_bk').bind("keypress",function (e) {
        //if the letter is not digit then display error and don't type anything
        if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57)) {
            return false;
        }
	});	
}
function errorGetDiaDiemTheoViTri(xml_error) {
	alert("Loi find_Info_Of_Point");
}
/*
function chonDiemA(d) {
	alert(d);
}
*/
function callBack_Find_Place_By_Text(xml_result,status){
	//alert("Thanh cong");	
	var wkt="";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var ma="";
	var result = "<div class='SelectPlaceTitle' style='z-index: 848;'>"
			+ "<h3 class='SPTitText'>Hay chon vi tri cho diem</h3>"
			+ "<span class='idiem-a-icon TitFlag'>A</span>" + "</div>"
			+ "<br/> "
			+ "<div id='SelectPlaceContent' class='SelectPlaceContent' >";
	// alert("getDiaDiem thanh cong");
	//list_lop_dia_diem = map.getLayersByName('lop_dia_diem');
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();
	//alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		ten = "<div class= 'result-div'>" +
				"<a name='"+ten+"' class = 'popup-result result_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonDiemA("+i+");' >" + ten + "</a>";		
		diachi = "<div class= 'diachi-result'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
		//lop_dia_diem.addFeatures(wkt_format.read(wkt));
		if (lop_dia_diem.features.length >0 ){
			//di chuyen diem dau tien ve trung tam cua ban do	
			var first_feature = lop_dia_diem.features[0].geometry;
			var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
			map.setCenter(lonlat);
		}
	}
	
	result = result + " </div>";
	$('#searchPopupContent').html(result);
	// dong controlDrawFeature va control DragFeature, setDuongDi, xoa duong di cu
	
}
function callBack_Find_Place_By_Text_And_Huyen(xml_result,status){
	//alert("Thanh cong");	
	var wkt="";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var result = "";
	var ma="";
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();
	//alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		lop_dia_diem.addFeatures(wkt_format.read(wkt));	
		if (lop_dia_diem.features.length >0 ){
			//di chuyen diem dau tien ve trung tam cua ban do	
			var first_feature = lop_dia_diem.features[0].geometry;
			var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
			map.setCenter(lonlat);
		}
		ten = "<div class= 'result-div'>" +
		"<a name='"+ten+"' class = 'popup-result result3_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonViTri("+i+");' >" + ten + "</a>";		
		diachi =      "<div class= 'diachi-result diachi_"+i+"'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result sodienthoai_"+i+"'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
	}
	result="<div class='sodiadiem'>Tim thay: "+ (xml_result.getElementsByTagName('ns:return').length) + " ket qua.</div>" +
			"<a class='link' id='clearSearchResultText' title='Xoa ket qua'>Xoa ket qua</a>" +
			"<div class='result-diadiem'>" +
			result +
			"</div>";
	$("#tab_content2").html(result);
	showLeftContent2();
}
function callBack_Find_Place_By_Text_And_Xa(xml_result,status){
	//alert("Thanh cong");	
	var wkt="";	
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var result = "";
	var ma="";
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();
	//alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		lop_dia_diem.addFeatures(wkt_format.read(wkt));	
		if (lop_dia_diem.features.length >0 ){
			//di chuyen diem dau tien ve trung tam cua ban do	
			var first_feature = lop_dia_diem.features[0].geometry;
			var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
			map.setCenter(lonlat);
		}
		ten = "<div class= 'result-div'>" +
		"<a name='"+ten+"' class = 'popup-result result3_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonViTri("+i+");' >" + ten + "</a>";		
		diachi =      "<div class= 'diachi-result diachi_"+i+"'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result sodienthoai_"+i+"'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
	}
	result="<div class='sodiadiem'>Tim thay: "+ (xml_result.getElementsByTagName('ns:return').length) + " ket qua.</div>" +
			"<a class='link' id='clearSearchResultText' title='Xoa ket qua'>Xoa ket qua</a>" +
			"<div class='result-diadiem'>" +
			result +
			"</div>";
	$("#tab_content2").html(result);
	showLeftContent2();
}
function callBack_Find_Place_By_Text2(xml_result,status){
	//alert("Thanh cong");	
	var wkt="";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";	
	var ma="";
	var result = "<div class='SelectPlaceTitle' style='z-index: 848;'>"
			+ "<h3 class='SPTitText'>Hay chon vi tri cho diem</h3>"
			+ "<span class='idiem-a-icon TitFlag'>B</span>" + "</div>"
			+ "<br/> "
			+ "<div id='SelectPlaceContent2' class='SelectPlaceContent2' >";
	// alert("getDiaDiem thanh cong");
	//list_lop_dia_diem = map.getLayersByName('lop_dia_diem');
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();
	//alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		ten = "<div class= 'result-div'>" +
				"<a name='"+ten+"' class = 'popup-result result2_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonDiemB("+i+");' >" + ten + "</a>";		
		diachi = "<div class= 'diachi-result'>" + diachi + "</div>";		
		sodienthoai = "<div class= 'sodienthoai-result'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
		//lop_dia_diem.addFeatures(wkt_format.read(wkt));
		if (lop_dia_diem.features.length >0 ){
			//di chuyen diem dau tien ve trung tam cua ban do	
			var first_feature = lop_dia_diem.features[0].geometry;
			var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
			map.setCenter(lonlat);
		}
	}
	
	result = result + " </div>";
	$('#searchPopupContent2').html(result);
	// dong controlDrawFeature va control DragFeature, setDuongDi, xoa duong di cu
	
}
function error_Find_Place_By_Text(xml_result){
	alert("Loi: error_Find_Place_By_Text");
}
function error_Find_Place_By_Text_And_Huyen(xml_result){
	alert("Loi: error_Find_Place_By_Text_And_Huyen");
}
function error_Find_Place_By_Text_And_Xa(xml_result){
	alert("Loi: error_Find_Place_By_Text_And_Xa");
}
function error_Find_Place_By_Text2(xml_result){
	alert("Loi: error_Find_Place_By_Text2");
}


function callBack_getLopDiaDiem(xml_result, status) {
	var wkt = "";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var result ="";
	var ma="";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {

		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;		
		ma=xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;		
		lop_dia_diem.addFeatures(wkt_format.read(wkt));
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		ten = "<div class= 'result-div'>" +
		"<a name='"+ten+"' class = 'popup-result result3_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonViTri("+i+");' >" + ten + "</a>";		
		diachi =      "<div class= 'diachi-result diachi_"+i+"'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result sodienthoai_"+i+"'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
	}		
	result= "<div class='sodiadiem'>TÃ¬m tháº¥y: "+ (xml_result.getElementsByTagName('ns:return').length) + " káº¿t quáº£.</div>" +
			"<a class='link' id='clearSearchResultText' title='XÃ³a káº¿t quáº£'>XÃ³a káº¿t quáº£</a>" +
			"<div class='result-diadiem'>" +
			result +
			"</div>";
	$("#tab_content2").html(result);
	showLeftContent2();
	if (lop_dia_diem.features.length >0 ){
		//di chuyen diem dau tien ve trung tam cua ban do	
		var first_feature = lop_dia_diem.features[0].geometry;
		var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
		map.setCenter(lonlat);
	}
}
function error_getLopDiaDiem(xml_result) {
	//loi khong tim thay du lieu
}
function callBack_Find_Place_Around_Point(xml_result, status){
	var wkt = "";
	var ten = "";
	var diachi = "";
	var sodienhoai = "";
	var result = "";
	var ma="";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];	
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		lop_dia_diem.addFeatures(wkt_format.read(wkt));
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		ten = "<div class= 'result-div'>" +
		"<a name='"+ten+"' class = 'popup-result result3_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonViTri("+i+");' >" + ten + "</a>";		
		diachi =      "<div class= 'diachi-result diachi_"+i+"'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result sodienthoai_"+i+"'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
	}
	result="<div class='sodiadiem'>Tim thay: "+ (xml_result.getElementsByTagName('ns:return').length) + " ket qua.</div>" +
			"<a class='link' id='clearSearchResultText' title='Xoa ket qua'>Xoa ket qua</a>" +
			"<div class='result-diadiem'>" +
			result +
			"</div>";
	$("#tab_content2").html(result);
	showLeftContent2();
}







function error_Find_Place_Around_Point(xml_result, status){
	alert("Find_Place_Around_Point "+xml_result);
}
function callBack_getQuanHuyen(xml_result, status){
	var wkt = "";
	var id = "";
	var ten = "";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_quan_huyen = map.getLayersByName('lop_quan_huyen')[0];
	var result="";
	var html="";
	// xoa di cac feature hien tai tren lop duong di
	//lop_quan_huyen.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		//lop_quan_huyen.addFeatures(wkt_format.read(xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue));
		id = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		result="<div class='dTreeNode'>" +
				"<input value='"+id+"' type='checkbox' class='check-item'> " +
				"<a value='"+id+"'  name='"+ten+"' class = 'tenhuyen-item huyen_"+i+"' href='javascript:clickHuyen("+i+");'>"+ten+"</a>" +
				"</div>";
		html=html+result;
	}
	$('#tree_Huyen').html(html);
	$("#map_path_div").attr("name","huyen");
	$("#map_path_div").html("<a class = 'cantho'  href='javascript:getQuanHuyen()'>Cáº§n ThÆ¡</a>");
	$("#map_path_div2").html("<a class = 'cantho'  href='javascript:getQuanHuyen()'>Cáº§n ThÆ¡</a>");
}
function callBack_getXaPhuong(xml_result, status){
	var wkt = "";
	var id = "";
	var ten = "";
	var result="";
	var html="";
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		id = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		result="<div class='dTreeNode'>" +
				"<input name='check"+i+"' value='"+id+"' type='checkbox' class='check-item check"+i+"'> " +
				"<a value='"+id+"'  name='"+ten+"' class = 'tenxa-item xa_"+i+"' href='javascript:clickXa("+i+");'>"+ten+"</a>" +
				"</div>";
		html=html+result;
	}
	$('#tree_Huyen').html(html);
}
function error_getQuanHuyen(xml_result, status){
	alert("getQuanHuyen:  "+xml_result);
}
function error_getXaPhuong(xml_result, status){
	alert("getXaPhuong:  "+xml_result);
}
function callBack_getLopCoQuan(xml_result, status) {
	var wkt = "";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_co_quan = map.getLayersByName('lop_co_quan')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_co_quan.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {

		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;		
		lop_co_quan.addFeatures(wkt_format.read(wkt));
	}		
}
function error_getLopCoQuan(xml_result) {
	//loi khong tim thay du lieu
	alert("Error: Webservice - error_getLopCoQuan");
}

function callBack_getLopBenhVien(xml_result, status) {
	var wkt = "";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_benh_vien = map.getLayersByName('lop_benh_vien')[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_benh_vien.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {

		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		/*
		var feature = new OpenLayers.Feature.Vector(wkt_format.read(wkt).geometry);
        feature.attributes = {
            name: ten
        };
        */
		lop_benh_vien.addFeatures(wkt_format.read(wkt));
	}		
}
function error_getLopBenhVien(xml_result) {
	//loi khong tim thay du lieu
	alert("Error: Webservice - error_getLopBenhVien");
}
function callBack_Find_Address_XP_QH_A(xml_result, status){
	var diachi = xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
	$(".tim-a").val(diachi);	
}
function error_Find_Address_XP_QH_A(xml_result) {
	//loi khong tim thay du lieu
	alert("Error: Webservice - error_Find_Address_XP_QH_A");
}
function callBack_Find_Address_XP_QH_B(xml_result, status){
	var diachi = xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
	$(".tim-b").val(diachi);
}
function error_Find_Address_XP_QH_B(xml_result) {
	//loi khong tim thay du lieu
	alert("Error: Webservice - error_Find_Address_XP_QH_B");
}
function callBack_Find_Place_Around_Street(xml_result, status){
	var wkt="";
	var ten = "";
	var diachi = "";
	var sodienthoai = "";	
	var result = "";
	var ma="";
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	// xoa di cac feature hien tai tren lop duong di
	//lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();	
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		sodienthoai = xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[4].childNodes[0].nodeValue;
		if(diachi==" " || diachi==null) {diachi = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		if(sodienthoai==" " || sodienthoai==null){ sodienthoai = "KhÃ´ng cÃ³ thÃ´ng tin.";}
		ten = "<div class= 'result-div'>" +
		"<a name='"+ten+"' class = 'popup-result result3_"+i+" "+ma+"' id ='" + wkt + "' href='javascript:chonViTri("+i+");' >" + ten + "</a>";		
		diachi =      "<div class= 'diachi-result diachi_"+i+"'>" + diachi + "</div>";
		sodienthoai = "<div class= 'sodienthoai-result sodienthoai_"+i+"'>" + sodienthoai + "</div>";
		result = result + ten + diachi + sodienthoai + "</div>";
		lop_dia_diem.addFeatures(wkt_format.read(wkt));
		if (lop_dia_diem.features.length >0 ){
			//di chuyen diem dau tien ve trung tam cua ban do	
			var first_feature = lop_dia_diem.features[0].geometry;
			var lonlat = new OpenLayers.LonLat(first_feature.x,first_feature.y);
			map.setCenter(lonlat);
		}
	}	
	result="<div class='sodiadiem'>Tim thay: "+ (xml_result.getElementsByTagName('ns:return').length) + " ket qua.</div>" +
	"<a class='link' id='clearSearchResultText' title='Xoa ket qua'>Xoa ket qua</a>" +
	"<div class='result-diadiem'>" +
	result +"</div>";
	$("#tab_content2").html(result);
	showLeftContent2();
}
function error_Find_Place_Around_Street(xml_result, status){
	alert("Error: Find_Place_Around_Street "+xml_result);
}
function callBack_Find_Street_By_Name(xml_result, status){
	var wkt = "";
	var ma = "";
	var ten = "";
	var result = "";
	var wkt_format = new OpenLayers.Format.WKT();
	var lop_dia_diem = map.getLayersByName('lop_dia_diem')[0];
	lop_dia_diem.destroyFeatures();
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ma = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		//lop_dia_diem.addFeatures(wkt_format.read(wkt));
		result= result + "<div class='result-duong-item'> <a class = 'tenduong-result duongdi_"+i+"' id ='" + ma + "$"+ wkt + "' href='javascript:chonConDuong("+i+");' >Đường " + ten + "</a></div> ";
	}
	result="<div class='sodiadiem'>Tim thay: "+ (xml_result.getElementsByTagName('ns:return').length) + " ket qua.</div>" +
	"<a class='link' id='clearSearchResultText' title='Xoa ket qua'>Xoa ket qua</a>" +
	"<div class='result-duongdi'>" +
	result +"</div>";
	$("#tab_content3").html(result);
	showLeftContent3();
}
function error_Find_Street_By_Name(xml_result, status){
	alert("Error: Find_Street_By_Name "+xml_result);
}