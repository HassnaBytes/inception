#!/bin/bash

service mysql start;
sleep 3;

WP_DB_PASS=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/${WP_DB_NAME}" ]
then
    echo "creating database: ${WP_DB_NAME}"
     
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${WP_DB_NAME}\`;"

    mysql -e "CREATE USER IF NOT EXISTS  \`${WP_DB_USER}\`@'localhost' IDENTIFIED BY '${WP_DB_PASS}';"

    mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DB_NAME}\`.* TO \`${WP_DB_USER}\`@'%' IDENTIFIED BY '${WP_DB_PASS}';"

    mysql -e "FLUSH PRIVILEGES;"
fi
service mysql stop;
exec mysqld_safe