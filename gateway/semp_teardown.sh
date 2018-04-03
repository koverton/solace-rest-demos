#!/bin/bash -x
cd `dirname $0`
source ./config.sh

sempbase=http://$vmr:8080/SEMP/v2/config
vpnsbase=$sempbase/msgVpns
vpnurl=$vpnsbase/restgw
q1url=$vpnurl/queues/rdp1q1
rdp1url=$vpnurl/restDeliveryPoints/rdp1

curl -X DELETE -u admin:admin $rdp1url
curl -X DELETE -u admin:admin $q1url
curl -X DELETE -u admin:admin $vpnurl
