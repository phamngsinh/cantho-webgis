--ten bang : giaothong

ALTER TABLE giaothong ADD COLUMN source integer;
ALTER TABLE giaothong ADD COLUMN target integer;
ALTER TABLE giaothong ADD COLUMN length double precision;
--ALTER TABLE giaothong ADD COLUMN cost double precision;
--ALTER TABLE giaothong ADD COLUMN rcost double precision;

SELECT assign_vertex_id('giaothong', 0.000001, 'the_geom', 'gid');

UPDATE giaothong SET length=length(the_geom);
/*
UPDATE giaothong SET cost=length(the_geom);
UPDATE giaothong SET rcost=length(the_geom);
UPDATE giaothong SET rcost=length(the_geom)+1000000
WHERE mot_chieu=1;
*/
CREATE INDEX source_idx ON giaothong(source);
CREATE INDEX target_idx ON giaothong(target);
CREATE INDEX geom_idx ON giaothong USING GIST(the_geom GIST_GEOMETRY_OPS);
/*
ALTER TABLE giaothong ADD COLUMN x1 double precision;
ALTER TABLE giaothong ADD COLUMN y1 double precision;
ALTER TABLE giaothong ADD COLUMN x2 double precision;
ALTER TABLE giaothong ADD COLUMN y2 double precision;
UPDATE giaothong SET x1 = x(ST_startpoint(the_geom));
UPDATE giaothong SET y1 = y(ST_startpoint(the_geom));
UPDATE giaothong SET x2 = x(ST_endpoint(the_geom));
UPDATE giaothong SET y2 = y(ST_endpoint(the_geom));
*/

