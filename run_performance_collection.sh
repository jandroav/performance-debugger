#!/bin/bash

show_help () {
    echo "usage: run_performance_collection.sh <pod_name> <namespace>"
}

if [[ $# -eq 0 ]] ; then
    echo 'No arguments supplied'
    show_help
    exit 1
fi

if [ -z "$1" ]
  then
    echo "Application to debug not supplied"
    show_help
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Namespace not supplied"
    show_help
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters. I just need the name of the pod you want to debug and its namespace"
    show_help
    exit 1
fi

echo "Deleting performance-debugger pod if it exists..."
kubectl delete pod performance-debugger --force --grace-period=0 > /dev/null 2>&1
app_to_debug=$(kubectl get pod $1 -o custom-columns=":metadata.name" -n $2)

if [ -z "$app_to_debug" ]; then
    echo "No pod found with name $1"
    exit 1
fi

debugger_container=$(kubectl debug $1 --image=jandroavicloud/performance-debugger:latest --share-processes --copy-to=performance-debugger -n $2 | egrep -io 'debugger-[a-zA-Z0-9]*')
echo "${debugger_container} created..."
echo "Gathering performance data..."
sleep 80
echo "Copying data to your current directory..."
kubectl cp -c $debugger_container performance-debugger:/scripts/performance_output.tar.gz performance_output.tar.gz -n $2
echo "Done!"
echo "Deleting performance-debugger pod"
kubectl delete pod performance-debugger --force --grace-period=0 -n $2
