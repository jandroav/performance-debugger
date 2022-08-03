#!/bin/bash

docker build -t jandroavicloud/performance-debugger .
docker tag jandroavicloud/performance-debugger jandroavicloud/performance-debugger:latest
docker push jandroavicloud/performance-debugger:latest