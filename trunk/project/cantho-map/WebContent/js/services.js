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
	// alert('request: ' + soapMessage);
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
	soapMessage += "      <ser:getDiaDiemTheoViTri>";
	soapMessage += "         <ser:the_geom_point>" + the_geom_point
			+ "</ser:the_geom_point>";
	soapMessage += "      </ser:getDiaDiemTheoViTri>";
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
		// (request)
		data : soapMessage
	});

}

function callBackGetDuongDi(xml_result, status) {

	list_lop_duong = map.getLayersByName('lop_duong_di');
	lop_duong_di = list_lop_duong[0];
	// xoa cac feature cu tren lop duong di
	lop_duong_di.destroyFeatures();// xoa di cac feature hien tai tren lop
	// duong di
	var wkt_format = new OpenLayers.Format.WKT();
	var result = " <ol class='stepsList'>";
	var tenduong;
	var dodai;
	var tongdodai = 0;
	var li;
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {
		// alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue);
		li = "";
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		tenduong = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		dodai = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		tongdodai = (tongdodai * 1) + (dodai * 1);
		lop_duong_di.addFeatures(wkt_format.read(wkt));
		li = li + "<li id='li' class='li'>" + "<span class='instruction'>"
				+ "<span>" + "<pan class='instructionKeyword'>" + tenduong
				+ "</span>" + "</span" + "</span" + "<span class='distance'>"
				+ Math.round(dodai) + " m</span>" + "</li>";
		result = result + li;
	}

	result = result + "</ol>";
	tongdodai = "<p class='total-length'>Tá»•ng Ä‘á»™ dÃ i: "
			+ Math.round(tongdodai) + " m</p>";
	result = tongdodai + result;
	$('.search-result').html(result);
	/*
	 * var gml =
	 * xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
	 * var gml_format = new OpenLayers.Format.GML();
	 */
}
/*******************************************************************************
 * Khi co loi xay ra: tao duong thang noi truc tiep giua start_point va
 * end_point Hien thi duong thang vua tao va tinh do dai cua no Xoa cac feature
 * tren lop_duong_di
 ******************************************************************************/
function errorGetDuongDi(xml_error) {
	// alert("Noi hai diem lai");
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
		alert("Do dai duong di: " + do_dai + " m");
	}
}
function callBackGetDiaDiem(xml_result, status) {
	var ten = "";
	var diachi = "";
	var sodienthoai = "";
	var result = "<div class='SelectPlaceTitle' style='z-index: 848;'>"
			+ "<h3 class='SPTitText'>HÃ£y chá»�n vá»‹ trÃ­ cho Ä‘iá»ƒm</h3>"
			+ "<span class='idiem-a-icon TitFlag'>A</span>" + "</div>"
			+ "<br/> "
			+ "<div id='SelectPlaceContent' class='SelectPlaceContent' >";
	// alert("getDiaDiem thanh cong");
	list_lop_dia_diem = map.getLayersByName('lop_dia_diem');
	lop_dia_diem = list_lop_dia_diem[0];
	// xoa di cac feature hien tai tren lop duong di
	lop_dia_diem.destroyFeatures();
	var wkt_format = new OpenLayers.Format.WKT();

	// alert("status: "+status);
	for (i = 0; i < xml_result.getElementsByTagName('ns:return').length; i++) {

		// alert(xml_result.getElementsByTagName('ns:return').length);
		// alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue);
		wkt = xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
		ten = xml_result.getElementsByTagName('ns:return')[i].childNodes[1].childNodes[0].nodeValue;
		// wkt="'"+wkt+"'";
		ten = "<a id ='" + wkt + "' href='javascript:chonDiemA(" + "wkt" + ")' onclick= ''>" + ten + "</a>";
		// alert(ten);
		diachi = xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue;
		diachi = "<br/>" + "<p> " + diachi + "</p>";
		// sodienthoai=xml_result.getElementsByTagName('ns:return')[i].childNodes[3].childNodes[0].nodeValue;
		result = result + ten + diachi + "<br/>";
		lop_dia_diem.addFeatures(wkt_format.read(wkt));
	}
	result = result + " </div>";
	$('#searchPopupContent').html(result);

	// dong controlDrawFeature va control DragFeature, setDuongDi, xoa duong di cu

	reset_DuongDi();
	
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
	
	//tao noi dung cho popup
	var content = "Ten : " + ten;	
	var lonlat = new OpenLayers.LonLat(x, y);
	//khai bao popup--> cho nay co the thanh lap han createPopup(content,lolat);
	var popup = new OpenLayers.Popup.FramedCloud("chicken", lonlat,
				new OpenLayers.Size(100, 100), content, null, true, onClosePopup);
	//them popup vao ban do
	map.addPopup(popup, true);
	//dich chuyen tam ban do ve diem duoc chon
	map.setCenter(lonlat, 6, false, false);
}
function onClosePopup(e){
	//xoa popup tai day	
	alert(e);
}
function errorGetDiaDiemTheoViTri(xml_error) {
	alert("Loi getDiaDiemTheoViTri");
}
function chonDiemA(d) {
	alert(d);
}