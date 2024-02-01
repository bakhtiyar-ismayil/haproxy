#!/bin/bash

haproxy_config=$(cat <<EOL
global
  stats socket /var/run/api.sock user haproxy group haproxy mode 660 level admin expose-fd listeners
  log stdout format raw local0 info

defaults
  mode http
  timeout client 10s
  timeout connect 5s
  timeout server 10s
  timeout http-request 10s
  log global

frontend stats
  bind *:8404
  stats enable
  stats uri /
  stats refresh 10s

frontend frontend
  bind :80
  default_backend webservers

backend webservers
  server test1 nginx1:80 check
  server test2 nginx2:80 check
  server test3 nginx3:80 check
EOL
)

# Redirect the configuration to haproxy.cfg
echo "$haproxy_config" > haproxy.cfg

# Optionally, display a message indicating the operation is complete
echo "HAProxy configuration has been written to haproxy.cfg"


docker run -d -p 80 --net mynetwork --name nginx1 nginx

#docker exec -it nginx1 bash -c 'apt update && apt install -y vim' > output.log 2>&1 &

docker exec -it nginx1 sh -c 'echo "NGINX1" >> /usr/share/nginx/html/index.html'

docker run -d -p 80 --net mynetwork --name nginx2 nginx

docker exec -it nginx2 sh -c 'echo "NGINX2" >> /usr/share/nginx/html/index.html'

docker run -d -p 80 --net mynetwork --name nginx3 nginx

docker exec -it nginx3 sh -c 'echo "NGINX3" >> /usr/share/nginx/html/index.html'

docker run -d --name haproxy --net mynetwork -v $(pwd):/usr/local/etc/haproxy:ro -p 80:80 -p 8404:8404 haproxytech/haproxy-alpine # or just haproxy
