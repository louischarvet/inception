FROM debian:bullseye

EXPOSE 9000

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y --fix-missing curl \
    php7.4 \
    php7.4-mysqli \
    php7.4-fpm \
    mariadb-client

COPY ./wordpress_entrypoint.sh /wordpress_entrypoint.sh
RUN chmod +x /wordpress_entrypoint.sh
ENTRYPOINT ["/wordpress_entrypoint.sh"]