#!/bin/bash

#ON RIAK NODE:
#riak-admin bucket-type create conddb '{"props":{ "n_val":1, "allow_mult":false }}'
#riak-admin bucket-type activate conddb

# TAG:
echo "WOOF -> Creating TAG schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-tag -d @sch-tag.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-tag -d'{"schema":"sch-tag", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
# If you want to delete index: curl -XDELETE http://riak-test.cern.ch:8098/search/index/idx-tags # same for tags
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/tag/props -d '{"props":{"search_index":"idx-tag"}}' -H 'Content-Type: application/json'


# IOV:
echo "WOOF -> Creating IOV schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-iov -d @sch-iov.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-iov -d'{"schema":"sch-iov", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/iov/props -d '{"props":{"search_index":"idx-iov"}}' -H 'Content-Type: application/json'


# PAYLOAD (only metadata):
echo "WOOF -> Creating PAYLOAD schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-payload -d @sch-payload.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-payload -d'{"schema":"sch-payload", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/payload/props -d '{"props":{"search_index":"idx-payload"}}' -H 'Content-Type: application/json'


# TAGMIGRATION:
echo "WOOF -> Creating TAGMIGRATION schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-tagmigration -d @sch-tagmigration.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-tagmigration -d'{"schema":"sch-tagmigration", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/tagmigration/props -d '{"props":{"search_index":"idx-tagmigration"}}' -H 'Content-Type: application/json'


# PAYLOADMIGRATION:
echo "WOOF -> Creating PAYLOADMIGRATION schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-payloadmigration -d @sch-payloadmigration.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-payloadmigration -d'{"schema":"sch-payloadmigration", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/payloadmigration/props -d '{"props":{"search_index":"idx-payloadmigration"}}' -H 'Content-Type: application/json'


# GT:
echo "WOOF -> Creating GT schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-gt -d @sch-gt.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-gt -d'{"schema":"sch-gt", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/gt/props -d '{"props":{"search_index":"idx-gt"}}' -H 'Content-Type: application/json'


# GTMAP:
echo "WOOF -> Creating GTMAP schema, idx and bucket-type..."
curl -XPUT http://riak-test.cern.ch:8098/search/schema/sch-gtmap -d @sch-gtmap.xml -H 'Content-Type: application/xml'
curl -XPUT http://riak-test.cern.ch:8098/search/index/idx-gtmap -d'{"schema":"sch-gtmap", "n_val":1, "allow_mult":false}' -H 'Content-Type: application/json'
curl -XPUT http://riak-test.cern.ch:8098/types/conddb/buckets/gtmap/props -d '{"props":{"search_index":"idx-gtmap"}}' -H 'Content-Type: application/json'


