#!/bin/bash

nginx -c /etc/nginx/nginx.conf
echo "nginx started...\n"
php-fpm
echo "php-fpm started...\n"
