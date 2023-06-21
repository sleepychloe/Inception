#!/bin/bash

service mysql start

touch .mysql
echo "CREATE DATABASE $MYSQL_DB_NAME ;" >> .mysql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> .mysql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* to '$MYSQL_USER'@'%' ;" >> .mysql
echo "FLUSH PRIVILEGES ;" >> .mysql

mysql < .mysql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
