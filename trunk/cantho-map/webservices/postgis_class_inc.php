<?php
class postgis
{
/**
 * @author Paul Scott
 * @copyright Paul Scott
 * GPL Package
 * Please include credit to me is you use this class!
 */

function connect()
{
       $dbname = 'cdsm';
       $port = '5432';
       $host = 'localhost';

      $dbconn = pg_connect("host=$host port=$port dbname=$dbname");  
      if($dbconn)
      {
      return true;
      }
      else
      {
      return false;
      }
}

function close()
{
    $shutdown = pg_close($dbconn);
    if($shutdown)
    {
    return true;
    }
    else
    {
        return false;
    }
}
//function to insert shapefiles (ESRI) into PostGIS DB
function create_sql($filename,$dbname)
{
	//create the tablename from the filename (replace the .shp with shp)
	$tablename1 = str_replace('.','',$filename);
	//Remove last three chars from table name ('shp' is discarded)
	$tablename = substr($tablename1,0,-3);
	//Give the log file a name by tacking .log onto the table name
	$logfile = $tablename.".log";
	//execute the shell script that does all the real work (thanks refractions.net)
	$ret = shell_exec("/usr/local/pgsql/bin/shp2pgsql $filename $tablename|/usr/local/pgsql/bin/psql -d $dbname 2>&1");
	//echo $ret; //debug only (displays the results)
	//open a file handle for binary safe write - this creates a logfile...Use it or leave it, just an extra
	$handle = fopen($logfile,'w');
	//Write the log data to a file
	fwrite($handle, $ret);
	//close the file handle
	fclose($handle);
}

function shp2pgsql($filename,$dbname)
{
//loop through all the shapefiles and perform the function on them
foreach (glob("*.shp") as $filename) 
{
  //display the file size and name that we are currently working on
  //echo "$filename size " . filesize($filename) . "<br><br>\n";
  //do the sql-ize and insert the data, also write a log
  create_sql($filename,$dbname);
}//end foreach
}//end function

function get_extents($dbname,$tablename)
{
    $this->connect();
    $query = "SELECT EXTENT(the_geom) FROM $tablename";
    $rec = pg_query($query);
   if ($rec) {
       $arr = pg_fetch_all($rec);
       $extents = $arr[0]['extent'];
       $extents = str_replace("BOX3D","",$extents);
       $extents = str_replace("(","",$extents);
       $extents = str_replace(")","",$extents);
       $extents = str_replace("0,","",$extents);
       $extents = "EXTENT"." ".$extents;
       return $extents;
}
}

/**
 * PostGIS Management Functions
 */
 
 /**
  * Syntax: AddGeometryColumn(<schema_name>, <table_name>, <column_name>, <srid>, <type>, <dimension>). 
  * Adds a geometry column to an existing table of attributes. The schema_name  is the name of the table schema
  * (unused for pre-schema PostgreSQL installations). 
  * The srid must be an integer value reference to an entry in the SPATIAL_REF_SYS table. 
  * The type must be an uppercase string corresponding to the geometry type, eg, 'POLYGON' or 'MULTILINESTRING'.
  */
  
 function addGeomCol($dbname,$schema,$tablename,$col_name,$srid,$type,$dimension)
 {
    $this->connect();
      $query = "SELECT AddGeometryColumn('$schema','$tablename','$col_name','$srid','$type','$dimension')";
      @$rec = pg_query($query);
      if($rec)
      {
          return true;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
 }
 
 
 /**
  * Function dropGeomCol(varchar, varchar, varchar)
  * PostGIS Syntax: DropGeometryColumn(<schema_name>, <table_name>, <column_name>). 
  * Remove a geometry column from a spatial table. 
  * Note that schema_name will need to match the f_schema_name field of the table's 
  * row in the geometry_columns table.
  */
 
  function dropGeomCol($dbname,$schema, $tablename, $col_name)
  {
    $this->connect();
      $query = "SELECT DropGeometryColumn('$schema','$tablename','$col_name')";
      @$rec = pg_query($query);
      if($rec)
      {
          return true;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
 
  }
  
  /**
   * function setSRID
   * PostGIS Syntax: SetSRID(geometry)
   * Set the SRID on a geometry to a particular integer value. 
   * Useful in constructing bounding boxes for queries.
   * This function is not yet implemented
   */
   
   function setSRID($geom)
   {
       
   }
   
   
   /**
    * PostGIS Geometry Relationship Functions
    */
    
    /**
     * Function distance(geom,geom)
     * PostGIS Syntax: Distance(geometry,geometry)
     * Return the cartesian distance between two geometries in projected units.
     */
     
     function distance($dbname,$tablename,$geom1,$geom2)
     {
        $this->connect();
          $query = "SELECT Distance($geom1,$geom2) from $tablename";
          $rec = pg_query($query);
          if($rec)
          {
              $arr = pg_fetch_all($rec);
              return $arr;
          }
          else
          {
              $rec = pg_last_error($dbconn);
              return false;
          }
      }
      
      /**
       * Function equals
       * PostGIS Syntax: Equals(geometry,geometry)
       * Returns 1 (TRUE) if this Geometry is "spatially equal" to anotherGeometry. 
       * Use this for a 'better' answer than '='. 
       * equals ('LINESTRING(0 0, 10 10)','LINESTRING(0 0, 5 5, 10 10)') is true.
       * Performed by the GEOS module
       * OGC SPEC s2.1.1.2
       */
       
       function equals($dbname,$tablename,$geom1,$geom2)
       {
        $this->connect();
          $query = "SELECT Equals($geom1,$geom2) from $tablename";
          $rec = pg_query($query);
          if($rec)
          {
              $arr = pg_fetch_all($rec);
              return $arr;
          }
          else
          {
              $rec = pg_last_error($dbconn);
              return false;
          }
      }

      /**
       * Function disjoint
       * PostGIS Syntax: Disjoint(geometry,geometry)
       * Returns 1 (TRUE) if this Geometry is "spatially disjoint" from anotherGeometry.
       * Performed by the GEOS module
       * Do not call with a GeometryCollection as an argument
       * NOTE: this is the "allowable" version that returns a boolean, not an integer.
       * OGC SPEC s2.1.1.2 //s2.1.13.3 - a.Relate(b, 'FF*FF****')
       */         

       function disjoint($dbname,$tablename,$geom1,$geom2)
       {
        $this->connect();
          $query = "SELECT Disjoint($geom1,$geom2) from $tablename";
          $rec = pg_query($query);
          if($rec)
          {
              $arr = pg_fetch_all($rec);
              //print_r($arr);
              return $arr;
          }
          else
          {
              $rec = pg_last_error($dbconn);
              return false;
          }
      }

 /**
  * Function intersects
  * PostGIS Syntax: Intersects(geometry,geometry)
  * Returns 1 (TRUE) if this Geometry "spatially intersects" another Geometry.
  * Performed by the GEOS module
  * Do not call with a GeometryCollection as an argument
  * NOTE: this is the "allowable" version that returns a boolean, not an integer.
  * OGC SPEC s2.1.1.2 //s2.1.13.3 - Intersects(g1, g2 ) --> Not (Disjoint(g1, g2 ))
  */
  function intersects($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Intersects($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          //print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function touches
 * PostGIS Syntax: Touches(geometry,geometry)
 * Returns 1 (TRUE) if this Geometry "spatially touches" anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3- 
 * a.Touches(b) -> (I(a) intersection I(b) = {empty set} ) and (a intersection b) not empty
 */

  function touches($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Touches($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          //print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function crosses
 * PostGIS Syntax: Crosses(geometry,geometry)
 * Returns 1 (TRUE) if this Geometry "spatially crosses" anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3 - a.Relate(b, 'T*T******')
 */

  function crosses($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Crosses($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function within
 * PostGIS Syntax: Within(geometry,geometry)
 * Returns 1 (TRUE) if this Geometry is "spatially within" anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3 - a.Relate(b, 'T*F**F***')
 */

  function within($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Within($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          //print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function overlaps
 * PostGIS Syntax: Overlaps(geometry,geometry)
 * Returns 1 (TRUE) if this Geometry is "spatially overlapping" anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3
 */
 
  function overlaps($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Overlaps($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          //print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function contains
 * PostGIS Syntax: Contains(geometry,geometry)
 * Returns 1 (TRUE) if this Geometry is "spatially contains" anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3 - same as within(geometry,geometry)
 */

  function contains($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Contains($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          //print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Function relate_with_matrix
 * PostGIS Syntax: Relate(geometry,geometry, intersectionPatternMatrix)
 * Returns 1 (TRUE) if this Geometry is spatially related to anotherGeometry, by testing for intersections
 * between the Interior, Boundary and Exterior of the two geometries as specified by the values in the
 * intersectionPatternMatrix.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is the "allowable" version that returns a boolean, not an integer.
 * OGC SPEC s2.1.1.2 // s2.1.13.3
 * This function is not yet implemented
 */

function relate_with_matrix($geom1,$geom2,$intersect_matrix)
{

}

/**
 * Function relate
 * PostGIS Syntax: Relate(geometry,geometry)
 * returns the DE-9IM (dimensionally extended nine-intersection matrix)
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * not in OGC spec, but implied. see s2.1.13.2
 */
 
  function relate($dbname,$tablename,$geom1,$geom2)
  {
    $this->connect();
      $query = "SELECT Relate($geom1,$geom2) from $tablename";
      $rec = pg_query($query);
      if($rec)
      {
          $arr = pg_fetch_all($rec);
          print_r($arr);
          return $arr;
      }
      else
      {
          $rec = pg_last_error($dbconn);
          return false;
      }
  }

/**
 * Geometry Processing Functions
 */
 
/**
 * Function centroid
 * PostGIS Syntax: Centroid(geometry)
 * Returns the centroid of the geometry as a point.
 * Computation will be more accurate if performed by the GEOS module (enabled at compile time).
 */

function centroid($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT Centroid($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
}

/**
 * Function area
 * PostGIS Syntax: Area(geometry)
 * Returns the area of the geometry if it is a polygon or multi-polygon. 
 */

function area($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT Area($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

 /**
  * Function length
  * PostGis Syntax: Length(geometry)
  * The length of this Curve in its associated spatial reference.
  * synonym for length2d()
  * OGC SPEC 2.1.5.1
  */

function length($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT length($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function pointOnSurface
 * PostGis Syntax: PointOnSurface(geometry)
 * Return a Point guaranteed to lie on the surface
 * Implemented using GEOS
 * OGC SPEC 3.2.14.2 and 3.2.18.2 -
 */

function pointOnSurface($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT PointOnSurface($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}
 
/**
 * Function boundary
 * PostGIS Syntax: Boundary(geometry)
 * Returns the closure of the combinatorial boundary of this Geometry. The combinatorial boundary is defined as
 * described in section 3.12.3.2 of the OGC SPEC. Because the result of this function is a closure, and hence
 * topologically closed, the resulting boundary can be represented using representational geometry primitives as
 * discussed in the OGC SPEC, section 3.12.2.
 * Performed by the GEOS module
 * OGC SPEC s2.1.1.1
 */
 
function boundary($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT Boundary($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function buffer
 * PostGIS Syntax: Buffer(geometry,double,[integer])
 * Returns a geometry that represents all points whose distance from this Geometry is less than or equal to
 * distance. Calculations are in the Spatial Reference System of this Geometry. The optional third parameter sets
 * the number of segment used to approximate a quarter circle (defaults to 8).
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * OGC SPEC s2.1.1.3
 */

function buffer($dbname,$tablename,$geom,$double,$integer='NULL')
{
        $this->connect();
    $query = "SELECT Buffer($geom,$double,$integer) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function convexHull
 * PostGIS Syntax: ConvexHull(geometry)
 * Returns a geometry that represents the convex hull of this Geometry.
 * Performed by the GEOS module
 * OGC SPEC s2.1.1.3
 */
 
function convexHull($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT ConvexHull($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function intersection
 * PostGIS Syntax: Intersection(geometry,geometry)
 * Returns a geometry that represents the point set intersection of this Geometry with anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * OGC SPEC s2.1.1.3  
 */
 
function intersection($dbname,$tablename,$geom1,$geom2)
{
        $this->connect();
    $query = "SELECT Intersection($geom1,$geom2) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function symDiff
 * PostGIS Syntax: SymDifference(geometry,geometry)
 * Returns a geometry that represents the point set symmetric difference of this Geometry with anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * OGC SPEC s2.1.1.3  
 */
 
function symDiff($dbname,$tablename,$geom1,$geom2)
{
        $this->connect();
    $query = "SELECT SymDifference($geom1,$geom2) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function difference
 * PostGIS Syntax: Difference(geometry,geometry)
 * Returns a geometry that represents the point set symmetric difference of this Geometry with anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * OGC SPEC s2.1.1.3
 */
 
function difference($dbname,$tablename,$geom1,$geom2)
{
        $this->connect();
    $query = "SELECT Difference($geom1,$geom2) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function geomunion
 * PostGIS SYntax: GeomUnion(geometry,geometry)
 * Returns a geometry that represents the point set union of this Geometry with anotherGeometry.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection as an argument
 * NOTE: this is renamed from "union" because union is an SQL reserved word
 * OGC SPEC s2.1.1.3
 */

function geomunion($dbname,$tablename,$geom1,$geom2)
{
        $this->connect();
    $query = "SELECT GeomUnion($geom1,$geom2) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function geomunion_set
 * PostGIS Syntax: GeomUnion(geometry set)
 * Returns a geometry that represents the point set union of this all Geometries in given set.
 * Performed by the GEOS module
 * Do not call with a GeometryCollection in the argument set
 * Not explicitly defined in OGC SPEC
 */
 
function geomunion_set($dbname,$tablename,$geomset)
{
        $this->connect();
    $query = "SELECT GeomUnion($geomset) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function memGeomUnion
 * PostGIS Syntax: MemGeomUnion(geometry set)
 * Same as the above, only memory-friendly (uses less memory and more processor time).
 */

function memGeomUnion($dbname,$tablename,$geomset)
{
        $this->connect();
    $query = "SELECT MemGeomUnion($geomset) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Geometry Accessors
 */
 
/**
 * Function asText
 * PostGIS Syntax: AsText(geometry)
 * Return the Well-Known Text representation of the geometry. For example: POLYGON(0 0,0 1,1 1,1 0,0 0)
 * OGC SPEC s2.1.1.1
 */

function asText($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT AsText($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function asBinary
 * PostGIS Syntax: AsBinary(geometry)
 * Returns the geometry in the OGC "well-known-binary" format, using the endian encoding of the server on which
 * the database is running. This is useful in binary cursors to pull data out of the database without converting
 * it to a string representation.
 * OGC SPEC s2.1.1.1 - also see asBinary(<geometry>,'XDR') and asBinary(<geometry>,'NDR')
 */
 
function asBinary($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT AsBinary($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * function srid
 * PostGIS Syntax: SRID(geometry)
 * Returns the integer SRID number of the spatial reference system of the geometry.
 * OGC SPEC s2.1.1.1
 */
 
function srid($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "SELECT SRID($geom) from $tablename";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function dimension
 * PostGIS Syntax: Dimension(geometry)
 * The inherent dimension of this Geometry object, which must be less than or equal to the coordinate dimension.
 * OGC SPEC s2.1.1.1 - returns 0 for points, 1 for lines, 2 for polygons, and the largest dimension of the
 * components of a GEOMETRYCOLLECTION.
 */
 
function dimension($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select dimension($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function envelope
 * PostGIS SYntax: Envelope(geometry)
 * Returns a POLYGON representing the bounding box of the geometry.
 * OGC SPEC s2.1.1.1 - The minimum bounding box for this Geometry, returned as a Geometry. 
 * The polygon is defined by the corner points of the bounding box ((MINX, MINY), (MAXX, MINY), (MAXX, MAXY),
 * (MINX, MAXY), (MINX, MINY)).
 * NOTE:PostGIS will add a Zmin/Zmax coordinate as well.
 */
 
function envelope($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select envelope($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function isEmpty
 * PostGIS Syntax: IsEmpty(geometry)
 * Returns 1 (TRUE) if this Geometry is the empty geometry . 
 * If true, then this Geometry represents the empty point set - i.e. GEOMETRYCOLLECTION(EMPTY).
 * OGC SPEC s2.1.1.1
 */ 
 
function isEmpty($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select isEmpty($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function isSimple
 * PostGIS Syntax: IsSimple(geometry)
 * Returns 1 (TRUE) if this Geometry has no anomalous geometric points, such as self intersection or self tangency.
 * Performed by the GEOS module
 * OGC SPEC s2.1.1.1
 */
 
function isSimple($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select IsSimple($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function isClosed
 * PostGIS Syntax: IsClosed(geometry)
 * Returns true of the geometry start and end points are coincident.
 */
 
function isClosed($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select IsClosed($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function isRing
 * PostGIS Syntax:  IsRing(geometry)
 * Returns 1 (TRUE) if this Curve is closed (StartPoint ( ) = EndPoint ( )) and 
 * this Curve is simple (does not pass through the same point more than once).
 * Should only be called on a LINE
 * performed by GEOS
 * OGC spec 2.1.5.1
 */
 
function isRing($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select IsRing($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function numGeoms
 * PostGIS Syntax: NumGeometries(geometry)
 * If geometry is a GEOMETRYCOLLECTION (or MULTI*) return the number of geometries, otherwise return NULL.
 */
 
function numGeoms($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select NumGeometries($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function geomN
 * PostGIS Syntax: GeometryN(geometry,int)
 * Return the N'th geometry if the geometry is a GEOMETRYCOLLECTION, MULTIPOINT, MULTILINESTRING or MULTIPOLYGON.
 * Otherwise, return NULL.
 * 1 is 1st geometry 
 */
 
function geomN($dbname,$tablename,$geom,$int)
{
        $this->connect();
    $query = "select GeometryN($geom,$int) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function numPoints
 * PostGIS Syntax: NumPoints(geometry)
 * Find and return the number of points in the first linestring in the geometry. Return NULL if there is no
 * linestring in the geometry.
 */

function numPoints($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select NumPoints($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function pointN
 * PostGIS Syntax: PointN(geometry,integer)
 * Return the N'th point in the first linestring in the geometry. Return NULL if there is no linestring in the
 * geometry.
 */

function pointN($dbname,$tablename,$geom,$int)
{
        $this->connect();
    $query = "select PointN($geom,$int) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}


/**
 * Function exRing
 * PostGIS Syntax: ExteriorRing(geometry)
 * Return the exterior ring of the first polygon in the geometry. Return NULL if there is no polygon in the
 * geometry.
 */
 
function exRing($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select ExteriorRing($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function numIntRings
 * PostGIS Synatx: NumInteriorRings(geometry)
 * Return the number of interior rings of the first polygon in the geometry. Return NULL if there is no polygon
 * in the geometry.
 */
 
function numIntRings($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select NumInteriorRings($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function intRingN
 * PostGIS Syntax: InteriorRingN(geometry,integer)
 * Return the N'th interior ring of the first polygon in the geometry. Return NULL if there is no polygon in the
 * geometry.
 */
 
function intRingN($dbname,$tablename,$geom,$int)
{
        $this->connect();
    $query = "select InteriorRingN($geom,$int) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function endPoint
 * PostGIS Syntax: EndPoint(geometry)
 * Returns the last point of the LineString geometry as a point.
 */
 
function endPoint($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select EndPoint($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function startPoint
 * PostGIS Syntax: StartPoint(geometry)
 * Returns the first point of the LineString geometry as a point.
 */
 
function startPoint($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select StartPoint($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function geomType
 * PostGIS Syntax: GeometryType(geometry)
 * Returns the type of the geometry as a string. Eg: 'LINESTRING', 'POLYGON', 'MULTIPOINT', etc.
 * OGC SPEC s2.1.1.1 - Returns the name of the instantiable subtype of Geometry of which this Geometry instance
 * is a member. The name of the instantiable subtype of Geometry is returned as a string.
 */
 
function geomType($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select GeometryType($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function xgeom
 * PostGIS Syntax: X(geometry)
 * Find and return the X coordinate of the first point in the geometry. 
 * Return NULL if there is no point in the geometry.
 */

function xgeom($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select X($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}
 
/**
 * Function ygeom
 * PostGIS Syntax: Y(geometry)
 * Find and return the Y coordinate of the first point in the geometry. 
 * Return NULL if there is no point in the geometry.
 */
 
function ygeom($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select Y($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}
 
 
/** 
 * Function zgeom
 * PostGIS Syntax: Z(geometry)
 * Find and return the Z coordinate of the first point in the geometry. 
 * Return NULL if there is no point in the geometry.
 */

function zgeom($dbname,$tablename,$geom)
{
        $this->connect();
    $query = "select Z($geom) from $tablename"; 
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

//TODO: Geometry Constructors

/**
 * Management Functions
 */
 
/**
 * Function dropGeomTable
 * PostGIS Syntax: DropGeometryTable([<schema_name>], <table_name>)
 * Drops a table and all its references in geometry_columns. Note: uses current_schema() on schema-aware pgsql
 * installations if schema is not provided.
 */
 
function dropGeomTable($dbname,$schema,$tablename)
{
        $this->connect();
    $query = "SELECT DropGeometryTable('$schema','$tablename')";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function updateGeomSRID
 * PostGIS Syntax: UpdateGeometrySRID([<schema_name>], <table_name>, <column_name>, <srid>)
 * Update the SRID of all features in a geometry column updating constraints and reference in geometry_columns.
 * Note: uses current_schema() on schema-aware pgsql installations if schema is not provided.
 */

function updateGeomSRID($dbname,$schema,$tablename,$column,$srid)
{
        $this->connect();
    $query = "SELECT UdateGeometrySRID('$schema','$tablename','$column','$srid')";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

 
 
/**
 * Function updateGeomStats
 * update_geometry_stats([<table_name>, <column_name>])
 * Update statistics about spatial tables for use by the query planner. You will also need to run "VACUUM ANALYZE
 * [table_name] [column_name]" for the statistics gathering process to be complete. NOTE: starting with PostgreSQL
 * 8.0 statistics gathering is automatically performed running "VACUUM ANALYZE".
 */
  
function updateGeomStats($dbname,$tablename,$column)
{
        $this->connect();
    $query = "SELECT update_geometry_stats('$tablename','$column')";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        $vacuum = "VACUUM ANALYZE $tablename";
        $res = pg_query($vacuum);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
 
}

/**
 * Function postgisVer
 * postgis_version()
 * Returns the version number of the PostGIS functions installed in this database (deprecated, use
 * postgis_full_version() instead).
 */
 
function postgisVer($dbname)
{
        $this->connect();
    $query = "SELECT postgis_version()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}

/**
 * Function pglibs
 * PostGIS Syntax: postgis_lib_version()
 * Returns the version number of the PostGIS library.
 */

function pglibs($dbname)
{
        $this->connect();
    $query = "SELECT postgis_lib_version()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}
 
/**
 * Function pgscripts
 * PostGIS Syntax: postgis_scripts_installed()
 * Returns the version number of the postgis.sql script installed in this database.
 */

function pgscripts($dbname)
{
        $this->connect();
    $query = "SELECT postgis_scripts_installed()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}
 
/**
 * Function pgscripts_rel
 * PostGIS Syntax: postgis_scripts_released()
 * Returns the version number of the postgis.sql script released with the installed postgis lib.
 */
 
function pgscripts_rel($dbname)
{
        $this->connect();
    $query = "SELECT postgis_scripts_released()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}

 
/**
 * geos_ver
 * PostGIS Syntax: postgis_geos_version()
 * Returns the version number of the GEOS library, or NULL if GEOS support is not enabled.
 */
 
function geos_ver($dbname)
{
    $this->connect();
    $query = "SELECT postgis_geos_version()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}


/**
 * Function pg_proj_ver
 * PostGIS Syntax: postgis_proj_version()
 * Returns the version number of the PROJ4 library, or NULL if PROJ4 support is not enabled.
 */
 
function pg_proj_ver($dbname)
{
        $this->connect();
    $query = "SELECT postgis_proj_version()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}


/**
 * Function pg_uses_stats
 * PostGIS Syntax: postgis_uses_stats()
 * Returns true if STATS usage has been enabled, false otherwise.
 */
 
function pg_uses_stats($dbname)
{
        $this->connect();
    $query = "SELECT postgis_uses_stats()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}

/**
 * Function pg_full_ver
 * PostGIS Syntax: postgis_full_version()
 * Reports full postgis version and build configuration infos.
 */
 
function pg_full_ver($dbname)
{
        $this->connect();
    $query = "SELECT postgis_full_version()";
    $rec = pg_query($query);
    if($rec)
    {
        $arr = pg_fetch_all($rec);
        print_r($arr);
        return $arr;
    }
    else
    {
        $rec = pg_last_error($dbconn);
        return false;
    }
  
}

/**
 * Measurement Functions
 */
 








    
    



  
  
 
 
 
 
 
 

/**
/////////////////////////////////////////////////Mapserver Stuff///////////////////////////////////////////////////
//Instantiate the mapserver and set up some vars

// quickview function, sets the extent of a map, Thanks to Robert W. Burgholzer <rburgholzer(at)maptech-inc(dot)com>  
function quickView($minx,$miny,$maxx,$maxy) 
{       
    $this->map->setextent($minx,$miny,$maxx,$maxy);    
}
*/
}//end class
?>
