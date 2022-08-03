#!/bin/bash

set +e

echo "Gathering performance data"

executions=5

mkdir -p performance_output/top

while [ $executions -gt 0 ] 
do
    top -bn1 > performance_output/top/top_$(date +%H:%M:%S).txt 
    echo "Sleeping for 10 seconds"
    sleep 10
    executions=$(( $executions - 1 ))
done

tar -zcvf performance_output.tar.gz /scripts/performance_output

echo "done!"

sleep 999999

