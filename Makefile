PROCESSED_ITEMS_AUSTRALIA = \
	zip/ste11aaust_shape.zip \
	shp/ste11aaust_shape.shp \
	topo/ste11aaust_shape.json

australia: $(PROCESSED_ITEMS_AUSTRALIA) 

#########################################################################################
# Data from Australian Bureau of Statistics:
# http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/1270.0.55.001July%202011?OpenDocument
#########################################################################################
#
# State and Territory ASGC Ed 2011 Digital Boundaries in ESRI Shapefile Format 
#
zip/ste11aaust_shape.zip:
	mkdir -p $(dir $@)
	wget "http://www.abs.gov.au/ausstats/subscriber.nsf/log?openagent&1259030001_ste11aaust_shape.zip&1259.0.30.001&Data%20Cubes&D39E28B23F39F498CA2578CC00120E25&0&July%202011&14.07.2011&Latest" -O $@.download
	mv $@.download $@

shp/ste11aaust_shape.shp: zip/ste11aaust_shape.zip
	mkdir -p $(dir $@)
	unzip -d shp $<
	touch $@

topo/ste11aaust_shape.json: shp/STE11aAust_shape.shp
	mkdir -p $(dir $@)
	mkdir -p data
	node_modules/.bin/topojson -p state=STATE_NAME,state_code=STATE_CODE -o data/australia.json australia=shp/STE11aAust.shp 


