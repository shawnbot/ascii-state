#!/bin/sh
npm install geotype
layer=cb_2013_us_state_5m
curl -O http://www2.census.gov/geo/tiger/GENZ2013/$layer.zip
unzip -f $layer.zip
ogr2ogr -F GeoJSON -t_srs EPSG:4326 \
  -sql "SELECT * FROM $layer WHERE NAME = 'California'" \
  /dev/stdout $layer.shp \
  | ./node_modules/.bin/geotype -z 11 --no-color