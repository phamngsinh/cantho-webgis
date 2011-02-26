/**
 * 
 */
function callService(x1, y1, x2, y2) {

		/*
		x1 = 586406.15289;
		y1 = 1110178.56230;
		x2 = 586424.03201;
		y2 = 1110974.18319;
		 */
		var url1 = 'http://localhost:8888/cantho-service/services/CanThoMap?wsdl';
		//var url1 = "http://localhost:8888/axis2/services/CanThoMap?wsdl";
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
		//alert('request: ' + soapMessage);		
		$.ajax({
			type : 'POST',
			url : url1,
			cache : false,
			success : call_BackGetDuongDi,
			error : error_GetDuongDi,
			dataType : 'xml',// kieu du lieu tra ve (response)
			contentType : 'text/xml; charset=\"utf-8\"', //kieu du lieu gui di (request)
			data : soapMessage
		});
	}
	function call_BackGetDuongDi(xml_result, status) {
		
		list_lop_duong = map.getLayersByName('duong_di');
		lop_duong_di = list_lop_duong[0];
		//xoa cac feature cu tren lop duong di
		lop_duong_di.destroyFeatures();//xoa di cac feature hien tai tren lop duong di				
		var wkt_format=new OpenLayers.Format.WKT();		
		for (i=0;i<xml_result.getElementsByTagName('ns:return').length;i++){
			
			//alert(xml_result.getElementsByTagName('ns:return')[i].childNodes[2].childNodes[0].nodeValue);
			wkt=xml_result.getElementsByTagName('ns:return')[i].childNodes[0].childNodes[0].nodeValue;
			lop_duong_di.addFeatures(wkt_format.read(wkt));				
			
		}			
		/*
		var gml = xml_result.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue;
		var gml_format = new OpenLayers.Format.GML();
		*/		
	}
	function error_GetDuongDi(xml_result) {
		alert("Loi: "
				+ xml_result.getElementByTagName("faultstring")[0].childNodes[0].nodeValue);
	}