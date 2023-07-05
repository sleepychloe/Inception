FROM debian:buster

RUN apt-get -y update && \
	apt-get -y upgrade

RUN apt-get install -y dumb-init && \
	chmod +x /usr/bin/dumb-init

RUN apt-get -y install mariadb-server

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d
COPY ./tools/my.cnf /etc/mysql/my.cnf
COPY ./tools/script.sh /

RUN chmod +x /script.sh

EXPOSE 3306/tcp

#handling dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/script.sh"]
