<?php
// Database connection settings	
	define("PG_HOST", "localhost");
	define("PG_PORT", "5432");
	define("PG_DB" , "postgis");
	define("PG_USER", "postgres");	
	define("PG_PASSWORD","admin");
	define("TABLE", "giaothong");
	
	$conn=pg_connect(" host=".PG_HOST." port=".PG_PORT." dbname=".PG_DB." user=".PG_USER." password=".PG_PASSWORD);
	$sql="Select * From ".TABLE;
	$result=pg_query($conn,$sql);
	
	//echo pg_num_rows($result);
	while ($row=pg_fetch_array($result))
	{
		echo $row['ma_duong']."</br>";
	}
?>