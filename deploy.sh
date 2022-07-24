#!/bin/bash
echo "Hello"
sudo docker login
sudo docker build -t k2r2t2/demoapp .
docker run -d --name mytomcat -p 8080:8080 k2r2t2/demoapp:latest
docker exec -it mytomcat /bin/bash
mv webapps webapps2
mv webapps.dist/ webapps
exit
