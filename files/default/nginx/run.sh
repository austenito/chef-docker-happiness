#!/bin/bash

sed -i "0,/server .*/s//server ${FRONTEND_PORT_3001_TCP_ADDR}:${FRONTEND_PORT_3001_TCP_PORT};/" /etc/nginx/nginx.conf

/usr/sbin/nginx
