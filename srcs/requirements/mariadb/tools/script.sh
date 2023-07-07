#!/bin/bash

if [ ! -f "/.mysql" ]; then

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

touch .mysql

# echo "SET PASSWORD FOR '$MYSQL_ADMIN_USER'@'localhost' = PASSWORD('$MYSQL_ADMIN_PW') ;" >> .mysql
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" >> .mysql
echo "CREATE USER IF NOT EXISTS'$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW' ;" >> .mysql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* to '$MYSQL_USER'@'%';" >> .mysql
echo "ALTER USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PW' ;" >> .mysql
echo "FLUSH PRIVILEGES ;" >> .mysql

#service mysql start -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW && \
#mysql_install_db --basedir=usr --datadir=/var/lib/mysql --user=mysql --rpm && \
#mysql -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PW $MYSQL_DB_NAME < .mysql

pkill mariadb

fi

#mysqld
/usr/bin/mysqld_safe --datadir=/var/lib/mysql