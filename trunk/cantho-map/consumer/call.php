<?php 
header("Content-Type: text/xml; charset=utf-8"); 
include('../nusoap/nusoap.php'); 
$query = isset($HTTP_RAW_POST_DATA)? $HTTP_RAW_POST_DATA : 0; 
$sp = new soap_parser($query, 'UTF-8', 'POST'); 
$text=$sp->buildVal(3); 
$c = new soapclient('http://localhost/cantho-map/provider/service.php/Reverse'); 
$c->call('Reverse', array('text'=>$text)); echo $c->responseData; ?>