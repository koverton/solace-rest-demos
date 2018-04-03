#!/bin/bash -x

sempbase=http://192.168.56.201:8080/SEMP/v2/config
vpnbase=$sempbase/msgVpns/default
q1url=$vpnbase/queues/rdp1q1
rdp1url=$vpnbase/restDeliveryPoints/rdp1

curl -X DELETE -u admin:admin $rdp1url
curl -X DELETE -u admin:admin $q1url
exit 0
