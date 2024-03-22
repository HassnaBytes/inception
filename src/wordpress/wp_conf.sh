#!/bin/sh

while ! mariadb -h${DB_HOST} -u${WP_DB_USER} -p${WP_DB_PASS} ${WP_DB_NAME} &>/dev/null;
do
	echo "waiting for mariadb..."
	sleep 3
done

chmod -R 755 /var/www/html/wordpress

if [ ! -f ${WP_PATH}/wp-config.php ]
then
    echo "[ wordpress ] installing..."
    wp cli update --yes --allow-root
    wp core download --allow-root
    wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS} --dbhost=${DB_HOST} --path=${WP_PATH} --allow-root
    wp core install --url=${NGINX_HOST} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --path=${WP_PATH} --allow-root
    wp user create $WP_USER ${WP_USER_EMAIL} --user_pass=${WP_USER_PASS} --role=subscriber --display_name=${WP_USER} --porcelain --path=${WP_PATH} --allow-root
    wp plugin update --all --allow-root
    echo "[ wordpress ] finished installation."
else
    echo "[ wordpress ] already installed"
fi


exec /usr/sbin/php-fpm81 -F -R