#!/bin/bash

host=$primary
i=1
while [ 1 -eq 1 ]; do
	curl -X POST -d "Hello world $i" http://$host:9000/TOPIC/rest/pubsub \
		-H "content-type: text" -H "Solace-delivery-mode: direct" -H "Solace-Reply-Wait-Time-In-ms: 2000"
	i=$((i + 1))
	sleep 1
done
