FROM debian:oldstable

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address" >> /etc/mysql/my.cnf

RUN if [ -f backup.sql ]; then \
        mariadb -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < backup.sql; \
    fi && \
    service mariadb start && \
    mariadb -u root -e \
    "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
    CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
    GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
    CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
    GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; \
    FLUSH PRIVILEGES;" && \
    service mariadb stop

CMD ["mysqld_safe"]