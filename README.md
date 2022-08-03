# Whats is this? [WIP]

A simple way of debuggin your `k8s` app using a lightweight container.

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
    htop \
    iftop \
    iotop \
    iptraf-ng \
    lsof \
    nethogs \
    procps \
    tcpdump

RUN mkdir -p /scripts
COPY performance.sh /scripts

WORKDIR /scripts
RUN chmod +x performance.sh

CMD ["sh", "/scripts/performance.sh"]
```

## Test it

```
kubectl debug YOUR_APP --image=jandroavicloud/performance-debugger:latest --share-processes --copy-to=performance-debugger
sleep 70
kubectl cp performance-debugger:/scripts/performance_output.tar.gz performance_output.tar.gz
kubectl delete pod performance-debugger --force --grace-period=0
```