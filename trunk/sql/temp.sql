CREATE OR REPLACE FUNCTION find_place_around_street_unsigned(mult_str text, t text, radius float ) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
 RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    str_geometry geometry;
	    t2 text;
	    str text;
	    a text[];
	    n integer;
	    i integer;
	BEGIN
	    a:= string_to_array(mult_str,'$');
	    n:=array_upper(a,1);
	    FOR i IN 1 .. n LOOP
		str:= a[i];
		t2:= signed_to_unsigned(lower(t));
		str_geometry := ST_GeomFromText(str,4326);
		FOR r IN SELECT *                       		   FROM coquan           where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
		FOR r IN SELECT *                       		   FROM truong           where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
		FOR r IN SELECT *                       		   FROM benhvien         where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
		FOR r IN SELECT gid,ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
		FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
		FOR r IN SELECT *                       		   FROM khachsan         where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
		FOR r IN SELECT *                       		   FROM congty           where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
		FOR r IN SELECT *                       		   FROM giaitri          where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
		FOR r IN SELECT *                       		   FROM denchua          where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
		FOR r IN SELECT *                       		   FROM buudien          where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
		FOR r IN SELECT *                       		   FROM nganhang         where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
		FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
		FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
		FOR r IN SELECT *                       		   FROM thuvien          where lower(ten )like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    END LOOP;
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--drop function 'thu';
--SELECT regexp_split_to_array('the quick brown fox jumped over the lazy dog', E'\\s+');
--select string_to_array('xx~^~yy~^~zz', '~^~');
--select array_upper(regexp_split_to_array('the quick brown fox jumped over the lazy dog', E'\\s+') , 1);
--select array_upper(ARRAY[1,2,3,6, 4,5], 1);
--select thu('1$2$3$4$5$sdfds','454',454);


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

CREATE OR REPLACE FUNCTION find_place_around_street_unsigned(str text, t text, radius float ) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
 RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    str_geometry geometry;
	    t2 text;
	BEGIN
	    t2:= signed_to_unsigned(lower(t));
	    str_geometry := ST_GeomFromText(str,4326);
	    FOR r IN SELECT *                       		   FROM coquan           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT *                       		   FROM truong           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT *                       		   FROM benhvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,ma,ten,diachi,sdt,the_geom         FROM cho              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM ben              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT *                       		   FROM khachsan         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT *                       		   FROM congty           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT *                       		   FROM giaitri          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT *                       		   FROM denchua          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT *                       		   FROM buudien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT *                       		   FROM nganhang         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM congvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM cau              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT *                       		   FROM thuvien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--select * from quanhuyen;

