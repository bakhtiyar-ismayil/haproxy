docker network create --driver=bridge mynetwork

docker run -d -p 80 --net mynetwork --name nginx1 nginx 

docker run -d -p 80 --net mynetwork --name nginx2 nginx

docker run -d -p 80 --net mynetwork --name nginx3 nginx

docker run -d --name haproxy --net mynetwork -v $(pwd):/usr/local/etc/haproxy:ro -p 80:80 -p 8404:8404  haproxytech/haproxy-alpine  # or just haproxy

now open 

http://localhost 

for NGINX test page , you can edit /etc/nginx/nginx.conf file for displaying NGINX1 , NGINX2 , NGINX3

Also you can change or run nginx (or another service ) on another port as:

docker run -d -p 8080:80 --net mynetwork --name nginx4 nginx 

But remember , you need to change default port from nginx.conf file 

docker exec -it nginx4 /bin/bash

vim /etc/nginx/conf.d/default.conf

After that you need to specify this port on haproxy.cfg file 

http://localhost:8404 

for HAproxy stats page 
