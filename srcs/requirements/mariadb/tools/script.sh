#!/bin/bash

# if [ ! -f "/setup.sql" ]; then
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

while ! mysqladmin ping --silent; do
	sleep 1
done

touch root_pw.sql

echo "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ADMIN_PW') WHERE User='root' ;" >> root_pw.sql
echo "DELETE FROM mysql.user WHERE User='' ;" >> root_pw.sql
echo "DELETE FROM mysql.user WHERE User=$MYSQL_ADMIN_USER' AND Host NOT IN ('localhost', '127.0.0.1', '::1') ;" >> root_pw.sql
echo "DROP DATABASE IF EXISTS test ;" >> root_pw.sql
echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%' ;" >> root_pw.sql
echo "FLUSH PRIVILEGES ;" >> root_pw.sql

mysql -u root < root_pw.sql


touch setup.sql

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> setup.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> setup.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' WITH GRANT OPTION ;" >> setup.sql
echo "FLUSH PRIVILEGES ;" >> setup.sql


mysql -u $MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW < setup.sql

while ! mysqladmin ping --silent; do
	sleep 1
done
#fi

mysqld

/usr/bin/mysqld_safe --datadir=/var/lib/mysql
