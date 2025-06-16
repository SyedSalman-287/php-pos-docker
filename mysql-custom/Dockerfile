FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install MySQL and dependencies
RUN apt update -y && \
    apt install -y mysql-server wget unzip && \
    apt clean

# Allow remote access to MySQL
RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Copy custom init script
COPY init-mysql.sh /init-mysql.sh
RUN chmod +x /init-mysql.sh

# Expose MySQL port
EXPOSE 3306

# Run init script
CMD ["/init-mysql.sh"]
