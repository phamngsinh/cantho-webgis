-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim canh gan nhat cua mot diem duoc click tren ban do
CREATE OR REPLACE FUNCTION find_nearest_edge(x float , y float)
	RETURNS geometry AS
$BODY$
	DECLARE
	result geometry;
	three_d_temp text;
	point_temp text;
	BEGIN
	    three_d_temp:='BOX3D(' || (x-10000) || '  ' || (y-10000) || ' , ' || (x+10000) || ' ' || (y+10000) ||  ')';
	    point_temp:='POINT(' || x || ' ' || y ||  ')';
	    result:= the_geom FROM giaothong 
	    WHERE the_geom && setsrid(three_d_temp::box3d,4326)
            ORDER BY distance(the_geom, GeometryFromText(point_temp, 4326)) LIMIT 1;
            return result;	
	END;	
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
select astext(find_nearest_edge(586784.60011,1110326.84542));
select gid from giaothong where astext(the_geom)='MULTILINESTRING((586600.75961377 1110703.82196152,586839.741299955 1110838.30070018,586883.099523724 1110772.02653712,586903.953707454 1110723.43615316,586940.498024672 1110615.38306177,586989.234780005 1110465.02092876,586993.9286212 1110430.69359287,586985.968064515 1110387.76441873,586962.523606381 1110316.75924463,586882.901540967 1110373.78143051))' 

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim diem gan nhat(tren canh gan nhat) cua mot diem duoc click tren ban do
select Astext(ST_ClosestPoint( ST_GeomFromText('MULTILINESTRING((584378.469161413 1110202.504828,584431.94925363 1110238.10243535,584449.223249173 1110239.86281155,584463.057294314 1110234.74171715,584493.059931271 1110211.35671968,584529.365019324 1110202.85490281,584558.163261177 1110201.77467196,584586.367554759 1110209.84639692,584603.608553175 1110226.47995158,584613.862410128 1110272.71983323,584626.714790766 1110321.10017231,584639.616667093 1110344.87525314,584657.154639645 1110355.78758515,584678.743009433 1110360.7086368,584868.831203936 1110350.55646724,584928.448761618 1110346.11551819,585012.508940501 1110358.61819006,585033.528109862 1110361.52881207,585096.585617947 1110362.52902582,585134.342579551 1110350.31641594))',4326), 
ST_GeomFromText('POINT(584965.92584 1110320.31818)',4326)))


select ST_Intersects(ST_GeomFromText('MULTILINESTRING((584378.469161413 1110202.504828,584431.94925363 1110238.10243535,584449.223249173 1110239.86281155,584463.057294314 1110234.74171715,584493.059931271 1110211.35671968,584529.365019324 1110202.85490281,584558.163261177 1110201.77467196,584586.367554759 1110209.84639692,584603.608553175 1110226.47995158,584613.862410128 1110272.71983323,584626.714790766 1110321.10017231,584639.616667093 1110344.87525314,584657.154639645 1110355.78758515,584678.743009433 1110360.7086368,584868.831203936 1110350.55646724,584928.448761618 1110346.11551819,585012.508940501 1110358.61819006,585033.528109862 1110361.52881207,585096.585617947 1110362.52902582,585134.342579551 1110350.31641594))',4326),
ST_GeomFromtext(ASText(ST_Buffer(ST_GeomFromText('POINT(584961.360797522 1110351.01068248)',4326),0.001)),4326));


select Astext(ST_buffer(ST_GeomFromText('POINT(586141.719585389 1109830.97332301)',4326),0.001))
select ST_area(ST_buffer(ST_GeomFromText('POINT(585976.24584 1111636.34920)',4326),0.001))
select astext(the_geom) from giaothong where gid = 184
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tach canh ra lam 2 doan tu mot dinh cho truoc tai 1 diem neu diem do ko trung voi 2 dau mut.
--Ko trung  return: doan1$dodai1$doan2$dodai2
--Trung return : _id : id cua dinh trung
CREATE OR REPLACE FUNCTION split_multilinestring(gid_a integer, point_click geometry)
            RETURNS text AS
    $BODY$
	    DECLARE
		result1 text;
		result2 text;
		result text;
		line text;
		num_of_point integer;
		j integer;
		k integer;
		start_point text;
		end_point text;
		temp geometry[] := '{}';
		point_geom geometry;
		result_id integer;
		p text;
		len1 float;
		len2 float;
		point_click_text text;
	    BEGIN
		p:='f';
		result1:='';
		result2:='';
		len1:=0;
		len1:=0;		
		num_of_point:= ST_NumPoints(the_geom) FROM giaothong where gid=gid_a;
		start_point:= astext(PointN(the_geom,1)) from giaothong where gid=gid_a;		
		end_point:= astext(PointN(the_geom,num_of_point)) from giaothong where gid=gid_a;
		--return end_point;
		IF start_point=astext(point_click) THEN
			result_id:= id FROM vertices_tmp WHERE astext(the_geom)=start_point;
			return '_'||result_id;
		ELSIF end_point=astext(point_click) THEN
			result_id:= id FROM vertices_tmp where astext(the_geom)=end_point;
			return '_'||result_id;			
		ELSE
		   FOR j IN 1 .. num_of_point LOOP	
			point_geom:= PointN(the_geom,j)from giaothong where gid=gid_a;
			temp[j]:=point_geom; 
			line:='';
			line:= line || X(temp[j])||' '||Y(temp[j])||', '||X(temp[j-1])||' '||Y(temp[j-1]);    
			line:='LINESTRING'||'(' || line || ')';
			
			IF j=1 THEN
				   result1:= result1 ||X(temp[j])||' '||Y(temp[j])||', ';				   
			END IF;   
			SELECT INTO p ST_intersects(ST_GeomFromText(line,4326),ST_GeomFromText(AsText(ST_Buffer($2,0.001)),4326));-----------------------------------------------
			IF p!= 't' THEN
				    result1:= result1 ||X(temp[j])||' '||Y(temp[j])||', ';--chac chan la ko  tai j = 1 vi tai j=1 p =null  
				   				    
			END IF;
			
			IF p = 't' THEN
			    result1:= result1 ||X(point_click)||' '||Y(point_click);
			    result1:='MULTILINESTRING'||'((' || result1 || '))';
			    result2:= result2 ||X(point_click)||' '||Y(point_click)||', ';
			    FOR k IN j .. num_of_point LOOP	
				 point_geom:=PointN(the_geom,k) from giaothong where gid=gid_a;
				 if astext(point_geom)=end_point then
					result2:= result2 ||X(point_geom)||' '||Y(point_geom);
					result2:='MULTILINESTRING'||'((' || result2 || '))';
				 else
					result2:= result2 ||X(point_geom)||' '||Y(point_geom)||', ';
				 end if;
			    END LOOP;
				len1:=ST_Length(ST_GeomFromText(result1,4326));
				len2:=ST_Length(ST_GeomFromText(result2,4326));
				result:= result1||'$'||len1||'$'||result2||'$'||len2;
				return result1||'$'||len1||'$'||result2||'$'||len2;
			END IF;
			
		  END LOOP;
			
		END IF ;   
	    END;
    $BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
select split_multilinestring(106,ST_GeomFromText('POINT(584961.360797522 1110351.01068248)',4326))
select ST_NumPoints(the_geom) FROM giaothong where gid=140;
select astext(PointN(the_geom,3)) from giaothong where gid=140;
select id FROM vertices_tmp where astext(the_geom)='POINT(586547.939464075 1109940.46882983)';
Select astext(the_geom) from vertices_tmp where id=105;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim canh gan nhat cua 1 diem duoc click tren ban do, tach canh ra lam 2 doan neu diem gan nhat ko trung voi 1 trong 2 dinh cua canh gan nhat do
--Diem gan nhat tai dau muc : return id cua dau muc va id cua canh gan nhat 
--Diem gan nhat nam giua canh gan nhat: 2 canh va do dai 2 canh, id cua canh gan nhat
CREATE OR REPLACE FUNCTION split_multi_from_any_point( x float, y float)
        RETURNS text AS
	$BODY$
	DECLARE
		nearest_edge geometry;
		nearest_point geometry;
		nearest_point_text text;
		nearest_edge_id integer;
		point_text text;
		result text;
	BEGIN
		point_text='POINT(' || x || ' ' || y ||  ')';
		nearest_edge:= find_nearest_edge(x,y);
		nearest_edge_id:= gid from giaothong where astext(the_geom)= astext(nearest_edge);
		nearest_point:= ST_ClosestPoint(nearest_edge, ST_GeomFromText(point_text,4326) );
		nearest_point_text:=Astext(nearest_point);
		result:=split_multilinestring(nearest_edge_id,ST_GeomFromText(nearest_point_text,4326));
		result:=result || '$' || nearest_edge_id;
		return result;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
select split_multi_from_any_point(586801.20215,1110303.85798);
select astext(ST_GeomFromText('MULTILINESTRING((585699.6740927 1109929.70652988, 585699.6740927 1109929.70652988))',4326))


"MULTILINESTRING((584378.469161413 1110202.504828, 584431.94925363 1110238.10243535, 584449.223249173 1110239.86281155, 584463.057294314 1110234.74171715, 584493.059931271 1110211.35671968, 584529.365019324 1110202.85490281, 584558.163261177 1110201.77467196, 584586.367554759 1110209.84639692, 584603.608553175 1110226.47995158, 584613.862410128 1110272.71983323, 584626.714790766 1110321.10017231, 584639.616667093 1110344.87525314, 584657.154639645 1110355.78758515, 584678.743009433 1110360.7086368, 584868.831203936 1110350.55646724, 584928.448761618 1110346.11551819, 584961.360797521 1110351.01068247))$704.483401894639$MULTILINESTRING((584961.360797521 1110351.01068247, 585012.508940501 1110358.61819006, 585033.528109862 1110361.52881207, 585096.585617947 1110362.52902582, 585134.342579551 1110350.31641594))$175.678918376048$106"


