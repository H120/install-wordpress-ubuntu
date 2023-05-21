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
