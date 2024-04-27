#!/bin/sh


chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html

#password:
WP_DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASS=$(cat /run/secrets/db_root_password)
WP_ADMIN_USER=$(cat /run/secrets/password_admin)

if [ ! -f ${WP_PATH}/wp-config.php ]
then
    wp cli update --yes --allow-root
    wp core download --allow-root
    wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS} --dbhost=${DB_HOST} --path=${WP_PATH} --allow-root
    wp core install --url=${NGINX_HOST} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --path=${WP_PATH} --allow-root
    wp user create $WP_USER ${WP_USER_EMAIL} --user_pass=${WP_USER_PASS} --role=subscriber --display_name=${WP_USER} --porcelain --path=${WP_PATH} --allow-root
    wp plugin update --all --allow-root

    chown -R www-data:www-data /var/www/html/wordpress
    chmod -R 755 /var/www/html/wordpress
    chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads
    chmod -R 755 /var/www/html/wordpress/wp-content/uploads
    chmod -R 755 /var/www/html/wordpress/wp-content/uploads/2024
    chmod -R 755 /var/www/html/wordpress/wp-content/uploads/2024/04
    echo "wordpress  finished installation."
  
else
    chown -R www-data:www-data /var/www/html/wordpress
    chmod  -R 755 /var/www/html/wordpress/wp-content/uploads
    echo "wordpress  already installed"
fi

exec /usr/sbin/php-fpm7.3 -F -R
