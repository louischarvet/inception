# 42 inception

In order to compile this project, **you need to join a .env file in srcs/ directory**. It must define the following variables:
WP_USER\
WP_USER_EMAIL\
WP_PASSWORD\
WP_ADMIN_PASSWORD\
SQL_USER\
SQL_DATABASE\
SQL_PASSWORD\
SQL_ROOT_PASSWORD

The purpose of this project is to set up a small infrastructure composed of three services, each being contained in its own Docker.

The services must communicate following a specific schema: Nginx serves as a reverse proxy, which communicates with WordPress, which communicates with MariaDB. The WordPress and MariaDB services have their own volumes.

Thus, the WordPress page we created has persistent data: user informations, comments, page editions...

*Be sure you can connect on the 443 port.*