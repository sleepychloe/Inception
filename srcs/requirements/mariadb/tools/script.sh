#!/bin/bash

if [ ! -f "/.mysql.sql" ]; then

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

touch .mysql.sql

echo "DELETE FROM mysql.user WHERE User='$MYSQL_ADMIN_USER' AND Host NOT IN ('localhost', '127.0.0.1', '::1') ;" >> .mysql.sql
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> .mysql.sql
echo "ALTER USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PW' ;" >> .mysql.sql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> .mysql.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> .mysql.sql
echo "FLUSH PRIVILEGES ;" >> .mysql.sql

pkill mysqld

fi

mysqld < .mysql.sql
# service mysql start -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW && \
# mysql -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW $MYSQL_DB_NAME < .mysql.sql

/usr/bin/mysqld_safe --datadir=/var/lib/mysql