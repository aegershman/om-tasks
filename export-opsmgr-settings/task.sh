#!/usr/bin/env bash

chmod +x om/om-linux
export PATH="$PATH:$(pwd)/om"

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	export-installation \
	--output-file "opsmgr-settings/$OM_OUTPUT_FILE"
