#!/usr/bin/env bash

chmod +x om/om-linux
export PATH="$PATH:$(pwd)/om"

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	stage-product \
	--product-name $(om-linux tile-metadata -p pivnet-product/*.pivotal --product-name) \
	--product-version $(om-linux tile-metadata -p pivnet-product/*.pivotal --product-version)
