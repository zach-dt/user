#!/bin/bash
# Allows you to run any script in the load subdirectory with options to control virtual user count, loop count and think time
# Usage:
# ./run_tests.sh check_endpoints.jmx RESULTSDIR SERVER_URL [VU_COUNT] [LOOP_COUNT] [THINK_TIME in ms]
# Example:
# ./run_tests.sh check_endpoints.jmx results myservice.acmworkshops.inthecloud.com
# ./run_tests.sh check_endpoints.jmx results myservice.acmworkshops.inthecloud.com 10 50 500
if [ -z "$1" ]; then
  echo "Usage: Arg 1 needs to be valid load/<yourtestscript>.jmx"
  exit 1
fi
if [ -z "$2" ]; then
  echo "Usage: Arg 2 needs to be the name of your raw results directory"
  exit 1
fi
if [ -z "$3" ]; then
  echo "Usage: Arg 3 needs to be the URL or IP of your service that should be tested, e.g: myservice.acmworkshops.inthecloud.com"
  exit 1
fi

ADDITIONAL_PARAMS=""
if [ -z "$4" ]; then
  echo "Default VUCount"
else
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+"-JVUCount=$4"
fi
if [ -z "$5" ]; then
  echo "Default LoopCount"
else
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+" -JLoopCount=$5"
fi
if [ -z "$6" ]; then
  echo "Default ThinkTime"
else
  ADDITIONAL_PARAMS=$ADDITIONAL_PARAMS+" -JThinkTime=$6"
fi

echo "Running with SERVER_URL=$3, AdditionalParams=$ADDITIONAL_PARAMS"

sudo rm -f -r $2
sudo mkdir $2
sudo docker run --name jmeter-test -v "${PWD}/load":/load -v "${PWD}/$2":/results --rm -d jmeter ./jmeter/bin/jmeter.sh -n -t /load/$1 -e -o /results -l result.tlf -JSERVER_URL="$3" -JDT_LTN="$DT_LTN" $ADDITIONAL_PARAMS