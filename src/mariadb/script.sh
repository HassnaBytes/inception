#!/bin/bash

# Set ownership of MySQL data directory
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi
# Initialize MySQL data directory (if needed)
if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql
    	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

service mysql start

if mysql -u root -e "USE word" > /dev/null 2>&1; then
    echo "Database 'word' already exists."
else
    # Create the WordPress database and user
    mysql -u root -e "CREATE DATABASE word;"
    mysql -u root -e "GRANT ALL PRIVILEGES ON word.* TO 'word'@'%' IDENTIFIED BY 'password';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    echo "Database 'word' created."
fi
# Create the WordPress database and user
#mysql -u root -e "CREATE DATABASE wordpress;"
#mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';"
#mysql -u root -e "FLUSH PRIVILEGES;"
# start MySQL service
#service mysql start

# Keep the script running indefinitely
tail -f /dev/null