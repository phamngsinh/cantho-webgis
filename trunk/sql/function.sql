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
select astext(find_nearest_edge(586302.31032,1109833.62530));
select gid from giaothong where astext(the_geom)='MULTILINESTRING((586227.009415082 1109865.85288409,586264.700382433 1109856.87096462,586325.390346716 1109809.93093334))' 

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim diem gan nhat(tren canh gan nhat) cua mot diem duoc click tren ban do
select Astext(ST_ClosestPoint( ST_GeomFromText('MULTILINESTRING((586227.009415082 1109865.85288409,586264.700382433 1109856.87096462,586325.390346716 1109809.93093334))',4326), 
ST_GeomFromText('POINT(586302.31032 1109833.62530)',4326)))


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
		len2:=0;		
		num_of_point:= ST_NumPoints(the_geom) FROM giaothong where gid=gid_a;
		start_point:= astext(PointN(the_geom,1)) from giaothong where gid=gid_a;		
		end_point:= astext(PointN(the_geom,num_of_point)) from giaothong where gid=gid_a;
		--return end_point;
		IF start_point=astext(point_click) THEN
			result_id:= id FROM vertices_tmp WHERE astext(the_geom)=start_point;
			return '_$'||result_id;
		ELSIF end_point=astext(point_click) THEN
			result_id:= id FROM vertices_tmp where astext(the_geom)=end_point;
			return '_$'||result_id;			
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
				result1:=ST_AsGML(ST_GeomFromText(result1,4326));
				result2:=ST_AsGML(ST_GeomFromText(result2,4326));
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
		point_text:='POINT(' || x || ' ' || y ||  ')';
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
select split_multi_from_any_point(585713.49659,1109864.59449);
select astext(ST_GeomFromText('MULTILINESTRING((585699.6740927 1109929.70652988, 585699.6740927 1109929.70652988))',4326))
-----------------------OK---------------------------------
-----------------------OK---------------------------------
CREATE OR REPLACE FUNCTION split_multilinestring2(gid_a integer, point1 geometry, point2 geometry)
            RETURNS text AS
    $BODY$
	    DECLARE
		point1_text text;
		point2_text text;
		a1 text;a2 text;b1 text;b2 text;
		lena1 float;lena2 float;lenb1 float;lenb2 float;
		geom_a1 geometry;geom_a2 geometry;geom_b1 geometry;geom_b2 geometry;	
		line text;
		num_of_point integer;
		j integer;
		start_point text;
		end_point text;
		temp geometry[] := '{}';
		point_geom geometry;
		result_id integer;
		p text;
		id1 integer;
		id2 integer;
		result text;
	    BEGIN	
		id1:=Max(id) from vertices_tmp;
		id1:=id1+1;
		id2:=id1+1;
		a1:='';
		a2:='';
		b1:='';
		b2:='';
		num_of_point:= ST_NumPoints(the_geom) FROM giaothong where gid=gid_a;
		start_point:= astext(PointN(the_geom,1)) from giaothong where gid=gid_a;		
		end_point:= astext(PointN(the_geom,num_of_point)) from giaothong where gid=gid_a;
		FOR j IN 1 .. num_of_point LOOP	
			point_geom:= PointN(the_geom,j)from giaothong where gid=gid_a;
			temp[j]:=point_geom; 
			line:='';
			line:= line || X(temp[j])||' '||Y(temp[j])||', '||X(temp[j-1])||' '||Y(temp[j-1]);    
			line:='LINESTRING'||'(' || line || ')';
			IF j=1 THEN
				   a1:= a1 ||X(temp[j])||' '||Y(temp[j])||', ';				   
			END IF; 
			p:=''; 
			
			SELECT INTO p ST_intersects(ST_GeomFromText(line,4326),ST_GeomFromText(AsText(ST_Buffer($2,0.001)),4326));-----------------------------------------------
			IF p!= 't' THEN
				    a1:= a1 ||X(temp[j])||' '||Y(temp[j])||', ';    				    
			END IF;
			IF p = 't' THEN
			   
			    a1:= a1 ||X(point1)||' '||Y(point1);
			    a1:='MULTILINESTRING'||'((' || a1 || '))';
			    a2:= a2 ||X(point1)||' '||Y(point1)||', ';
			    FOR k IN j .. num_of_point LOOP	
				 point_geom:=PointN(the_geom,k) from giaothong where gid=gid_a;
				 if astext(point_geom)=end_point then
					a2:= a2 ||X(point_geom)||' '||Y(point_geom);
					a2:='MULTILINESTRING'||'((' || a2 || '))';
				 else
					a2:= a2 ||X(point_geom)||' '||Y(point_geom)||', ';
				 end if;
			    END LOOP;
			    lena1:=ST_Length(ST_GeomFromText(a1,4326));
			    lena2:=ST_Length(ST_GeomFromText(a2,4326));
			    return a2;
			    EXIT;
			END IF;	
		    END LOOP;
		    geom_a1:=ST_GeomFromText(a1,4326);
		    num_of_point:= ST_NumPoints(geom_a1);
		    start_point:= astext(PointN(geom_a1,1));		
		    end_point:= astext(PointN(geom_a1,num_of_point));
		    FOR j IN 1 .. num_of_point LOOP	
				point_geom:= PointN(geom_a1,j);
				temp[j]:=point_geom; 
				line:='';
				line:= line || X(temp[j])||' '||Y(temp[j])||', '||X(temp[j-1])||' '||Y(temp[j-1]);    
				line:='LINESTRING'||'(' || line || ')';
				IF j=1 THEN
					   b1:= b1 ||X(temp[j])||' '||Y(temp[j])||', ';				   
				END IF;   
				p:=''; 
				
				SELECT INTO p ST_intersects(ST_GeomFromText(line,4326),ST_GeomFromText(AsText(ST_Buffer($3,0.001)),4326));-----------------------------------------------

				IF p!= 't' THEN
					    b1:= b1 ||X(temp[j])||' '||Y(temp[j])||', ';
				END IF;
				
				IF p = 't' THEN
	
				    b1:= b1 ||X(point2)||' '||Y(point2);
				    b1:='MULTILINESTRING'||'((' || b1 || '))';
				    b2:= b2 ||X(point2)||' '||Y(point2)||', ';
				    FOR k IN j .. num_of_point LOOP	
					 point_geom:=PointN(geom_a1,k);
					 if astext(point_geom)=end_point then
						b2:= b2 ||X(point_geom)||' '||Y(point_geom);
						b2:='MULTILINESTRING'||'((' || b2 || '))';
					 else
						b2:= b2||X(point_geom)||' '||Y(point_geom)||', ';
					 end if;
				    END LOOP;
				    
				     lenb1:=ST_Length(ST_GeomFromText(b1,4326));
				     lenb2:=ST_Length(ST_GeomFromText(b2,4326));
				     result:= b1||'$'||lenb1||'$'||id2||b2||'$'||lenb2||'$'||id1||'$'||a2||'$'||lena2   ;
				  
				     return   result; 
				END IF;	
			END LOOP;








			b1:='';
			b2:='';
			
			geom_a2:=ST_GeomFromText(a2,4326);
			num_of_point:= ST_NumPoints(geom_a2);
			start_point:= astext(PointN(geom_a2,1));		
			end_point:= astext(PointN(geom_a2,num_of_point)); 
			FOR j IN 1 .. num_of_point LOOP	
			 
				point_geom:= PointN(geom_a2,j);
				temp[j]:=point_geom; 
				line:='';
				line:= line || X(temp[j])||' '||Y(temp[j])||', '||X(temp[j-1])||' '||Y(temp[j-1]);    
				line:='LINESTRING'||'(' || line || ')';
				IF j=1 THEN
					   b1:= b1 ||X(temp[j])||' '||Y(temp[j])||', ';	
					  			   
				END IF;
				p:='';    
				
				SELECT INTO p ST_intersects(ST_GeomFromText(line,4326),ST_GeomFromText(AsText(ST_Buffer($3,0.001)),4326));-----------------------------------------------
				IF p!= 't' THEN
					    b1:= b1 ||X(temp[j])||' '||Y(temp[j])||', ';
				END IF;
				
				IF p = 't' THEN
					
				    b1:= b1 ||X(point2)||' '||Y(point2);
				    b1:='MULTILINESTRING'||'((' || b1 || '))';
				    b2:= b2 ||X(point2)||' '||Y(point2)||', ';
				    
				    FOR k IN j .. num_of_point LOOP
						-- return j; 
					 point_geom:=PointN(geom_a2,k);
					 if astext(point_geom)=end_point then
						b2:= b2 ||X(point_geom)||' '||Y(point_geom);
						b2:='MULTILINESTRING'||'((' || b2 || '))';
					 else
						b2:= b2||X(point_geom)||' '||Y(point_geom)||', ';
					 end if;
				    END LOOP;
				    
				    lenb1:=ST_Length(ST_GeomFromText(b1,4326));
				    lenb2:=ST_Length(ST_GeomFromText(b2,4326));
				   
				    result:=a1||'$'||lena1||'$'||id1||'$'||b1||'$'||lenb1||'$'||id2||'$'||b2||'$'||lenb2   ;
				    RETURN  result  ;
				END IF;	
			END LOOP;
	    END;
    $BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
CREATE OR REPLACE FUNCTION split_multi_from_two_point( x1 float, y1 float, x2 float, y2 float)
        RETURNS text AS
	$BODY$
	DECLARE
		nearest_edge1 geometry;
		nearest_edge2 geometry;
		nearest_point1 geometry;
		nearest_point2 geometry;
		nearest_point_text1 text;
		nearest_point_text2 text;
		nearest_edge_id1 integer;
		nearest_edge_id2 integer;
		point_text1 text;
		point_text2 text;
		result text;
		
	BEGIN
		point_text1:='POINT(' || x1 || ' ' || y1 ||  ')';
		point_text2:='POINT(' || x2 || ' ' || y2 ||  ')';
		nearest_edge1:= find_nearest_edge(x1,y1);
		nearest_edge2:= find_nearest_edge(x2,y2);
		nearest_edge_id1:= gid from giaothong where astext(the_geom)= astext(nearest_edge1);
		nearest_edge_id2:= gid from giaothong where astext(the_geom)= astext(nearest_edge2);
		if nearest_edge_id1 != nearest_edge_id2 then
			return '0';
		end if;
		nearest_point1:= ST_ClosestPoint(nearest_edge1, ST_GeomFromText(point_text1,4326) );
		nearest_point_text1:=Astext(nearest_point1);
		--nearest_point2:= ST_ClosestPoint(nearest_edge2, ST_GeomFromText(point_text2,4326) );
		--nearest_point_text2:=Astext(nearest_point2);
		--result:=split_multilinestring2(nearest_edge_id1,ST_GeomFromText(nearest_point_text1,4326),ST_GeomFromText(nearest_point_text2,4326));
		return Astext(ST_ClosestPoint(nearest_edge1, ST_GeomFromText(point_text1,4326)));
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
select split_multi_from_two_point(586302.31032,1109833.62530,586252.50420,1109866.19085);