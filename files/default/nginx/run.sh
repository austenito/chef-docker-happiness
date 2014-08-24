#!/bin/bash

mkdir /log/nginx

sed -i "0,/server .*/s//server ${RAILS_EXAMPLE_PORT_3000_TCP_ADDR}:${RAILS_EXAMPLE_PORT_3000_TCP_PORT};/" /etc/nginx/nginx.conf

/usr/sbin/nginx
