FROM debian:buster

RUN apt-get -y update && \
	apt-get -y upgrade

RUN apt-get install -y dumb-init && \
	chmod +x /usr/bin/dumb-init

RUN apt-get -y install \
	mariadb-client \
	curl \
	php7.3 \
	php7.3-fpm \
	php7.3-common \
	php7.3-mysql \
	php7.3-gmp \
	php7.3-curl \
	php7.3-intl \
	php7.3-mbstring \
	php7.3-xmlrpc \
	php7.3-gd \
	php7.3-xml \
	php7.3-cli \
	php7.3-zip \
	php7.3-soap \
	php7.3-imap

RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp && \
	chmod +x /usr/bin/wp 

RUN mkdir -p /var/www/wordpress 
WORKDIR /var/www/wordpress
RUN wp core download --allow-root

COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/wp-config.php /var/www/wordpress/wp-config.php
COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000/tcp
EXPOSE 3306/tcp

# ENTRYPOINT ["/script.sh"]

# handling dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

#CMD ["/usr/bin/php-fpm7.3", "-F"]
CMD ["/script.sh"]
