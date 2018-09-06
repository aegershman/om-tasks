#!/usr/bin/env bash

chmod +x om/om-linux
export PATH="$PATH:$(pwd)/om"

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	curl \
	--path /api/v0/diagnostic_report \
	>"diagnostic-report/${OM_OUTPUT_FILE}.json"
