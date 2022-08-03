#!/bin/bash

kubectl debug busybox --image=jandroavicloud/performance-debugger:latest --share-processes --copy-to=performance-debugger
sleep 70
kubectl cp performance-debugger:/scripts/performance_output.tar.gz performance_output.tar.gz
kubectl delete pod performance-debugger --force --grace-period=0