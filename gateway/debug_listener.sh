#!/bin/bash
cd `dirname $0`
source ./config.sh

sdkperf_java.sh -cip=$vmr -cu=@restgw -stl=\> -md -q
