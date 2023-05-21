echo "Welcome to install Wordpress on ubuntu"
echo "Let's Go"

echo "_____________________________________________________________"            
echo "01.Dependencies Installed"
echo "_____________________________________________________________"
    sudo apt update
    sudo apt install apache2 \
                    ghostscript \
                    libapache2-mod-php \
                    mysql-server \
                    php \
                    php-bcmath \
                    php-curl \
                    php-imagick \
                    php-intl \
                    php-json \
                    php-mbstring \
                    php-mysql \
                    php-xml \
                    php-zip


echo "_____________________________________________________________"            
echo "01.Done"
echo "_____________________________________________________________"

echo "02.Start Install Wordpress"
echo "_____________________________________________________________"


    sudo mkdir -p /srv/www
    sudo chown www-data: /srv/www
    curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

echo "_____________________________________________________________"
echo "02.Done"
echo "_____________________________________________________________"

echo "03.Configure Apache for WordPress"
echo "_____________________________________________________________"
    echo "<VirtualHost *:80>
        DocumentRoot /srv/www/wordpress
        <Directory /srv/www/wordpress>
            Options FollowSymLinks
            AllowOverride Limit Options FileInfo
            DirectoryIndex index.php
            Require all granted
        </Directory>
        <Directory /srv/www/wordpress/wp-content>
            Options FollowSymLinks
            Require all granted
        </Directory>
    </VirtualHost>" > /etc/apache2/sites-available/wordpress.conf

    sudo a2ensite wordpress
    sudo a2enmod rewrite
    sudo a2dissite 000-default
    sudo service apache2 reload

echo "_____________________________________________________________"

echo "03.Done"
echo "_____________________________________________________________"

echo "04.Configure database"
echo "Type a password for mysql:"
read password
echo "_____________________________________________________________"

    $ sudo mysql -u root
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 7
    Server version: 5.7.20-0ubuntu0.16.04.1 (Ubuntu)

    Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> CREATE DATABASE wordpress;
    Query OK, 1 row affected (0,00 sec)

    mysql> CREATE USER wordpress@localhost IDENTIFIED BY '$password';
    Query OK, 1 row affected (0,00 sec)

    mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
        -> ON wordpress.*
        -> TO wordpress@localhost;
    Query OK, 1 row affected (0,00 sec)

    mysql> FLUSH PRIVILEGES;
    Query OK, 1 row affected (0,00 sec)

    mysql> quit
    Bye

echo "_____________________________________________________________"

echo "04.Done"
echo "_____________________________________________________________"
echo "05.Configure WordPress to connect to the database"
echo "_____________________________________________________________"

    sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
    sudo -u www-data sed -i 's/password_here/$password/' /srv/www/wordpress/wp-config.php
    sudo -u www-data nano /srv/www/wordpress/wp-config.php

echo "_____________________________________________________________"
echo "05.Done"
echo "_____________________________________________________________"

echo "Everything is ok; Enjoy :]"