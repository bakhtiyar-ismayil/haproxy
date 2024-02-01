docker network create --driver=bridge mynetwork

docker run -d -p 8080:80 --net mynetwork --name nginx1 nginx 

docker run -d -p 8080:80 --net mynetwork --name nginx2 nginx

docker run -d -p 8080:80 --net mynetwork --name nginx3 nginx

docker run -d --name haproxy --net mynetwork -v $(pwd):/usr/local/etc/haproxy:ro -p 80:80 -p 8404:8404  haproxytech/haproxy-alpine  # or just haproxy

now open 

http://localhost 

for NGINX test page , we can edit /etc/nginx/nginx.conf file for displaying NGINX1 , NGINX2 , NGINX3 

http://localhost:8404 

for HAproxy stats page 
