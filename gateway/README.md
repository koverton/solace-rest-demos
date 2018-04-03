# Solace REST MicroGateway Sample

[REST MicroGateway concepts](https://docs.solace.com/Features/REST-Gateway-Concepts/REST-Gateway-Concepts.htm)

Sample scripts for demoing Solace REST MicroGateway for microservices applications.

The package expects to run under a linux distribution with a node.js installation.

## Demo Steps

1. Modify the `config.sh` and `data/rdp1_con1.json` files to match servers
used for your demo (see [Required Modifications](#required-modifications) below)

2. Setup the new msg-VPN on Solace VMR with REST configurations

```bash
./semp_setup.sh
...
```

3. Start your `node_server.js` script to listen for HTTP requests from Solace

```bash
[koverton@merzbow rest]$ cd gateway/
[koverton@merzbow gateway]$ ls
node_server.js
[koverton@merzbow gateway]$ ./node_server.js
Server running at http://merzbow:43210
...
```

4a. Run any REST request, publishing requests to the VMR, validating that
they are received by the node_server and replies come back to the original sender:

```bash
./rest_api_send.sh POST /svc1/my/target/url
Hello world
./rest_api_send.sh GET /svc1/my/other/target/url
Hello world
./rest_api_send.sh DELETE /svc1/my/delete/target/url
Hello world
./rest_api_send.sh PATCH /svc1/my/delete/target/url
Hello world
```

4b. Optionally, you can run a debugging sdkperf listener to eavesdrop on
all communications:

```bash
xenakis:gateway koverton$ ./debug_listener.sh
CLASSPATH: :./lib/commons-cli-1.2.jar:./lib/commons-lang-2.6.jar:./lib/commons-logging-1.1.3.jar:./lib/geronimo-jms_1.1_spec-1.1.1.jar:./lib/sol-common-7.2.2.100.jar:./lib/sol-jcsmp-7.2.2.100.jar:./lib/sol-jms-7.2.2.100.jar:./lib/sol-sdkperf-7.2.2.29.jar:./lib/sol-sdkperf-jcsmp-7.2.2.29.jar:./lib/sol-sdkperf-jms-7.2.2.29.jar:./lib/thirdparty/*.jar:./lib/optional/log4j.jar:./lib/optional/
JAVA: /usr/bin/java
SOLACE_VM_ARGS: -Xms512m -Xmx1024m
Run Info: CPU usage currently disabled.
Client naming used:
	logging ID   = perf_client000001
	username     = perf_client000001
	vpn          = restgw
	client names = sdk generated.

> VM Name: Java HotSpot(TM) 64-Bit Server VM
Run Info: Using Java Nanosecond Timer for Timing
> Timing Package Clock Speed (Hz): 1000000000
> Getting ready to init clients
> Adding subscriptions if required
> Getting ready to start clients.
^^^^^^^^^^^^^^^^^^ Start Message ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Destination:                            Topic 'PUT/svc1/whatever/you/want'
AppMessageID:                           ID:Solace-070e7468be945ab7
Priority:                               0
Class Of Service:                       USER_COS_1
DeliveryMode:                           DIRECT
Message Id:                             6
ReplyTo:                                Topic '#RT/v:solprimary/rest-a9dd0f7cb8b1da53/PUT/svc1/whatever/you/want'
TimeToLive:                             30000
User Property Map:                      4 entries
  Key 'JMS_Solace_HTTP_field_Accept' (String): */*
  Key 'JMS_Solace_HTTP_field_User-Agent' (String): curl/7.54.0
  Key 'JMS_Solace_HTTP_method' (String): PUT
  Key 'JMS_Solace_HTTP_target_path' (String): svc1/whatever/you/want

HTTP Content Type:                      text
Binary Attachment:                      len=17
  1f 00 00 00 11 48 65 6c    6c 6f 20 77 6f 72 6c 64    .....Hello.world
  00                                                    .


^^^^^^^^^^^^^^^^^^ End Message ^^^^^^^^^^^^^^^^^^^^^^^^^^^
^^^^^^^^^^^^^^^^^^ Start Message ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Destination:                            Topic '#RT/v:solprimary/rest-a9dd0f7cb8b1da53/PUT/svc1/whatever/you/want'
AppMessageID:                           ID:Solace-070e7468be945ab7
CorrelationId:                          ID:Solace-070e7468be945ab7
Priority:                               0
Class Of Service:                       USER_COS_1
DeliveryMode:                           DIRECT
Message Id:                             7
Reply Message
User Property Map:                      3 entries
  Key 'JMS_Solace_HTTP_field_Date' (String): Mon, 02 Apr 2018 14:23:39 GMT
  Key 'JMS_Solace_HTTP_status_code' (Integer): 200
  Key 'JMS_Solace_HTTP_reason_phrase' (String): OK

Binary Attachment:                      len=13
  48 65 6c 6c 6f 20 77 6f    72 6c 64 0d 0a             Hello.world..


^^^^^^^^^^^^^^^^^^ End Message ^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

## Required Modifications

the demos are setup to run on my local host against a local-only network
(192.168.56.1).
the following items are expected to require modification to run in your
environment:

* `config.sh`: this sets the shared variable for the ip-address of the
vmr `host` and should be modified to point to your local vmr appropriately
* `data/rdp1_con1.json`: this semp data defines the http address used
by solace to route http requests out to your web-service; the ip-address
used in this data should point to the ip-address of the host running the
`node_server.js` script


