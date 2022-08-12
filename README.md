# :owl: Whats is this? [WIP]

A simple way of debugging your `k8s` app using a lightweight container using [Kubernetes debug ephemeral containers](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container-example). It gathers the following data:

* top
* lsof
* vmstat
* iostat
* nfsiostat
* nfsstat 
## build_image.sh

```
docker build -t jandroavicloud/performance-debugger .
docker tag jandroavicloud/performance-debugger jandroavicloud/performance-debugger:latest
docker push jandroavicloud/performance-debugger:latest
```

## Dockerfile

```
FROM alpine:3.15.5

RUN apk add --no-cache \
    lsof \
    nethogs \
    procps \
    nfs-utils \
    tcpdump

RUN mkdir -p /scripts
COPY performance.sh /scripts

WORKDIR /scripts
RUN chmod +x performance.sh

CMD ["sh", "/scripts/performance.sh"]
```

## Test it

usage: run_performance_collection.sh <pod_name> <namespace>

```
 sh run_performance_collection.sh busybox default
```