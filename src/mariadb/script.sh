#!/bin/bash


if [ ! -d "/var/run/mysqld" ]; then
    mkdir -p /var/run/mysqld
    chown -R mysql:mysql /var/run/mysqld
fi

echo "[.] Starting MySQL Service"
service mysql start
sleep 10
echo "[.] Writing MySQL Instructions"
cat << EOF > mariadb.sql
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DATABASE_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER IF NOT EXISTS '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_USER_PASSWORD';
GRANT ALL ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_USER_PASSWORD';
FLUSH PRIVILEGES;
USE $DATABASE_NAME;
EOF

echo "running Mysql ..."
mysql -u root --password="$DATABASE_ROOT_PASSWORD" < mariadb.sql

echo "top mysql ..."
service mysql stop

echo "running MysqL Daemon ..."
exec $@