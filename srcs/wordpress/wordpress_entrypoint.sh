#!/bin/bash

# www.conf (php)
PHPCNF="www.conf"

cd /etc/php/7.4/fpm/pool.d/

if [ $(find . -name $PHPCNF | wc -l) -eq 0 ]; then
   touch $PHPCNF
fi

if grep -qE 'clear_env\s*=' "$PHPCNF"; then
    sed -i 's|^\s*;*\s*\(clear_env\s*=\s*no\)|\1|' "$PHPCNF"
else
    echo "clear_env = no" >> "$PHPCNF"
fi

if grep -qE 'listen\s*=' "$PHPCNF"; then
    sed -i 's|^\(listen =\).*|\1wordpress:9000|' "$PHPCNF"
else
    echo "listen = wordpress:9000" >> "$PHPCNF"
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php

# wp-config.php (wp)
WPCNF="wp-config.php"

mkdir -p /var/www/wordpress
chown -R root:root /var/www/wordpress
cd /var/www/wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sleep 5

if ! (./wp-cli.phar core is-installed 2>/dev/null --allow-root) ; then
    echo "Downloading Wordpress...";
    ./wp-cli.phar core download --allow-root;
    echo "Creating wp-config.php...";
    ./wp-cli.phar config create --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost=mariadb:3306 --path='/var/www/wordpress' --allow-root;
    echo "Installing Wordpress...";
    ./wp-cli.phar core install --url=localhost --title=inception --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
else
    echo "Wordpress is already installed."
fi
if ! (./wp-cli.phar user get ${WP_USER} 1>/dev/null 2>/dev/null --allow-root) ; then
    echo "Creating user ${WP_USER}...";
    ./wp-cli.phar user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_PASSWORD} --allow-root
else
    echo "User ${WP_USER} already exists."
fi

echo "Inception ready to use."

exec /usr/sbin/php-fpm7.4 -F