## Multi-criteria analysis of Vulnerability in Malawi

The goal of this lab was to try to reproduce the results found in [Vulnerability modeling for sub-saharan Africa: an oerational approach in Malawi](https://www.sciencedirect.com/science/article/pii/S0143622814000058).
To do this, data was collected from GDAM, DHS survey data, and UNEP Global Risk data. The data files and results from this lab are compiled in this [zip file](L78_data.zip). 

In order to convert the Malawi flood risk (fl_risk.tif) and drought exposure (dr_physexp.tif) rasters from UNEP Global Risk data into SQL code, we used the raster2pgsql command-line program. This commandline was adapted to have flags where users can input the coordinate reference system ID of their girds (-s) (we used 4326) and the ability to overwrite an existing table (-d).
```
:: [command line program] -s [coordinate reference system] -d [will overwrite existing tables] [raster] [name_of_postgres_schema.new_table_name] > [sql file name to store the raster data]
K:\gg323\raster2pgsql\raster2pgsql -s 4326 -d fl_risk.tif public.fl_risk > fl_risk.sql
K:\gg323\raster2pgsql\raster2pgsql -s 4326 -d dr_physexp.tif public.dr_physexp > dr_physexp.sql
```
The resulting SQL files were loaded into PostGIS.

The[Model](malawi_lab.model3) used is
Results:
The results were similar in that the southern end of Malawi tended to score higher on the resilience measurements; however, our reproduction was not complete. Principally, we we were not able to include all of the data the author used (missing the Livelihood Sensitivity from FEWSnet), and there was uncertainty in how the quantile values were assigned to the boolean DHS survey responses. This analysis was prefomed with SQL and PostGIS and with the above model in QGIS.

![grid](hhresilliencegrid.png)
![TAs](TAcapacities.png)

Malcomb et al. results:
![malcomb_grid](malcomb_grid.jpg)
![malcomb_TA](malcomb_TA.jpg)

Sources:
Malcomb, D. W., E. A. Weaver, and A. R. Krakowka. 2014. Vulnerability modeling for sub-Saharan Africa: An
operationalized approach in Malawi. Applied Geography 48:17–30.

Open Source GIScience course Middlebury College

PostGIS, QGIS

Find the data sets, models, qgis project and layers [here](L78_data.zip).
