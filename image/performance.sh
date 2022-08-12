#!/bin/bash

set +e

echo "Gathering performance data"

executions=5

mkdir -p performance_output/top performance_output/lsof performance_output/vmstat performance_output/iostat performance_output/nfsiostat

while [ $executions -gt 0 ] 
do
    top -bn1 > performance_output/top/top_$(date +%H:%M:%S).txt &
    lsof > performance_output/lsof/lsof_$(date +%H:%M:%S).txt &
    vmstat > performance_output/vmstat/vmstat_$(date +%H:%M:%S).txt &
    iostat -t  > performance_output/iostat/iostat_$(date +%H:%M:%S).txt &
    nfsiostat > performance_output/nfsiostat/nfsiostat_$(date +%H:%M:%S).txt &
    nfsstat -c > performance_output/nfsstat/nfsstat_$(date +%H:%M:%S).txt &
    echo "Sleeping for 10 seconds"
    sleep 10
    executions=$(( $executions - 1 ))
done

cd /scripts
tar -zcvf performance_output.tar.gz /performance_output

echo "done!"

sleep 999999

