<?php
	// FUNCTION findNearestEdge
	/**Tim canh gan nhat tai mot diem
	*@param: $lonlat: lonlat
	*$return: $edge: array['gid','source','target','the_goem']
	*/
	function findNearestEdge($lonlat) 
	{
		// Connect to database
		$con = pg_connect("dbname=".PG_DB." host=".PG_HOST." port=".PG_PORT." user=".PG_USER." password=".PG_PASSWORD);
		$sql = "SELECT gid, source, target, the_geom,
		distance(the_geom, GeometryFromText(
		'POINT(".$lonlat[0]." ".$lonlat[1].")', 4326)) AS dist
		FROM ".TABLE."
		WHERE the_geom && setsrid(
		'BOX3D(".($lonlat[0]-0.1)."
		".($lonlat[1]-0.1).",
		".($lonlat[0]+0.1)."
		".($lonlat[1]+0.1).")'::box3d, 4326)
		ORDER BY dist LIMIT 1";
		$query = pg_query($con,$sql);
		$edge['gid'] = pg_fetch_result($query, 0, 0);
		$edge['source'] = pg_fetch_result($query, 0, 1);
		$edge['target'] = pg_fetch_result($query, 0, 2);
		$edge['the_geom'] = pg_fetch_result($query, 0, 3);
		// Close database connection
		pg_close($con);
		return $edge;
	}
?>