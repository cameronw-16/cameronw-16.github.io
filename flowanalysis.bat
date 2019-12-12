::set the path to your SAGA program
SET PATH=%PATH%;c:\saga6

::set the prefix to use for all names and outputs
SET pre=small

::set the directory in which you want to save ouputs. In the example below, part of the directory name is the prefix you entered above
SET od=W:\final_project\lidar_tiles\lidar_used\%pre%lidar

:: the following creates the output directory if it doesn't exist already
if not exist %od% mkdir %od%

:: Run Mosaicking tool, with consideration for the input -These are the Lidar grids I used-
saga_cmd grid_tools 3 -GRIDS=Elevation_DEMHF0p7m2017_N4487E617.sgrd;Elevation_DEMHF0p7m2017_N4501E617.sgrd;Elevation_DEMHF0p7m2017_N4529E645.sgrd;Elevation_DEMHF0p7m2017_N4529E631.sgrd;Elevation_DEMHF0p7m2017_N4515E645.sgrd;Elevation_DEMHF0p7m2017_N4515E631.sgrd;Elevation_DEMHF0p7m2017_N4501E645.sgrd;Elevation_DEMHF0p7m2017_N4501E631.sgrd;Elevation_DEMHF0p7m2017_N4487E631.sgrd -NAME=%pre%Mosaic -TYPE=9 -RESAMPLING=1 -OVERLAP=3 -MATCH=0 -TARGET_OUT_GRID=%od%\%pre%mosaic.sgrd

:: Run UTM Projection tool
saga_cmd pj_proj4 24 -SOURCE=W:\final_project\lidar_tiles\lidar_used\%pre%lidar\%pre%mosaic.sgrd -RESAMPLING=1 -KEEP_TYPE=1 -GRID=%od%\%pre%mosaicUTM.sgrd -UTM_ZONE=18 -UTM_SOUTH=0

::Run Hillshade
saga_cmd ta_lighting 0 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SHADE=%od%\%pre%hillshade.sgrd -METHOD=0 -POSITION=0 -AZIMUTH=315.000000 -DECLINATION=45.000000 -EXAGGERATION=1.000000 -UNIT=0

::Run Sink Drainage Route Ditection
saga_cmd ta_preprocessor 1 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%sinkroute.sgrd -THRESHOLD=0 -THRSHEIGHT=100.000000

::Run Sink Removal
saga_cmd ta_preprocessor 2 -DEM=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%sinkroute.sgrd -DEM_PREPROC=%od%\%pre%sinkfill.sgrd -METHOD=1 -THRESHOLD=0 -THRSHEIGHT=100.000000

::Run Flow Accumulation
saga_cmd ta_hydrology 0 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%sinkroute.sgrd -WEIGHTS=NULL -FLOW=%od%\%pre%flowaccumulation.sgrd -VAL_INPUT=NULL -ACCU_MATERIAL=NULL -STEP=1 -FLOW_UNIT=0 -FLOW_LENGTH=NULL -LINEAR_VAL=NULL -LINEAR_DIR=NULL -METHOD=4 -LINEAR_DO=1 -LINEAR_MIN=500 -CONVERGENCE=1.100000

::Run Channel Network
saga_cmd ta_channels 0 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%sinkroute.sgrd -CHNLNTWRK=%od%\%pre%chnlntwrk_100000.sgrd -CHNLROUTE=%od%\%pre%chnlroute_100000.sgrd -SHAPES=%od%\%pre%chnlshapes_100000.sgrd -INIT_GRID=%od%\%pre%flowaccumulation.sgrd -INIT_METHOD=2 -INIT_VALUE=100000.000000 -DIV_GRID=NULL -DIV_CELLS=5 -TRACE_WEIGHT=NULL -MINLEN=10

::print a completion message so that uneasy users feel confident that the batch script has finished!
ECHO Processing Complete!
PAUSE