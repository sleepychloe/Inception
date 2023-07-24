#!/bin/bash

service mysql start

counter=0
while ! mysqladmin ping --silent && [[ $counter -lt 30 ]]; do
	sleep 1
	((counter++))
	echo "Waiting for mysql server to start. $counter/30 seconds passed."
done

if [ ! -f "/root_pw.sql" ]; then

touch root_pw.sql

echo "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ADMIN_PW') WHERE User='root' ;" >> root_pw.sql
echo "DELETE FROM mysql.user WHERE User='' ;" >> root_pw.sql
echo "DELETE FROM mysql.user WHERE User='$MYSQL_ADMIN_USER' AND Host NOT IN ('localhost', '127.0.0.1', '::1') ;" >> root_pw.sql
echo "DROP DATABASE IF EXISTS test ;" >> root_pw.sql
echo "DELETE FROM mysql.db WHERE Db='test' ;" >> root_pw.sql
echo "FLUSH PRIVILEGES ;" >> root_pw.sql

mysql -u root < root_pw.sql

fi

if [ ! -f "/setup.sql" ]; then

touch setup.sql

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> setup.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> setup.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' WITH GRANT OPTION ;" >> setup.sql
echo "FLUSH PRIVILEGES ;" >> setup.sql

mysql < setup.sql

fi

mysqld
