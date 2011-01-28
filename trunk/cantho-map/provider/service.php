<?php 
include('../libs/nusoap.php'); 
$server = new soap_server(); 
$server->configureWSDL('Reverse String', 'uri:http://snlibs.googlepages.com/schema.xml'); 
function Reverse($s){ 
	$r='';
	for($i=1;$i<=strlen($s);$i++){ 
	$r.=substr($s,-$i,1); 
	} 
return $r; 
} 
$server->register("Reverse", array('text' => 'xsd:string'),array('result' => 'xsd:string')); 
$query = isset($HTTP_RAW_POST_DATA)? $HTTP_RAW_POST_DATA : ''; 
$server->service($query); 
?>