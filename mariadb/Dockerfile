FROM debian:latest

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Copy custom configuration file
COPY my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Set proper permissions
RUN mkdir -p /run/mysqld /var/log/mysql
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql /etc/mysql/mariadb.conf.d/50-server.cnf /docker-entrypoint-initdb.d/init.sql
RUN chmod -R 770 /var/lib/mysql /run/mysqld /var/log/mysql /etc/mysql/mariadb.conf.d/50-server.cnf /docker-entrypoint-initdb.d/init.sql

# Expose MariaDB port
EXPOSE 3306

# Start MariaDB server
CMD ["mysqld", "--user=mysql"]