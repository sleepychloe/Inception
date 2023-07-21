FROM debian:buster

RUN apt-get -y update && \
	apt-get -y upgrade

# RUN apt-get install -y dumb-init && \
	# chmod +x /usr/bin/dumb-init

RUN apt-get install -y nginx

RUN apt-get install -y openssl && \
	mkdir -p /etc/nginx/tls && \
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/tls/yhwang.42.fr.crt -keyout /etc/nginx/tls/yhwang.42.fr.key -subj "/C=FR/ST=PARIS/L=PARIS/O=42Paris/OU=yhwang/CN=yhwang.42.fr"

RUN rm -rf /etc/nginx/conf.d/default.conf

COPY ./tools/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

# handling dumb-init
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
