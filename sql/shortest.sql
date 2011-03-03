/*
--Khong phan biet chieu 
SELECT * FROM shortest_path_astar('SELECT gid AS id,source::int4,
    target::int4, cost::double precision, rcost::double precision AS reverse_cost,
    x1,y1,x2,y2 FROM giaothong',1,45,false,false);

*/
--alter table giaothong add column length double precision;
--update giaothong
--set length=length(the_geom);

--co phan biet chieu duong di
/*
    DROP TABLE IF EXISTS dijsktra_result;

CREATE TABLE dijsktra_result(gid int4) with oids;

SELECT AddGeometryColumn('dijsktra_result', 'the_geom', '4326', 'MULTILINESTRING', 2);

INSERT INTO dijsktra_result(the_geom)
            --SELECT the_geom FROM dijkstra_sp('giaothong', 1, 35);
            
 
SELECT b.the_geom FROM shortest_path_astar('SELECT gid As id ,the_geom, source::int4,
     target::int4, cost::double precision, rcost::double precision AS reverse_cost,
     x1,y1,x2,y2 FROM giaothong',28,22,true,true) a, giaothong b
     Where a.edge_id=b.gid;     
*/
/*
SELECT b.gid as id, ST_AsGeoJSON(b.the_geom) As geojson, b.ten_duong, b.mot_chieu, b.cost As length
FROM shortest_path_astar('SELECT gid As id ,
				the_geom, 
				source::int4,
				target::int4, 
				cost::double precision, 
				rcost::double precision AS reverse_cost,
				x1,y1,x2,y2 
			FROM giaothong',37,16,true,true) a, giaothong b
     Where a.edge_id=b.gid;
*/

/*
--tim mot diem gan nhat voi diem duoc cho nam tren duong
SELECT ST_ClosestPoint(the_geom,ST_GeomFromText('POINT(587009.25396  1110583.39668)',4326)) As the_geom
	FROM giaothong
	WHERE source=23 AND target=25
*/

SELECT ST_AsText(ST_Split(mline, pt)) As wktcut
        FROM (SELECT 
    ST_GeomFromText('MULTILINESTRING((10 10, 190 190), (15 15, 30 30, 100 90))') As mline,
    ST_Point(30,30) As pt) As foo;
	
