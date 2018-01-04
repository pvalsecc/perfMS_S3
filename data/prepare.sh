#!/bin/bash

set -e

#wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/raster/NE1_HR_LC_SR_W_DR.zip
unzip NE1_HR_LC_SR_W_DR.zip

gdal_translate NE1_HR_LC_SR_W_DR.tif NE1_HR_LC_SR_W_DR_int.tif -co tiled=yes -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co COMPRESS=DEFLATE -co PREDICTOR=2

gdaladdo -r average --config PHOTOMETRIC_OVERVIEW YCBCR --config COMPRESS_OVERVIEW JPEG --config JPEG_QUALITY_OVERVIEW 85 --config INTERLEAVE_OVERVIEW PIXEL NE1_HR_LC_SR_W_DR_int.tif 2 4 8 16 32

gdal_translate NE1_HR_LC_SR_W_DR_int.tif NE1_HR_LC_SR_W_DR_cloud.tif -co TILED=YES -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co COMPRESS=JPEG -co JPEG_QUALITY=85 -co PHOTOMETRIC=YCBCR -co COPY_SRC_OVERVIEWS=YES --config GDAL_TIFF_OVR_BLOCKSIZE 512
