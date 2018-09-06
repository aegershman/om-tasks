#!/usr/bin/env bash

chmod +x om/om-linux jq/jq-linux64
export PATH="$PATH:$(pwd)/om:$(pwd)/jq"

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	curl --path /api/v0/staged/products \
	>staged-products.json

PRODUCT_NAME=$(om-linux tile-metadata -p pivnet-product/*.pivotal --product-name)

PRODUCT_GUID=$(jq-linux64 \
	--raw-output \
	--arg product_name "$PRODUCT_NAME" \
	'map(select(.type == $product_name)) | .[].guid' \
	staged-products.json
)

STEMCELL_VERSION=$(jq-linux64 -r '.Release.Version' stemcell/metadata.json)

DATA=$(jq-linux64 \
	--null-input \
	--arg guid "$PRODUCT_GUID" \
	--arg stemcell_version "$STEMCELL_VERSION" \
	'
		{
		"products": [
				{
					"guid": $guid,
					"staged_stemcell_version": $stemcell_version
				}
			]
		}
	'
)

om-linux -k \
	--connect-timeout $OM_CONNECT_TIMEOUT \
	--request-timeout $OM_REQUEST_TIMEOUT \
	curl \
	--request PATCH \
	--path /api/v0/stemcell_assignments \
	--data "$DATA"
