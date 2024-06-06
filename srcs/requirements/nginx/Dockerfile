FROM debian:oldstable

ARG CERTS_PATH
ARG CERTS_KEY

RUN apt update && apt upgrade -y && apt install -y nginx && apt install -y openssl

RUN openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -sha256 \
    -keyout ${CERTS_KEY} \
    -out ${CERTS_PATH} \
    -subj "/CN=rinacio.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]