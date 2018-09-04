#!/bin/bash
# Starts a JMeter endpoint check
# Usage:
# ./run_tests.sh JMETERHOME TESTSCRIPT.JMX RESULTSDIR RESULT.JTL SERVER_URL [VU_COUNT] [LOOP_COUNT] [THINK_TIME in ms]
# Example:
# ./run_endpoint_checks.sh c:/jmeter/bin ./load/check_endpoints.jmx ./result.jtl myservice.acmworkshops.inthecloud.com
# ./run_endpoint_checks.sh c:/jmeter/bin ./load/check_endpoints.jmx ./result.jtl myservice.acmworkshops.inthecloud.com 10 50 500
if [ -z "$1" ]; then
  echo "Usage: Arg 1 needs to be PATH to your JMETERHOME"
  exit 1
fi
if [ -z "$2" ]; then
  echo "Usage: Arg 2 needs to be valid <yourtestscript>.jmx"
  exit 1
fi
if [ -z "$3" ]; then
  echo "Usage: Arg 3 needs to be the name of your raw results directory"
  exit 1
fi
if [ -z "$4" ]; then
  echo "Usage: Arg 4 needs to be a valid path for a <result>.jtl"
  exit 1
fi
if [ -z "$5" ]; then
  echo "Usage: Arg 5 needs to be the URL or IP of your service that should be tested, e.g: myservice.acmworkshops.inthecloud.com"
  exit 1
fi

ADDITIONAL_PARAMS=""
if [ -z "$6" ]; then
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+"-JVUCount=$6"
fi
if [ -z "$7" ]; then
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+" -JLoopCount=$7"
fi
if [ -z "$8" ]; then
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+" -JThinkTime=$8"
fi

$1/jmeter.sh -n -t $2 -o $3 -l $4 -JSERVER_URL="$5" $ADDITIONAL_PARAMS