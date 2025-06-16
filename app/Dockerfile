# Use Ubuntu as base image
FROM ubuntu:20.04

# Disable interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, and required extensions
RUN apt update -y && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php -y && \
    apt update -y && \
    apt install -y apache2 php7.4 libapache2-mod-php7.4 php7.4-mysqli git mysql-client unzip && \
    apt clean

# Remove default Apache files
RUN rm -rf /var/www/html/*

# Copy app files to Apache web root
COPY . /var/www/html/

# Fix PHP error reporting
RUN sed -i 's/error_reporting(E_ALL);/error_reporting(E_ERROR);/g' /var/www/html/index.php

# Set DB config
RUN bash -c 'cat > /var/www/html/application/config/database.php' <<EOF
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

\$active_group = 'default';
\$query_builder = TRUE;

\$db['default'] = array(
    'dsn'   => '',
    'hostname' => getenv('DB_HOST') ?: 'localhost',
    'username' => 'adminuser',
    'password' => 'MySqlP@ssword123',
    'database' => 'phppos',
    'dbdriver' => 'mysqli',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);
EOF

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]
