FROM debian:buster

RUN apt-get -y update && \
	apt-get -y upgrade

RUN apt-get install -y dumb-init && \
	chmod +x /usr/bin/dumb-init

#handling dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
