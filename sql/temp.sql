
--cap co hai gia tri la huyen hay xa
CREATE OR REPLACE FUNCTION find_place_by_text_and_lop( t text,ma integer, lop text, cap text)
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_xp geometry;
	BEGIN
	    if cap='xa' then geom_xp:=the_geom from xaphuong where id=ma; end if;
	    if cap='huyen' then geom_xp:=the_geom from quanhuyen where id=ma; end if;
	    
	    if lop='coquan'           then FOR r IN SELECT *                       		  FROM coquan           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--1
	    if lop='truong'           then FOR r IN SELECT *                       		  FROM truong           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--2
	    if lop='benhvien'         then FOR r IN SELECT *                       		  FROM benhvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--3
	    if lop='cho'              then FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM cho              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--4
	    if lop=' ben'             then FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--5
	    if lop='khachsan'         then FOR r IN SELECT *                       		  FROM khachsan         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--6
	    if lop='congty'           then FOR r IN SELECT *                       		  FROM congty           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--7
	    if lop='giaitri'          then FOR r IN SELECT *                       		  FROM giaitri          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--8
	    if lop='denchua'          then FOR r IN SELECT *                       		  FROM denchua          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--9
	    if lop='truyenhinhbaochi' then FOR r IN SELECT *                       		  FROM truyenhinhbaochi where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--10
	    if lop='nganhang'         then FOR r IN SELECT *                       		  FROM nganhang         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--11
	    if lop='congvien'         then FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--12
	    if lop='cau'              then FOR r IN SELECT gid,ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--15
	    if lop='thuvien'          then FOR r IN SELECT *                       		  FROM thuvien          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--14
	    if lop='trungtam'         then FOR r IN SELECT *                       		  FROM trungtam         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--15
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--select * from find_place_by_text_and_lop('can tho',1,'khachsan','huyen');