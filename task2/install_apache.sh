#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install mc curl wget -y
sudo apt install php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear apache2 -y

mkdir -p /var/www/html
mv /var/www/html/index.html /var/www/html/index.html.default
touch /var/www/html/index.php

echo "<?php
\$ip_server = \$_SERVER['SERVER_ADDR'];
\$info_server =  php_uname();
\$os_server = PHP_OS;

echo \"<h1>Hello World!</h1><br>\";
echo \"<b>Server info:</b> \$info_server\", \"<br><p>\";
echo \"<b>Server OS:</b> \$os_server\", \"<br><p>\";
echo \"<b>Server IP Address is:</b> \$ip_server\", \"<br><p>\";
echo \"<b>Made by <font color=blue>Vitaliy Kostyukov</b>\";
?>" > /var/www/html/index.php;


systemctl restart apache2
systemctl enable apache2
