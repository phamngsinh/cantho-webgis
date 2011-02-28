CREATE OR REPLACE FUNCTION find_info_of_point( t text)
        RETURNS text AS
	$BODY$
	DECLARE	
		result text;
		ma1 text;
		ten1 text;
		diachi1 text;	
		sdt1 text;
	BEGIN	
		ma1='';ten1='';diachi1='';sdt1='';
		ten1:= ten from coquan where Astext(the_geom)= t; 
		diachi1:= diachi from coquan where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt from coquan where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1!='') then 
		return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326));
		end if;
		
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

select find_info_of_point('POINT(586343.109803462 1110015.0947777)');

select astext(the_geom) from coquan where gid =1;