<?php
require_once('connection.php');
require_once('functions.php');
require_once('../php/nusoap/nusoap.php'); 

/*Dang ky dich vu*/
$server = new nusoap_server;
 
$server->configureWSDL('Can Tho Map Services', 'urn:server');
 
$server->wsdl->schemaTargetNamespace = 'urn:server';
 
/**
*Mo ta: Tim duong di ngan nhat tu hai diem cho truoc
*@param1: $start_x: lon
*@param2: $start_y: lat
*@param3: $end_x: lon
*@param4: $end_y: lat
*@return: $shortest_path: array
*/
function find_Shortest_Path($start_x,$start_y,$end_x,$end_y)
{
		$startPoint = array($start_x, $start_y);
		$endPoint = array($end_x, $end_y);
		// Find the nearest edge
		$startEdge = findNearestEdge($startPoint);
		$endEdge = findNearestEdge($endPoint);
		$conn=pg_connect(" host=".PG_HOST." port=".PG_PORT." dbname=".PG_DB." user=".PG_USER." password=".PG_PASSWORD);
		$sql = "SELECT rt.gid, rt.the_geom ,
		length(rt.the_geom) AS length, gt.gid, gt.ten_duong
		FROM giaothong gt,
		(SELECT gid, the_geom
		FROM dijkstra_sp_delta(
		'giaothong',
		".$startEdge['source'].",
		".$endEdge['target'].",0.1)
		) as rt
		WHERE gt.gid=rt.gid;";
		//echo $sql;	
		// Perform database query
		$result = pg_query($conn,$sql);
		//return pg_num_rows($result);
		$shortest_path=pg_fetch_all($result);
		pg_close($conn);
		return $shortest_path;
}
$server->register('find_Shortest_Path',
			array('start_x' => 'xsd:double',
				  'start_y' => 'xsd:double',
				  'end_x' => 'xsd:double',
				  'end_y' => 'xsd:double'),
			array('return' => 'xsd:Array'),
			'urn:server',
			'urn:server#find_Shortest_Path');


/**
*Mo ta: Tim duong di ngan nhat tu hai diem cho truoc
*@param1: $a: int
*@param2: $b: int
*@return: $result: int
*/

function add($a,$b)
{
	return $a+$b;
}

$server->register('add',
				  array('a'=>'xsd:int','b'=>'xsd:int'),
				  array('result'=>'xsd:int'),
				  'urn:server',
				  'urn:server#add'
				  );
$HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA : '';
$server->service($HTTP_RAW_POST_DATA);
?>