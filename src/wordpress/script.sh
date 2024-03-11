#!/bin/bash

# Create directory for PHP
mkdir -p /run/php/

# Check if wp-config.php exists in /var/www/html
if [ -f "/var/www/html/wp-config.php" ]; then
    exec "$@";
    exit 0;
fi

chmod -R 755 /var/www/html
chown www-data:www-data /var/www/html


if [ ! -f "/usr/local/bin/wp" ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

cd /var/www/html

rm -rf *

wp core download --allow-root


wp config create --allow-root \
                 --dbname=$DATABASE_NAME \
                 --dbuser=$DATABASE_ROOT \
                 --dbpass=$DATABASE_ROOT_PASSWORD \
                 --dbhost=mariadb:3306 \
                 --path='/var/www/html/'

echo "define( 'WP_DEBUG', true );" >> /var/www/html/wp-config.php
echo "define( 'WP_DEBUG_LOG', true );" >> /var/www/html/wp-config.php
echo "define( 'WP_DEBUG_DISPLAY', false );" >> /var/www/html/wp-config.php
echo "@ini_set( 'display_errors', 0 );" >> /var/www/html/wp-config.php

exec "$@"