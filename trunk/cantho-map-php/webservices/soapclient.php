<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Soap Client</title>
</head>
<script language="javascript" src="../libs/jquery/jquery-1.4.4.js"></script>
<script language="javascript" src="../libs/soap/soapclient.js"></script>
<script language="javascript">
$(document).ready(function(){
							$("#btn_reverse").click(function(){
															 Reverse();
															 });
						   });
var url = "http://localhost/cantho-map/webservices/cantho_services.php";

function Reverse()
{
	var pl = new SOAPClientParameters();
	pl.add('start_x',585963.32538);
	pl.add('start_y',1111336.23539);
	pl.add('end_x',585564.5571);
	pl.add('end_y',1110794.75344);
	SOAPClient.invoke(url, "find_Shortest_Path", pl, true, reverseCallBack);
} 
function reverseCallBack(data)
{	
	alert(data);
}
</script>
<body>
<input type="button" value="Reverse" id="btn_reverse"/>
</body>
</html>