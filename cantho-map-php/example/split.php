<?php
	require_once('../webservices/connection.php');
// FUNCTION findNearestEdge
	/**Tim canh gan nhat tai mot diem
	*@param: $lonlat: lonlat
	*$return: $edge: array['gid','source','target','the_goem']
	*/
	function findNearestEdge($lonlat) 
	{
		// Connect to database
		$conn = pg_connect("dbname=".PG_DB." host=".PG_HOST." port=".PG_PORT." user=".PG_USER." password=".PG_PASSWORD);
		$sql = "SELECT gid, source, target, the_geom,
		distance(the_geom, GeometryFromText('POINT(".$lonlat[0]." ".$lonlat[1].")', 4326)) AS dist
				FROM giaothong
				WHERE the_geom && setsrid(
				'BOX3D(".($lonlat[0]-300)."
						".($lonlat[1]-300).",
						".($lonlat[0]+300)."
						".($lonlat[1]+300).")'::box3d, 4326)
		ORDER BY dist LIMIT 1";
		$query = pg_query($conn,$sql);
		//echo "co mau tin: ".pg_num_rows($query);
		$edge['gid'] = pg_fetch_result($query, 0, 0);
		$edge['source'] = pg_fetch_result($query, 0, 1);
		$edge['target'] = pg_fetch_result($query, 0, 2);
		$edge['the_geom'] = pg_fetch_result($query, 0, 3);
		// Close database connection
		//pg_close($conn);
		return $edge;
	}
	
	$conn = pg_connect("dbname=".PG_DB." host=".PG_HOST." port=".PG_PORT." user=".PG_USER." password=".PG_PASSWORD);
	
	$point=array(587009.25396,1110583.39668);
	//tim can gan nhat
	$nearest_edge=findNearestEdge($point);
	echo "1. Find nearest edge: Source: ".$nearest_edge['source'].": Target:".$nearest_edge['target']."</br>";

	//tim diem gan nhat nam tren canh vua tim
	$sql= "SELECT ST_AsText(ST_ClosestPoint(the_geom,ST_GeomFromText('POINT(".$point[0]."  ".$point[1].")',4326))) As the_geom
		  FROM giaothong
		  WHERE source=".$nearest_edge['source']." AND target=".$nearest_edge['target']."";
	$result=pg_query($conn,$sql);
	$nearest_point=pg_fetch_result($result,0,0);
	echo "2. Nearest point on the line: ".$nearest_point;
	
	//chia canh thanh hai canh voi tai vi tri cua diem vua tim
	
	
	
?>