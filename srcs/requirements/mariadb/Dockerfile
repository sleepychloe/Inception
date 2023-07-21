FROM debian:buster

RUN apt-get -y update && \
	apt-get -y upgrade

# RUN apt-get install -y dumb-init && \
	# chmod +x /usr/bin/dumb-init

RUN apt-get -y install mariadb-server && \
	apt-get -y install procps && \
	mkdir -p /run/mysqld /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]

EXPOSE 3306/tcp

# handling dumb-init
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["mysqld"]
