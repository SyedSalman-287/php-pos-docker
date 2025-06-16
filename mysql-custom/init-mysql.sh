#!/bin/bash

# Start MySQL in background
mysqld_safe &

# Wait for MySQL to be ready
sleep 15

# Create DB and user
mysql -u root <<EOF
CREATE DATABASE phppos;
CREATE USER 'adminuser'@'%' IDENTIFIED BY 'MySqlP@ssword123';
GRANT ALL PRIVILEGES ON phppos.* TO 'adminuser'@'%';
FLUSH PRIVILEGES;
EOF

# Download and prepare SQL dump
wget https://raw.githubusercontent.com/deenseth/PHP-Point-Of-Sale/master/database/database.sql -O /tmp/database.sql
sed -i 's/phppos_//g' /tmp/database.sql
mysql -u root phppos < /tmp/database.sql

# Fix sessions.user_data column issue
mysql -u root -e "ALTER TABLE sessions MODIFY user_data TEXT DEFAULT NULL;" phppos

# Bring foreground process
tail -f /dev/null
