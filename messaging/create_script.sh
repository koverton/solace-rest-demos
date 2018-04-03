#!/bin/bash -x

sempbase=http://192.168.56.201:8080/SEMP/v2/config
vpnbase=$sempbase/msgVpns/default
q1url=$vpnbase/queues/rdp1q1
rdp1url=$vpnbase/restDeliveryPoints/rdp1


# create the queue
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$vpnbase/queues -d @rdp1_q1.json
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$q1url/subscriptions -d @rdp1_q1_sub1.json

# Create the RDP
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$vpnbase/restDeliveryPoints -d @rdp1.json

# Create the RDP Q-Binding
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$rdp1url/queueBindings -d @rdp1_qb1.json

# Create the RDP Consumer
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$rdp1url/restConsumers -d @rdp1_con1.json

