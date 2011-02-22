<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<script language="javascript" src="../libs/jquery/jquery-1.4.4.js"></script>
<script language="javascript" defer="defer">
$(document).ready(function(){
						   $("#btn_reverse").click(function(){
															 callWebservice($("#txt_str").val());
															 });
						   });//end function $(document).ready(function()
//var url = 'http://localhost/cantho-map/webservice/server.php?wsdl'; 
var url = 'http://localhost/cantho-map/webservices/service.php?wsdl';
function callWebservice(str) /*Add parameters and what not*/ { 
 /*
    //Example of a xml request probably put this is the parameter 
	var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	soapMessage += "<soapenv:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http:";
	soapMessage += "//www.w3.org/2001/XMLSchema' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:server'>";
   soapMessage += " <soapenv:Header/>";
   soapMessage += " <soapenv:Body>";
   soapMessage += "  <urn:pollServer soapenv:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'>";
   soapMessage += "      <value xsi:type='xsd:string'>Good</value>";
   soapMessage += "   </urn:pollServer>";
   soapMessage += " </soapenv:Body>";
   soapMessage += " </soapenv:Envelope>";
   */
   var soapMessage = "<\?xml version='1.0' encoding='utf-8'\?>";
	   soapMessage += "<soapenv:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'      	   xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'>";
       soapMessage += "<soapenv:Header/>";
       soapMessage += " <soapenv:Body>";
       soapMessage += "<Reverse soapenv:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'>";
       soapMessage += "  <text xsi:type='xsd:string'>"+str+"</text>";
       soapMessage += "</Reverse>";
       soapMessage += "</soapenv:Body>";
	   soapMessage += "</soapenv:Envelope>";
	//alert('request: '+soapMessage); 
    $.ajax({ 
        type: 'POST', 
        url: url, 
        cache: false, 
        success: function(data){ 
            //var xml = data.xml; 
			var xml=$(data);
			//xml.find("return").text();
            //[do something with the xml] 
			//alert('ket qua: '+xml.find("result").text());
			$("#lbl_result").html("Ket qua: "+xml.find("result").text());
        }, 
        error: function(data){ 
            var xml = $(data); 
            //[do something with the xml] 
			//alert('Loi : '+xml.find("faultstring").text());
			$("#lbl_result").html('Ket qua : ');
        }, 
		dataType: 'xml',// kieu du lieu tra ve (response)
        contentType: 'text/xml', //kieu du lieu gui di (request)
        data: soapMessage 
    }); 
} 
</script>
<body>
<input id="btn_reverse" type="button" value="Dao chuoi" />
<input id="txt_str" type="text"/>
<label id="lbl_result">Ket qua: </label>
</body>
</html>