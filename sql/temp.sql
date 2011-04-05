-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim dich vu xung quanh lo trinh
CREATE OR REPLACE FUNCTION find_place_around_street(str text, t text, radius float ) 
 RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    str_geometry geometry;
	BEGIN
	    str_geometry := ST_GeomFromText(str,4326);
	    FOR r IN SELECT *                       		   FROM coquan           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT *                       		   FROM truong           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT *                       		   FROM benhvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT *                       		   FROM khachsan         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT *                       		   FROM congty           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT *                       		   FROM giaitri          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT *                       		   FROM denchua          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT *                       		   FROM buudien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT *                       		   FROM nganhang         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT *                       		   FROM thuvien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
