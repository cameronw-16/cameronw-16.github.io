##Lab Six: Resilience Academy in Dar es Salaam 

To visualize our final results of drain density by subward, click on the map below.

[Drain Density Map](qgis2web_2019_10_24-16_05_38_137842/index.html)

### Re-creating Drain Density Analysis by Subward
In this lab we used SQL queries via PostGIS and visualized all of the results in QGIS. We used data from [Ramani Huria](http://ramanihuria.org/data/) which is accessible through [OpenStreetMap](https://www.openstreetmap.org/#map=4/38.01/-95.84) and [Resilience Academy](https://resilienceacademy.ac.tz/data/) to do a spatial analysis of sub-ward flooding vulnerability and resilience related to drain density and wetland proximity in Dar es Salaam, Tanzania. 

Layers Used for Analysis:
[Dar es Salaam Drains’ Locations](https://geonode.resilienceacademy.ac.tz/layers/geonode:drain_points) and 
[Dar es Salaam Administrative Sub-wards](https://geonode.resilienceacademy.ac.tz/layers/geonode:dar_es_salaam_subwards) 

Methods:
1) Download Drains’ Locations and Administrative Sub-wards data from Resilience Academy and load those files into DB Manager. 
 - import layer/file --> simplify table name --> change primary id to unique primary identifier for the data points in the table --> check 'convert field names to lower case' --> check 'create spatial index'
2) Find drain density by sub-ward:
Here’s the series of SQL queries utilized for drain density analysis with one-line comments indicated by ‘/*’. Within SQL, the Drains’ Locations vector layer was re-named ‘drains,’ Administrative Sub-wards layer was re-named ‘subwards’

```
/* add a new column ‘subward’ to table ‘drains’ with an integer data type*/
alter table drains add column subward integer;

/*update the new ‘subward’ column in the ‘drains’ table with the fid of the sub-ward that each drain intersects*/
update drains
set subward = fid
from subwards
where st_intersects(drains.geom, subwards.geom);

/*check to see if any drains were not assigned a sub-ward fid*/
select* from drains
where drains.subward is null;

/*Group the drains by subward and count the drains per subward*/
select count(subward) as subwardcount, subward
from drains
group by subward;
 
/*To create a separate table ‘subwardcount1’ of the query above (a table with two columns: subward and subwardcount) 
either click create view in the SQL window or add the create view*/
line (shown below) to your query
create view subwardcount1 as
select count(subward) as subwardcount, subward 
from drains
group by subward;

/*Add column ‘draincount’ to table ‘subwards’ for integer inputs*/
alter table subwards add column draincount integer;

/*Update the new ‘draincount’ column with the ‘subwardcount’ from the ‘subwardcount1’ table where the fid from subwards
table and the subward from the subwardcount1 table are equal*/
update subwards 
set draincount = subwardcount 
from subwardcount1 
where subwardcount1.subward = subwards.fid;
```

Now you have figured out the drains that fall into each subward (st_intersects), counted the number of drains in that subward (count()), and you have added a column to the subwards table for the draincount of each subward

Next we’ll calculate the area of the subwards in meters squared and use that and the draincount to find the draindensity of each subward.

```
/*Choose only the data from the ‘subwards’ table that you want in a new smaller table AND create an ‘subward_area’ 
column of the area ‘geom’ in square meters*/
create view subward_area as
select fid, draincount, st_area(geography(geom)) as area1 
from subwards;

/*Add an ‘aream2’ column for float values to table ‘subwards’*/
alter table subwards add column area float8;

/*update ‘area’ column in ‘subwards’ with the ‘area1’ column from ‘subward_area’ where both fids are equal*/
update subwards 
set aream2 = subward_area.area1 
from subward_area 
where subwards.fid = subward_area.fid;

/*add a column to ‘subwards’ called ‘draindensitykm2’ for floats*/
alter table subwards add column draindensitykm2 float8;

/*calculate the ‘draindensity’ column by dividing the ‘draincount’ by ‘aream2’ converted to kilometers squared*/
create view drain_density as
select fid, aream2, draincount, draincount/(aream2/1000000) as draindensity 
from subwards;

/*update the ‘draindensitykm2’ column in subwards to be filled with the calculated ‘draindensity’ from the ‘drain_density’ table*/
update subwards 
set draindensitykm2 = drain_density.draindensity 
from drain_density
where subwards.fid = drain_density.fid;
```

Now the subwards table has an aream2 column and a draindensitykm2 column. The drain density analysis is complete! To visualize the results in leaflet, we created two layers, one with subwards containing drain density data, and one with subwards without any drain density data. 

```
/*create layer of subwards with null drain densities*/
create view no_draindensity as
select fid, draindensitykm2, geom
from subwards_drains
where draindensitykm2 is null;

/*create layer of subwards with drain densities*/
select fid, draindensitykm2, geom
from subwards_drains
where draindensitykm2 is not null
```

3) We also calculated which subwards intersect with wetlands, but this is not visualized in the leaflet map at the top of this page. For leaflet, we simply overlaid the wetlands vector layer (planet_osm_polygon). 

In order to import data from OpenStreetMap to SQL, a command-line tool is available at https://github.com/openstreetmap/osm2pgsql. Edit the convertOSM.bat files to have your database name and username. Run the OSM.bat scipt and the data will be loaded into the PostGIS database. 
Here is the SQL query for finding whether a wetland intersected a subward:

```
/*Selects only natural areas classified as wetlands and wetlands*/
create view wetlands as
select *
from planet_osm_polygon
where “natural” = ‘wetland’
or wetland is not null;

/*adds a ‘wetland1’ column with a Boolean (true/false) type*/
alter table subwards add column wetland1 boolean;

/*finds subward geometires that intersect wetland geometries and fills the ‘wetland1’ table with true (yes it intersects) and false (no it does not intersect) values*/
update subwards
set wetland1= st_intersects(subwards.geom, wetland.way)
from wetland
```

Adding in a wetland component to the vulnerability/resilience analysis could be achieved with more work. Some ideas are adding a buffer to the wetlands depending on elevation and/or seeing what percent of the subward intersects the wetland (I believe other people in the class may have done this percent analysis).

Resources:
Celia Ripple, Middlebury College Open Source GIScience course, QGIS, PostGIS, Resilience Academy, OpenStreetMap, OSM2toSQL

