--'MULTILINESTRING((0 0, 0 -1))'
--'MULTILINESTRING((0 0, 0 1))'

CREATE or replace FUNCTION get_bearing(line1 text, line2 text) 
RETURNS text AS
$BODY$
	DECLARE
		x1 float8; y1 float8;x2 float8;y2 float8;
		x3 float8; y3 float8;x4 float8;y4 float8;
		n1 integer;n2 integer; 
		geom1 geometry;geom2 geometry;
		p1 geometry;p2 geometry;p3 geometry;p4 geometry; temp1 geometry; temp2 geometry;
		t1 text; t2 text; t3 text; t4 text;
		start_point text; end_point text;
		result text;
		d float;--dung de luu khoang cach;
	BEGIN
		result:='nodata';
		geom1:=ST_GeomFromText(line1,4326);
		geom2:=ST_GeomFromText(line2,4326);
		n1:=ST_NumPoints(geom1); p1:=PointN(geom1,1);p2:=PointN(geom1,n1);t1:=Astext(p1);t2:=Astext(p2);	
		n2:=ST_NumPoints(geom2); p3:=PointN(geom2,1);p4:=PointN(geom2,n2);t3:=Astext(p3);t4:=Astext(p4);				
		d=ST_Distance(p1,p3);
		if d<0.05 then --neu p1 trung voi p3 thi lay diem thu 2,1 cua line1- diem 1,2 cua line2
			temp1:=PointN(geom1,2);
			temp2:=PointN(geom2,1); 
			x1:=ST_X(temp1);
			y1:=ST_Y(temp1);
			x2:=ST_X(p1);
			y2:=ST_Y(p1);
			x3:=ST_X(p3);
			y3:=ST_Y(p3);
			x4:=ST_X(temp2);
			y4:=ST_Y(temp2);
			result = get_direction(x1,y1,x2,y2,x3,y3,x4,y4) ;
		end if;
		d=ST_Distance(p1,p4);
		if d<0.05 then --neu p1 trung voi p4 thi lay diem thu 2,1 cua line1 - diem n2,n2-1 cua line2
			temp1:=PointN(geom1,2);
			temp2:=PointN(geom2,n2-1); 
			x1:=ST_X(temp1);
			y1:=ST_Y(temp1);
			x2:=ST_X(p1);
			y2:=ST_Y(p1);
			x3:=ST_X(p4);
			y3:=ST_Y(p4);
			x4:=ST_X(temp2);
			y4:=ST_Y(temp2);
			result = get_direction(x1,y1,x2,y2,x3,y3,x4,y4) ;
		end if;
		d=ST_Distance(p2,p3);
		if d<0.05 then --neu p2 trung voi p3 thi lay diem thu 1,2 cua line1, diem 1,2 cua line2
			temp1:=PointN(geom1,n1-1);
			temp2:=PointN(geom2,2); 
			x1:=ST_X(temp1);
			y1:=ST_Y(temp1);
			x2:=ST_X(p2);
			y2:=ST_Y(p2);
			x3:=ST_X(p3);
			y3:=ST_Y(p3);
			x4:=ST_X(temp2);
			y4:=ST_Y(temp2);
			result = get_direction(x1,y1,x2,y2,x3,y3,x4,y4) ;
		end if;
		d=ST_Distance(p2,p4);
		if d<0.05 then --neu p2 trung voi p4 thi lay diem thu n1-1,n1 cua line1, diem n2,n2-1 cua line2
			temp1:=PointN(geom1,n1-1);
			temp2:=PointN(geom2,n2-1); 
			x1:=ST_X(temp1);
			y1:=ST_Y(temp1);
			x2:=ST_X(p2);
			y2:=ST_Y(p2);
			x3:=ST_X(p4);
			y3:=ST_Y(p4);
			x4:=ST_X(temp2);
			y4:=ST_Y(temp2);
			result = get_direction(x1,y1,x2,y2,x3,y3,x4,y4) ;
		end if;
		--return x1||'_'||y1||'_'||x2||'_'||y2||'_'||x3||'_'||y3||'_'||x4||'_'||y4;
		return result;			
	END;
	
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
select get_bearing('MULTILINESTRING((0 0,1 0))','MULTILINESTRING((1 0,0 1,9 8))');


--select ST_Azimuth(ST_MakePoint(0,0), ST_MakePoint(-1,1))/(pi())*180; 

CREATE or replace FUNCTION get_direction(x1 float8, y1 float8,x2 float8,y2 float8,x3 float8, y3 float8,x4 float8,y4 float8) 
RETURNS text AS
$BODY$
	DECLARE
		goc1 float; goc2 float;
		result text;
		del float;
	BEGIN
		goc1=ST_Azimuth(ST_MakePoint(x1,y1), ST_MakePoint(x2,y2))/(pi())*180; 
		goc2=ST_Azimuth(ST_MakePoint(x3,y3), ST_MakePoint(x4,y4))/(pi())*180; 
		del = goc2-goc1;
		if ((del>0 and del<=180) or(del>-360 and del<=-180)) then
			result:= 'rephai';
		elsif(del>180 and del<360) or (del>-180 and del<0)then
			result:= 'retrai';
		else    
			result:='dithang';
		end if;
		return result;			
	END;
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
select get_direction(9,9,1,0,0,0,0,1);