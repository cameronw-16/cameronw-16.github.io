###Lab Three: Digital Elevation Models
9/26/2019

Today we worked with SAGA to create a model of streams and rivers based off of an Aster DEM. We chose to work with Mount Kilimanjaro,
so I downloaded the two tiles that cover Kilimanjaro. These two tiles are identified by their lower left coordinates: S04E037 and S03EO37.

After downloading the Aster data and opening it in SAGA, the first step we took to create the stream and river model was to mosaic the 
two tiles into one grid: Open Tools -> Grid -> Gridding -> Mosaicking. I adjusted the extend of the grids to only include Kilimanjaro.

![mosaic](mosaic_map.jpg) ![mosaic_legend](mosaic_map_legend.jpg)

Sources:
NASA/METI/AIST/Japan Spacesystems, and U.S./Japan ASTER Science Team. ASTER Global Digital Elevation
Model V003. 2019, distributed by NASA EOSDIS Land Processes DAAC,
https://doi.org/10.5067/ASTER/ASTGTM.003.

Opensource GISience course at Middlebury College
