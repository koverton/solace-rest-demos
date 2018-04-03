#!/bin/bash -x
cd `dirname $0`
source ./config.sh

sempbase=http://$vmr:8080/SEMP/v2/config
vpnsbase=$sempbase/msgVpns
vpnurl=$vpnsbase/restgw
q1url=$vpnurl/queues/rdp1q1
rdp1url=$vpnurl/restDeliveryPoints/rdp1

# create the vpn
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$vpnsbase -d @data/vpn.json

# enable the default client-username
curl -X PATCH -u admin:admin -H 'Content-Type: application/json' \
	$vpnurl/clientUsernames/default -d @data/cu.json
# enable AD on the default client-profile
curl -X PATCH -u admin:admin -H 'Content-Type: application/json' \
	$vpnurl/clientProfiles/default -d @data/cp.json

# create the queue
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$vpnurl/queues -d @data/rdp1_q1.json
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$q1url/subscriptions -d @data/rdp1_q1_sub1.json

# Create the RDP
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$vpnurl/restDeliveryPoints -d @data/rdp1.json

# Create the RDP Q-Binding
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$rdp1url/queueBindings -d @data/rdp1_qb1.json

# Create the RDP Consumer
curl -X POST -u admin:admin -H 'Content-Type: application/json' \
	$rdp1url/restConsumers -d @data/rdp1_con1.json


