-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim canh gan nhat cua mot diem duoc click tren ban do
CREATE OR REPLACE FUNCTION find_nearest_edge(x text , y text)
	RETURNS geometry AS
$BODY$
	DECLARE
	result geometry;
	three_d_temp text;
	point_temp text;
	BEGIN
	    three_d_temp:='BOX3D(' || (to_number(x,'9999999D9999999999')-10000) || '  ' || (to_number(y,'9999999D9999999999')-10000) || ' , ' || (to_number(x,'9999999D9999999999')+10000) || ' ' || (to_number(y,'9999999D9999999999')+10000) ||  ')';
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
--select astext(find_nearest_edge(586302.31032,1109833.62530));
--select gid from giaothong where astext(the_geom)='MULTILINESTRING((586227.009415082 1109865.85288409,586264.700382433 1109856.87096462,586325.390346716 1109809.93093334))' 

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim diem gan nhat(tren canh gan nhat) cua mot diem duoc click tren ban do
--select Astext(ST_ClosestPoint( ST_GeomFromText('MULTILINESTRING((586227.009415082 1109865.85288409,586264.700382433 1109856.87096462,586325.390346716 1109809.93093334))',4326), 
--ST_GeomFromText('POINT(586302.31032 1109833.62530)',4326)))


--select ST_Intersects(ST_GeomFromText('MULTILINESTRING((584378.469161413 1110202.504828,584431.94925363 1110238.10243535,584449.223249173 1110239.86281155,584463.057294314 1110234.74171715,584493.059931271 1110211.35671968,584529.365019324 1110202.85490281,584558.163261177 1110201.77467196,584586.367554759 1110209.84639692,584603.608553175 1110226.47995158,584613.862410128 1110272.71983323,584626.714790766 1110321.10017231,584639.616667093 1110344.87525314,584657.154639645 1110355.78758515,584678.743009433 1110360.7086368,584868.831203936 1110350.55646724,584928.448761618 1110346.11551819,585012.508940501 1110358.61819006,585033.528109862 1110361.52881207,585096.585617947 1110362.52902582,585134.342579551 1110350.31641594))',4326),
--ST_GeomFromtext(ASText(ST_Buffer(ST_GeomFromText('POINT(584961.360797522 1110351.01068248)',4326),0.001)),4326));


--select Astext(ST_buffer(ST_GeomFromText('POINT(586141.719585389 1109830.97332301)',4326),0.001))
--select ST_area(ST_buffer(ST_GeomFromText('POINT(585976.24584 1111636.34920)',4326),0.001))
--select astext(the_geom) from giaothong where gid = 184
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim dia chi cua mot diem duoc click tren ban do
--Neu ton tai thi tra ve ket qua la dia chi do
--Neu ko ton tai thi tra ve 'nodata'
CREATE OR REPLACE FUNCTION find_address_of_point(x text , y text)
	RETURNS text AS
$BODY$
	DECLARE
	result text;
	point_temp text;
	BEGIN
	    point_temp:='POINT(' || x || ' ' || y ||  ')';
	    result= diachi from coquan     where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from truong     where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from benhvien   where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from cho        where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from ben        where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from khachsan   where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from congty     where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from giaitri    where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from denchua    where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from buudien    where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from nganhang   where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from congvien   where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from cau        where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    result= diachi from thuvien    where astext(the_geom)=point_temp order by gid limit 1; if result is not null then return result;	end if;
	    return 'nodata';
	END;	
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

--select find_address_of_point('584915.027180554' ,'1109781.99496331');
--select *, astext(the_geom) from coquan;
--select * from benhvien where astext(the_geom)='POINT(586070.669031354 1110229.39057359)'
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim duong gan nhat cua mot diem co dia chi
--Neu dia chi chua mot ten duong thi tra ve con duong gan nhat trong so cac doan duong chua ten duong do
--Nguoc lai (dia chi ko chua mot ten duong) thi tra ve ket qua cua ham find_nearest_edge(x,y);
CREATE OR REPLACE FUNCTION find_nearest_edge_with_address(x text , y text,dc text)
	RETURNS geometry AS
$BODY$
	DECLARE
	result geometry;
	three_d_temp text;
	point_temp text;
	BEGIN
	    three_d_temp:='BOX3D(' || (to_number(x,'9999999D9999999999')-10000) || '  ' || (to_number(y,'9999999D9999999999')-10000) || ' , ' || (to_number(x,'9999999D9999999999')+10000) || ' ' || (to_number(y,'9999999D9999999999')+10000) ||  ')';
	    point_temp:='POINT(' || x || ' ' || y ||  ')';
	    result:= the_geom FROM giaothong 
	    WHERE (the_geom && setsrid(three_d_temp::box3d,4326)) and dc like '%'||ten_duong||'%'
            ORDER BY distance(the_geom, GeometryFromText(point_temp, 4326)) LIMIT 1;
            if result is not null then return result; end if;
            return find_nearest_edge(x,y);	
	END;	
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--select * from giaothong where the_geom=find_nearest_edge_with_address('582282.615447204', '1109253.5820393','91B');
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
		--return start_point;
		--return end_point;
		IF start_point=astext(point_click) THEN
			result_id:= id FROM dinh WHERE astext(the_geom)=start_point;
			return '_$'||result_id;
		ELSIF end_point=astext(point_click) THEN
			result_id:= id FROM dinh where astext(the_geom)=end_point;
			return '_$'||result_id;			
		ELSE
		   FOR j IN 1 .. num_of_point LOOP	
			point_geom:= PointN(the_geom,j)from giaothong where gid=gid_a;
			temp[j]:=point_geom; 
			line:='';
			line:= line || X(temp[j])||' '||Y(temp[j])||', '||X(temp[j-1])||' '||Y(temp[j-1]);    
			line:='LINESTRING'||'(' || line || ')';
			--return line;
			IF j=1 THEN
				   result1:= result1 ||X(temp[j])||' '||Y(temp[j])||', ';
				   --return X(temp[j])||'';
			END IF;   
			SELECT INTO p ST_intersects(ST_GeomFromText(line,4326),ST_GeomFromText(AsText(ST_Buffer($2,0.001)),4326));-----------------------------------------------
			IF p!= 't' THEN
				    result1:= result1 ||X(temp[j])||' '||Y(temp[j])||', ';--chac chan la ko  tai j = 1 vi tai j=1 p =null  		   				    
			END IF;
			IF p = 't' THEN
			    result1:= result1 ||X(point_click)||' '||Y(point_click);
			    result1:='MULTILINESTRING'||'((' || result1 || '))';
			    --return result1;
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
				--result1:=ST_AsGML(ST_GeomFromText(result1,4326));
				--result2:=ST_AsGML(ST_GeomFromText(result2,4326));
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
--select split_multilinestring(850,ST_GeomFromText('POINT(582323.84913511 1109302.67514772)',4326))
--select ST_NumPoints(the_geom) FROM giaothong where gid=140;
--select astext(PointN(the_geom,3)) from giaothong where gid=140;
--select id FROM dinh where astext(the_geom)='POINT(586547.939464075 1109940.46882983)';
--Select astext(the_geom) from dinh where id=105;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim canh gan nhat cua 1 diem duoc click tren ban do, tach canh ra lam 2 doan neu diem gan nhat ko trung voi 1 trong 2 dinh cua canh gan nhat do
--Diem gan nhat tai dau muc : return id cua dau muc va id cua canh gan nhat 
--Diem gan nhat nam giua canh gan nhat: 2 canh va do dai 2 canh, id cua canh gan nhat
CREATE OR REPLACE FUNCTION split_multi_from_any_point( x text, y text)
        RETURNS text AS
	$BODY$
	DECLARE
		nearest_edge geometry;
		nearest_point geometry;
		nearest_point_text text;
		nearest_edge_id integer;
		point_text text;
		result text;
		dc text;
	BEGIN
		point_text:='POINT(' || x || ' ' || y ||  ')';
		dc:=find_address_of_point(x,y);--tim dia chi cua diem nay
		if dc =  'nodata' then nearest_edge:= find_nearest_edge(x,y); end if;-- neu dia chi ko ton tai thi tim theo ham find_nearest_edge(x,y)
		if dc != 'nodata' then nearest_edge:= find_nearest_edge_with_address(x,y,dc); end if;--neu dc ton tai thi tim theo ham find_nearest_edge_with_address(x,y,dc)
		nearest_edge_id:= gid from giaothong where astext(the_geom)= astext(nearest_edge);
		nearest_point:= ST_ClosestPoint(nearest_edge, ST_GeomFromText(point_text,4326) );
		nearest_point_text:=Astext(nearest_point);
		--return nearest_point_text;
		result:=split_multilinestring(nearest_edge_id,ST_GeomFromText(nearest_point_text,4326));
		--return ST_GeomFromText(nearest_point_text,4326);
		result:=result || '$' || nearest_edge_id;
		return result;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--SELECT split_multi_from_any_point('582282.615447204','1109253.5820393') AS result
--select split_multi_from_any_point(585713.49659,1109864.59449);
--select astext(ST_GeomFromText('MULTILINESTRING((585699.6740927 1109929.70652988, 585699.6740927 1109929.70652988))',4326))
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
		id1:=Max(id) from dinh ;
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
				     --b1:=ST_AsGML(ST_GeomFromText(b1,4326));
				     --b2:=ST_AsGML(ST_GeomFromText(b2,4326));
				     --a2:=ST_AsGML(ST_GeomFromText(a2,4326));
				     result:= b1||'$'||lenb1||'$'||id2||'$'||b2||'$'||lenb2||'$'||id1||'$'||a2||'$'||lena2   ; 
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
				    --a1:=ST_AsGML(ST_GeomFromText(a1,4326));
				    --b1:=ST_AsGML(ST_GeomFromText(b1,4326));
				    --b2:=ST_AsGML(ST_GeomFromText(b2,4326)); 
				    result:=a1||'$'||lena1||'$'||id1||'$'||b1||'$'||lenb1||'$'||id2||'$'||b2||'$'||lenb2   ;
				    RETURN  result  ;
				END IF;	
			END LOOP;
	    END;
    $BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
CREATE OR REPLACE FUNCTION split_multi_from_two_point( x1 text, y1 text, x2 text, y2 text)
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
		dc1 text;
		dc2 text;
	BEGIN
		point_text1:='POINT(' || x1 || ' ' || y1 ||  ')';
		point_text2:='POINT(' || x2 || ' ' || y2 ||  ')';
		dc1:=find_address_of_point(x1,y1);--tim dia chi cua diem nay
		dc2:=find_address_of_point(x2,y2);--tim dia chi cua diem nay
		if dc1 =  'nodata' then nearest_edge1:= find_nearest_edge(x1,y1); end if;-- neu dia chi ko ton tai thi tim theo ham find_nearest_edge(x,y)
		if dc1 != 'nodata' then nearest_edge1:= find_nearest_edge_with_address(x1,y1,dc1); end if;--neu dc ton tai thi tim theo ham find_nearest_edge_with_address(x1,y1,dc1)
		if dc2 =  'nodata' then nearest_edge2:= find_nearest_edge(x2,y2); end if;-- neu dia chi ko ton tai thi tim theo ham find_nearest_edge(x,y)
		if dc2 != 'nodata' then nearest_edge2:= find_nearest_edge_with_address(x2,y2,dc2); end if;--neu dc ton tai thi tim theo ham find_nearest_edge_with_address(x2,y2,dc2)	
		nearest_edge_id1:= gid from giaothong where astext(the_geom)= astext(nearest_edge1);
		nearest_edge_id2:= gid from giaothong where astext(the_geom)= astext(nearest_edge2);
		if nearest_edge_id1 != nearest_edge_id2 then
			return '0';
		end if;
		nearest_point1:= ST_ClosestPoint(nearest_edge1, ST_GeomFromText(point_text1,4326) );
		nearest_point_text1:=Astext(nearest_point1);
		nearest_point2:= ST_ClosestPoint(nearest_edge2, ST_GeomFromText(point_text2,4326) );
		nearest_point_text2:=Astext(nearest_point2);
		result:=split_multilinestring2(nearest_edge_id1,ST_GeomFromText(nearest_point_text1,4326),ST_GeomFromText(nearest_point_text2,4326));
		return result;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--select split_multi_from_two_point(586302.31032,1109833.62530,586252.50420,1109866.19085) As result;
CREATE OR REPLACE FUNCTION find_id_nearest_edge( x text, y text)
        RETURNS text AS
	$BODY$
	DECLARE
		result text;		
		point_text text;
		dc text;
		nearest_edge geometry;	
	BEGIN	
			
		--nearest_edge_text := Astext(find_nearest_edge(x1,y1));
		--result := gid from giaothong where astext(the_geom) = nearest_edge_text;
		point_text:='POINT(' || x || ' ' || y ||  ')';
		dc:=find_address_of_point(x,y);--tim dia chi cua diem nay
		if dc =  'nodata' then nearest_edge:= find_nearest_edge(x,y); end if;-- neu dia chi ko ton tai thi tim theo ham find_nearest_edge(x,y)
		if dc != 'nodata' then nearest_edge:= find_nearest_edge_with_address(x,y,dc); end if;--neu dc ton tai thi tim theo ham find_nearest_edge_with_address(x,y,dc)
		result:= gid from giaothong where astext(the_geom)= astext(nearest_edge);
		return result;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

--Select find_id_nearest_edge(586099.65367,1111408.39041);
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Ket qua tra ve: ten$diachi$sdt$x$y
--Neu ko tim thay tra ve 'nodata'
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
		ma1:='';ten1:='';diachi1:='';sdt1:='';
		--1 coquan
		ma1:='coquan';
		ten1:= ten       from coquan where Astext(the_geom)= t; 
		diachi1:= diachi from coquan where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from coquan where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--2 truong
		ma1:='truong';
		ten1:= ten       from truong where Astext(the_geom)= t; 
		diachi1:= diachi from truong where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from truong where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--3 benhvien
		ma1:='benhvien';
		ten1:= ten       from benhvien where Astext(the_geom)= t; 
		diachi1:= diachi from benhvien where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from benhvien where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--4  cho
		ma1:='cho';
		ten1:= ten       from cho where Astext(the_geom)= t; 
		diachi1:= diachi from cho where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from cho where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--5  ben
		ma1:='ben';
		ten1:= ten       from ben where Astext(the_geom)= t; 
		diachi1:= diachi from ben where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= '';
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;

		--6  khachsan
		ma1:='khachsan';
		ten1:= ten       from khachsan where Astext(the_geom)= t; 
		diachi1:= diachi from khachsan where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from khachsan where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--7  congty
		ma1:='congty';
		ten1:= ten       from congty where Astext(the_geom)= t; 
		diachi1:= diachi from congty where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from congty where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--8   giaitri
		ma1:='giaitri';
		ten1:= ten       from giaitri where Astext(the_geom)= t; 
		diachi1:= diachi from giaitri where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from giaitri where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--9   denchua
		ma1:='denchua';
		ten1:= ten       from denchua where Astext(the_geom)= t; 
		diachi1:= diachi from denchua where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from denchua where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--10   buudien
		ma1:='buudien';
		ten1:= ten       from buudien where Astext(the_geom)= t; 
		diachi1:= diachi from buudien where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from buudien where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--11  nganhang
		ma1:='nganhang';
		ten1:= ten       from nganhang where Astext(the_geom)= t; 
		diachi1:= diachi from nganhang where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from nganhang where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--12    congvien
		ma1:='congvien';
		ten1:= ten       from congvien where Astext(the_geom)= t; 
		diachi1:= diachi from congvien where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= '';
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--13   cau
		ma1:='cau';
		ten1:= ten       from cau where Astext(the_geom)= t; 
		diachi1:= diachi from cau where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= '';
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		
		--14   thuvien
		ma1:='thuvien';
		ten1:= ten       from thuvien where Astext(the_geom)= t; 
		diachi1:= diachi from thuvien where Astext(the_geom)= t; if diachi1 is null then diachi1='';end if;
		sdt1:= sdt       from thuvien where Astext(the_geom)= t; if sdt1 is null then sdt1='';end if;
		if(ten1 is not null) then 
			return ten1||'$'||diachi1||'$'||sdt1 ||'$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326))||'$'||ma1;
		end if;
		return 'nodata$'||X(ST_GeomFromText(t,4326))||'$'||Y(ST_GeomFromText(t,4326));
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--select find_info_of_point('POINT(586026.386888053 1109704.73845328)');
--select * from cau;
--select astext(the_geom) from cho where gid =1;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tra ve tat ca nhung noi co ten giong voi t bao gom : gid,ma,ten,diachi,sdt, thegeom
--Doi voi cho, ben, congvien, cau thi sdt la ''
CREATE OR REPLACE FUNCTION find_place_by_text(t text) 
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	BEGIN
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'   as ma,ten,diachi,sdt,the_geom         FROM thuvien          where lower(ten )like '%'||lower(t)||'%' LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION find_place_by_text_unsigned(t text) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    t2 text;
	BEGIN
	    t2:= signed_to_unsigned(lower(t));
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'   as ma,ten,diachi,sdt,the_geom         FROM thuvien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

--select * from find_place_by_text_unsigned('ninh ki�u');
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--SELECT * FROM find_place_by_text('CAN THO');
-----------------------OK---------------------------------
-----------------------OK---------------------------------

CREATE OR REPLACE FUNCTION find_place_around_point(x text, y text, t text, radius float ) 
 RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    point_text text;
	    point_geometry geometry;
	BEGIN
	
	    point_text:='POINT(' || x || ' ' || y ||  ')';
	    point_geometry := ST_GeomFromText(point_text,4326);
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION find_place_around_point_unsigned(x text, y text, t text, radius float ) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW--
 RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    point_text text;
	    point_geometry geometry;
	    t2 text;
	BEGIN
	    t2:= signed_to_unsigned(lower(t));
	    point_text:='POINT(' || x || ' ' || y ||  ')';
	    point_geometry := ST_GeomFromText(point_text,4326);
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM thuvien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%'  and ST_Distance(point_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--select * from find_place_around_point(586712.97138,1110501.66355,'caN tho',1000);

CREATE OR REPLACE FUNCTION find_place_by_text_and_huyen( t text,m integer)
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_qh geometry;
	BEGIN
	    geom_qh:=the_geom from quanhuyen where ma=m;
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION find_place_by_text_and_huyen_unsigned( t text,m integer) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_qh geometry;
	    t2 text;
	BEGIN
	     t2:= signed_to_unsigned(lower(t));
	    geom_qh:=the_geom from quanhuyen where ma=m;
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_qh, the_geom) LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
-----------------------OK---------------------------------
-----------------------OK---------------------------------
CREATE OR REPLACE FUNCTION find_place_by_text_and_xa( t text,m integer)
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_xp geometry;
	BEGIN
	    geom_xp:=the_geom from xaphuong where ma=m;
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where lower(ten )like '%'||lower(t)||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION find_place_by_text_and_xa_unsigned( t text,m integer) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_xp geometry;
	    t2 text;
	BEGIN
	    t2:= signed_to_unsigned(lower(t));
	    geom_xp:=the_geom from xaphuong where ma=m;
	    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--1
	    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--2
	    FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--3
	    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--4
	    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--5
	    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--6
	    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--7
	    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--8
	    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--9
	    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--10
	    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--11
	    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--12
	    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--15
	    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where signed_to_unsigned(lower(ten )) like '%'||t2||'%' and  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

--select * from xaphuong;
--select * from quanhuyen
--cap co hai gia tri la huyen hay xa
CREATE OR REPLACE FUNCTION find_place_by_text_and_lop(m integer, lop text, cap text)
RETURNS SETOF coquan AS
	$BODY$
	DECLARE
	    r coquan%rowtype;
	    geom_xp geometry;
	BEGIN
	    if cap='xa' then geom_xp:=the_geom from xaphuong where ma=m; end if;
	    if cap='huyen' then geom_xp:=the_geom from quanhuyen where ma=m; end if;
	    if lop='coquan'           then FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--1
	    if lop='truong'           then FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--2
	    if lop='benhvien'         then FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom         FROM benhvien         where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--3
	    if lop='cho'              then FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--4
	    if lop='ben'              then FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--5
	    if lop='khachsan'         then FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--6
	    if lop='congty'           then FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--7
	    if lop='giaitri'          then FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--8
	    if lop='denchua'          then FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--9
	    if lop='buudien'          then FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--10
	    if lop='nganhang'         then FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--11
	    if lop='congvien'         then FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--12
	    if lop='cau'              then FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--15
	    if lop='thuvien'          then FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where  st_contains(geom_xp, the_geom) LOOP RETURN NEXT r; END LOOP;end if;--14
	    RETURN;
	END
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--select * from find_place_by_text_and_lop(1,'cho','huyen');
-----------------------OK---------------------------------
-----------------------OK---------------------------------
---Ham tim dia chi xaphuong, quahuyen cua mot diem bat ky
CREATE OR REPLACE FUNCTION find_address_xp_qh(x text , y text)
	RETURNS text AS
$BODY$
	DECLARE
	result text;
	point_geometry geometry;
	point_temp text;
	ten_xa text;
	ma_h integer;
	ten_huyen text;
	ten_dia_diem text;
	BEGIN
	    point_temp:='POINT(' || x || ' ' || y ||  ')';
	    ten_dia_diem:= ten from coquan   where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from truong   where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from benhvien where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from cho      where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from ben      where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from khachsan where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from congty   where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from giaitri  where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from denchua  where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from buudien  where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from nganhang where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from congvien where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from cau      where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    ten_dia_diem:= ten from thuvien  where Astext(the_geom)= point_temp; if ten_dia_diem is not null then return ten_dia_diem; end if;
	    point_geometry= GeometryFromText(point_temp, 4326);
	    ten_xa= ten from xaphuong where st_contains(the_geom,point_geometry) order by ma limit 1;
	    ma_h= ma_huyen from xaphuong where st_contains(the_geom,point_geometry) order by ma_huyen limit 1;
	    ten_huyen= ten from quanhuyen where ma= ma_h;
	    result= ten_xa || ', ' || ten_huyen;
            return result;	 
	END;	
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
--select * from quanhuyen order by ma desc;
--select astext(the_geom), * from coquan;
--select find_address_xp_qh('558787.613965348' ,'1106633.97221794');

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Ham nay dung de tinh do chenh lech goc, sau do huong dan chi duong re trai hay re phai
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
		if ((del>5 and del<=180) or(del>-355 and del<=-180)) then
			result:= 'rephai';
		elsif(del>180 and del<355) or (del>-180 and del<-5)then
			result:= 'retrai';
		else    
			result:='nodata';
		end if;
		return result;			
	END;
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--select get_direction(9,9,1,0,0,0,0,1);

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Ham nay de huong dan chi duong tu 2 multilinestring
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
		result:='nodata2';
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
--select get_bearing('MULTILINESTRING((0 0,1 0))','MULTILINESTRING((1 0,0 1,9 8))');

-----------------------OK---------------------------------
-----------------------OK---------------------------------
--Tim dich vu xung quanh lo trinh
CREATE OR REPLACE FUNCTION find_place_around_street(mult_str text, t text, radius float ) 
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
		    str_geometry := ST_GeomFromText(str,4326);
		    FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom         FROM coquan           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
		    FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom         FROM truong           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
		    FOR r IN SELECT gid,'benvien'  as ma,ten,diachi,sdt,the_geom         FROM benhvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
		    FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom         FROM cho              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
		    FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom FROM ben              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
		    FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom         FROM khachsan         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
		    FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom         FROM congty           where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
		    FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom         FROM giaitri          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
		    FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom         FROM denchua          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
		    FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom         FROM buudien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
		    FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom         FROM nganhang         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
		    FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom FROM congvien         where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
		    FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom FROM cau              where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
		    FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom         FROM thuvien          where lower(ten )like '%'||lower(t)||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    END LOOP;
	    RETURN;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

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
		FOR r IN SELECT gid,'coquan'   as ma,ten,diachi,sdt,the_geom             FROM coquan           where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--1
		FOR r IN SELECT gid,'truong'   as ma,ten,diachi,sdt,the_geom             FROM truong           where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--2
		FOR r IN SELECT gid,'benhvien' as ma,ten,diachi,sdt,the_geom             FROM benhvien         where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--3
		FOR r IN SELECT gid,'cho'      as ma,ten,diachi,sdt,the_geom             FROM cho              where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--4
		FOR r IN SELECT gid,'ben'      as ma,ten,diachi,null as sdt,the_geom     FROM ben              where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--5
		FOR r IN SELECT gid,'khachsan' as ma,ten,diachi,sdt,the_geom             FROM khachsan         where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--6
		FOR r IN SELECT gid,'congty'   as ma,ten,diachi,sdt,the_geom             FROM congty           where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--7
		FOR r IN SELECT gid,'giaitri'  as ma,ten,diachi,sdt,the_geom             FROM giaitri          where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--8
		FOR r IN SELECT gid,'denchua'  as ma,ten,diachi,sdt,the_geom             FROM denchua          where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--9
		FOR r IN SELECT gid,'buudien'  as ma,ten,diachi,sdt,the_geom             FROM buudien          where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--10
		FOR r IN SELECT gid,'nganhang' as ma,ten,diachi,sdt,the_geom             FROM nganhang         where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--11
		FOR r IN SELECT gid,'congvien' as ma,ten,diachi,null as sdt,the_geom     FROM congvien         where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--12
		FOR r IN SELECT gid,'cau'      as ma,ten,diachi,null as sdt,the_geom     FROM cau              where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--15
		FOR r IN SELECT gid,'thuvien'  as ma,ten,diachi,sdt,the_geom             FROM thuvien          where signed_to_unsigned(lower(ten ))like '%'||t2||'%'  and ST_Distance(str_geometry,the_geom) <=radius LOOP RETURN NEXT r; END LOOP;--14
	    END LOOP;
	    RETURN;
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
-----------------------OK---------------------------------
-----------------------OK---------------------------------
CREATE OR REPLACE FUNCTION find_street_by_ma(ma text) -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- -- NEW-- 
 RETURNS text AS
	$BODY$
	DECLARE
	    geom_point geometry;
	    geom geometry;
	    x text;
	    y text;
	BEGIN
	    geom:= the_geom from giaothong where ma_duong = ma limit 1;
	    geom_point:=PointN(geom,1);
	    x:=ST_X(geom_point)||'';
	    y:=ST_Y(geom_point)||'';
	    return x||'$'||y;	
	END;
	$BODY$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;
--select find_street_by_ma('07');
--select * from giaothong where ma_duong='07';


