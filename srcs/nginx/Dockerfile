FROM debian:bullseye

EXPOSE 443

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install --fix-missing nginx -y
RUN apt-get install --fix-missing openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=NA/L=Angouleme/O=42/OU=42/CN=locharve.42.fr/UID=locharve"

RUN mkdir -p /var/run/nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY ./nginx_entrypoint.sh /nginx_entrypoint.sh
RUN chmod +x /nginx_entrypoint.sh
ENTRYPOINT ["/nginx_entrypoint.sh"]
