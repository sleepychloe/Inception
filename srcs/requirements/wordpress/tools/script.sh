#!/bin/bash

sleep 1;

echo "Testing databse connection.."
mysql -h$MARIADB_HOST -u$MYSQL_USER -p$MYSQL_PW -e "SHOW DATABASES;"

if [ ! -f "/var/www/wordpress/.wordpress" ]; then

cd /var/www/wordpress

sed -i "s/MYSQL_DB_NAME/$MYSQL_DB_NAME/g" wp-config.php
sed -i "s/MYSQL_USER/$MYSQL_USER/g" wp-config.php
sed -i "s/MYSQL_PW/$MYSQL_PW/g" wp-config.php
sed -i "s/MARIADB_HOST/$MARIADB_HOST/g" wp-config.php

wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PW --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --path=/var/www/wordpress --allow-root
wp theme install astra --activate --path=/var/www/wordpress --allow-root
wp plugin update --all --path=/var/www/wordpress --allow-root
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PW --path=/var/www/wordpress --allow-root

touch .wordpress

fi

# service php7.3-fpm start
/usr/sbin/php-fpm7.3 --nodaemonize
