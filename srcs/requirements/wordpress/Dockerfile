FROM debian:oldstable

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

WORKDIR /var/www/html/

RUN apt update -y && apt upgrade -y && apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client \
	wget \
	sudo

RUN sed -i.default "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php/[0-9]*.[0-9]*/fpm/pool.d/www.conf

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress && \
	rm -rf latest.tar.gz

RUN cp wp-config-sample.php wp-config.php && \
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php && \
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php && \
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php && \
	sed -i "s/localhost/mariadb/g" wp-config.php

RUN mkdir -p /run/php

RUN ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

CMD ["php-fpm", "-F"]