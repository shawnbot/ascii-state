#!/bin/sh
npm install -g geotype
curl -O http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_us_state_5m.zip
unzip cb_2013_us_state_5m.zip
ogr2ogr -F GeoJSON -t_srs EPSG:4326 \
  -sql "SELECT * FROM states WHERE NAME = 'California'" \
  /dev/stdout cb_2013_us_state_5m.shp \
  | geotype -z 11 --no-color