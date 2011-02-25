<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Client Axis</title>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"> </script>
<script type="text/javascript" src="libs/soap/soapclient.js"></script>
<script type="text/javascript" defer="defer">
	
	//var url = 'http://localhost/cantho-map/webservice/server.php?wsdl'; 
	$(document).ready(function(){		
		//alert("load jquery");
		$("#btn_callservice").click(function(){
			callWebservice();
			//call_Shortest_Path();
		});
	});
	function callWebservice() /*Add parameters and what not*/{		
		var url1 = 'http://localhost:8888/cantho-service/services/CanThoMap?wsdl';		
		
		var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
		soapMessage += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://services'>";
		soapMessage += "   <soapenv:Header/>";
		soapMessage += "   <soapenv:Body>";
		soapMessage += "      <ser:getDuongDi>";		 
		soapMessage += "         <ser:x1>585899.47137</ser:x1>";		         
		soapMessage += "         <ser:y1>1111277.80897</ser:y1>";		         
		soapMessage += "         <ser:x2>586099.65367</ser:x2>";		         
		soapMessage += "         <ser:y2>1111408.39041</ser:y2>";
		soapMessage += "      </ser:getDuongDi>";
		soapMessage += "   </soapenv:Body>";
		soapMessage += "</soapenv:Envelope>";
		//alert('request: ' + soapMessage);		
		$.ajax({
			type : 'POST',
			url : url1,
			cache : false,
			success : call_GetDuongDi,
			error : error_GetDuongDi,
			dataType : 'xml',// kieu du lieu tra ve (response)
			contentType : 'text/xml; charset=\"utf-8\"', //kieu du lieu gui di (request)
			data : soapMessage
		});
	}
	function call_GetDuongDi(xmlHttpRequest,status)
	{		
			//alert(xmlHttpRequest);							
			alert(xmlHttpRequest.getElementsByTagName('ns:return')[0].childNodes[0].nodeValue);
			//alert($(xmlHttpRequest));
	}
	function error_GetDuongDi(xml_result)
	{		
		alert("Loi: "+xml_result.getElementByTagName("ns:return")[0].childNodes[0].nodeValue);
	}	
</script>
</head>
<body onload="">
<input type="button" id="btn_callservice" value="Call Service" />
</body>
</html>