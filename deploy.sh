#!/bin/bash
echo "Hello"
sudo docker login
sudo docker build -t k2r2t2/demoapp .
sudo docker tag demoapp k2r2t2/demoapp:latest
sudo docker run -d -p 8003:8080 k2r2t2/demoapp