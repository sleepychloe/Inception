#!/bin/bash

service mysql start

counter=0
while ! mysqladmin ping --silent && [[ $counter -lt 30 ]]; do
	sleep 1
	((counter++))
	echo "Waiting for mysql server to start. $counter/30 seconds passed."
done

if [ ! -f "/.setup" ]; then

touch .setup

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> .setup
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> .setup
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' WITH GRANT OPTION ;" >> .setup
echo "ALTER USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PW' ;" >> .setup
echo "FLUSH PRIVILEGES ;" >> .setup

mysql < .setup

fi

mysqld
