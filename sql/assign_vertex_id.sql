-----------------------------------------------------------------------
--cap nhat ngay: 22-03-2011
------------------------------------------
CREATE OR REPLACE FUNCTION point_to_id(p geometry, tolerance double precision)
RETURNS BIGINT 
AS 
$$ 

DECLARE
    _r record; 
    _id bigint; 
    _srid integer;

BEGIN

    _srid := Find_SRID('public','dinh','the_geom');

    SELECT

        Distance(the_geom,GeometryFromText( AsText(p), _srid)) AS d, id, the_geom

    INTO _r FROM dinh WHERE

        the_geom && Expand(GeometryFromText(AsText(p), _srid), tolerance ) AND Distance(the_geom, GeometryFromText(AsText(p), _srid)) < tolerance

    ORDER BY d LIMIT 1; IF FOUND THEN

        _id:= _r.id;

    ELSE

        INSERT INTO dinh(the_geom) VALUES (SetSRID(p,_srid)); _id:=lastval();

    END IF;

    RETURN _id;

END; $$ LANGUAGE 'plpgsql' VOLATILE STRICT; 


-----------------------------------------------------------------------
-- Fill the source and target_id column for all lines. All line ends
--  with a distance less than tolerance, are assigned the same id
--
-- Last changes: 16.04.2008
-- Author: Christian Gonzalez
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION assign_vertex_id(geom_table varchar, tolerance double precision, geo_cname varchar, gid_cname varchar)
RETURNS VARCHAR AS
$$
DECLARE
    _r record;
    source_id int;
    target_id int;
    srid integer;
BEGIN

    BEGIN
    DROP TABLE dinh;
    EXCEPTION 
    WHEN UNDEFINED_TABLE THEN
    END;

    EXECUTE 'CREATE TABLE dinh (id serial)';

    FOR _r IN EXECUTE 'SELECT srid FROM geometry_columns WHERE f_table_name='''|| quote_ident(geom_table)||''';' LOOP
	srid := _r.srid;
    END LOOP;

    EXECUTE 'SELECT addGeometryColumn(''dinh'', ''the_geom'', '||srid||', ''POINT'', 2)';
    CREATE INDEX dinh_idx ON dinh USING GIST (the_geom);
			
    FOR _r IN EXECUTE 'SELECT ' || quote_ident(gid_cname) || ' AS id,'
	    || ' StartPoint('|| quote_ident(geo_cname) ||') AS source,'
            || ' EndPoint('|| quote_ident(geo_cname) ||') as target'
	    || ' FROM ' || quote_ident(geom_table) 
    LOOP
        
        source_id := point_to_id(setsrid(_r.source, srid), tolerance);
	target_id := point_to_id(setsrid(_r.target, srid), tolerance);
								
	EXECUTE 'update ' || quote_ident(geom_table) || 
		' SET nut_nguon = ' || source_id || 
		', nut_dich = ' || target_id || 
		' WHERE ' || quote_ident(gid_cname) || ' =  ' || _r.id;
    END LOOP;

    RETURN 'OK';

END;
$$
LANGUAGE 'plpgsql' VOLATILE STRICT; 																	