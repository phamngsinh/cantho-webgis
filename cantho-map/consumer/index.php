<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bản đồ thành phố cần thơ </title>
</head>
<style>
.rowheader
{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-weight:bold;
	font-size:20px;
	color:#BF0000;
	height:50px
}

.controltitle
{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:11px;
}

.controltext
{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:11px;
	height:20px;
}
</style>
<script language="JavaScript">
function soap_request(oText) { 
		var s='<'+'?'+'xml version="1.0" encoding="UTF-8"'+'?'+'>'; 
		s+='<SOAP-ENV:Envelope '; 
		s+= ' xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"'; 
		s+= ' SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'; 
		s+= '<SOAP-ENV:Body>'; 
		s+= '<sn:ReverseRequest xmlns:sn="http://snlibs.googlepages.com/schema.xml">'; 
		s+= '<sn:text>'+oText+'</sn:text>'; 
		s+= '</sn:ReverseRequest>'; 
		s+= '</SOAP-ENV:Body>'; 
		s+= '</SOAP-ENV:Envelope>'; 
		var xmlhttp = request(); 
		xmlhttp.onreadystatechange = function(){ 
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
		 		setResult(xmlhttp.responseText); 
		 	} 
		} 
		xmlhttp.open("POST", "call.php",true); 
		xmlhttp.setRequestHeader("SOAPAction", 'http://localhost/cantho-map/provider/service.php/Reverse?wsdl'); 
		xmlhttp.setRequestHeader("Content-Type", "text/xml; charset=utf-8"); 
 		xmlhttp.setRequestHeader('Content-Length', s.length); xmlhttp.send(s);
}
function request() { 
	var req=null; 
	if (XMLHttpRequest) { 
		req=new XMLHttpRequest(); 
	} 
	else if (window.ActiveX) { 
		req=new ActiveXObject("Msxml2.XMLHTTP"); 
	if(!req) { 
		req=new ActiveXObject("Microsoft.XMLHTTP"); } 
	} 
	return req; 
}
function setResult(str) { 
	var r='',xmlDoc=null; 
	if(window.DOMParser){ 
		var parser = new DOMParser(); 
		xmlDoc = parser.parseFromString(str, "text/xml"); 
	} 
	else{ 
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); 
		xmlDoc.async="false"; xmlDoc.loadXML(str); 
	} 
	r = xmlDoc.getElementsByTagName('result')[0].childNodes[0].nodeValue; 
	document.f.result.value=r; 
	document.f.responseMsg.value=str; 
}

</script> 
<body>
<center>
<form action="#" method="post" name="f">
<table cellpadding="0" cellspacing="0" border="0" width="600px">
<tr><td align="center" class="rowheader" >Reverse String Web Service</td></tr>
<tr><td>
	<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr height="25px">
			<td align="right" class="controltitle">Text:</td>
			<td>&nbsp;<input type="text" name="text" class="controltext" style="width:310px" />&nbsp;<input type="button" value="SOAP Call" width="80px"  onclick="soap_request(this.form.text.value);" /></td>
		</tr>
		<tr height="25px">
			<td align="right" class="controltitle">Result:</td>
			<td>&nbsp;<input type="text" name="result" class="controltext" style="width:400px" /></td>
		</tr>
	</table>
</td></tr>
<tr><td class="controltitle" height="25px">Response Message</td></tr>
<tr><td class="controltitle" height="25px"><textarea name="responseMsg" rows="10" style="width:460px"></textarea></td></tr>
</table>
</form>
</center>
</body>
</html>
