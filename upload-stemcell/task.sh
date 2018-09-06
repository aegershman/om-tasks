#!/usr/bin/env bash

chmod +x om/om-linux
export PATH="$PATH:$(pwd)/om"

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	upload-stemcell \
	--force \
	--floating="false" \
	--stemcell stemcell/*.tgz
