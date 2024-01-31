docker network create --driver=bridge mynetwork

docker run -d -p 80 --net mynetwork --name nginx1 nginx

docker run -d -p 80 --net mynetwork --name nginx2 nginx

docker run -d -p 80 --net mynetwork --name nginx3 nginx

docker run -d --name haproxy --net mynetwork -v $(pwd):/usr/local/etc/haproxy:ro -p 80:80 -p 8404:8404  haproxytech/haproxy-alpine
