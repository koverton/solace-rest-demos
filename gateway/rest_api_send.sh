#!/bin/bash
cd `dirname $0`
source ./config.sh

if [ "$2" == "" ]; then
	echo "USAGE: $0 <http-method> <http-uri>"
	echo ""
	exit 1
fi
method=$1
uri=$2

curl -X $method -d "Hello world" http://$vmr:9001$uri \
	-H "content-type: text" # -H "Solace-delivery-mode: direct" -H "Solace-Reply-Wait-Time-In-ms: 2000"
