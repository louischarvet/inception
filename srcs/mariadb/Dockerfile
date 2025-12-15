FROM debian:bullseye

EXPOSE 3306

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install --fix-missing mariadb-server -y
RUN apt-get install inetutils-ping -y

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chown -R mysql:mysql /etc/mysql/

COPY ./initdb_script.sh /initdb_script.sh
RUN chmod +x /initdb_script.sh

COPY ./mariadb_entrypoint.sh /mariadb_entrypoint.sh
RUN chmod +x /mariadb_entrypoint.sh

ENTRYPOINT ["/mariadb_entrypoint.sh"]
