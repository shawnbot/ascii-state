#!/bin/sh
state="${1:-CA}"
layer=cb_2013_us_state_5m
if [ ! -f $layer.shp ]; then
    curl -O http://www2.census.gov/geo/tiger/GENZ2013/$layer.zip
    unzip $layer.zip
fi
ogr2ogr -F GeoJSON -t_srs EPSG:4326 \
  -sql "SELECT * FROM $layer WHERE STUSPS = '$state' OR NAME = '$state'" \
  /dev/stdout $layer.shp \
  | ./node_modules/.bin/geotype -z 11 --no-color
