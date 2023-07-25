#!/bin/bash

service mysql start

counter=0
while ! mysqladmin ping --silent && [[ $counter -lt 30 ]]; do
	sleep 1
	((counter++))
	echo "Waiting for mysql server to start. $counter/30 seconds passed."
done

if [ ! -f "/.root_pw" ]; then

touch .root_pw

echo "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ADMIN_PW') WHERE User='root' ;" >> .root_pw
echo "DELETE FROM mysql.user WHERE User='' ;" >> .root_pw
echo "DELETE FROM mysql.user WHERE User='$MYSQL_ADMIN_USER' AND Host NOT IN ('localhost', '127.0.0.1', '::1') ;" >> .root_pw
echo "DROP DATABASE IF EXISTS test ;" >> .root_pw
echo "DELETE FROM mysql.db WHERE Db='test' ;" >>.root_pw
echo "FLUSH PRIVILEGES ;" >> .root_pw

mysql -u root < .root_pw

fi

if [ ! -f "/.setup" ]; then

touch .setup

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> .setup
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> .setup
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' WITH GRANT OPTION ;" >> .setup
echo "FLUSH PRIVILEGES ;" >> .setup

mysql < .setup

fi

mysqld
