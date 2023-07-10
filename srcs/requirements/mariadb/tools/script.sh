#!/bin/bash

# if [ ! -f "/setup.sql" ]; then

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

touch setup.sql

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> setup.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> setup.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' WITH GRANT OPTION ;" >> setup.sql
echo "FLUSH PRIVILEGES ;" >> setup.sql
echo "ALTER USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PW' ;" >> setup.sql

#pkill mysqld
# fi


service mysql start

# myslqd < setup.sql
mysql -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW < setup.sql

mysqld
# /usr/bin/mysqld_safe --datadir=/var/lib/mysql < setup.sql
/usr/bin/mysqld_safe --datadir=/var/lib/mysql
# mysqld
