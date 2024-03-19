#!/bin/sh

# Start Apache HTTP Server
/usr/sbin/httpd -DFOREGROUND &

# Start PHP-FPM
php-fpm -F