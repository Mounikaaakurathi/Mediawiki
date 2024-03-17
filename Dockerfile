# Use the official Red Hat Universal Base Image (UBI) 8 as the base image
FROM registry.access.redhat.com/ubi8/ubi

# Update packages and install necessary software
RUN dnf -y update && \
    dnf module reset php -y && \
    dnf module enable php:7.4 -y && \
    dnf install -y httpd php php-mysqlnd php-gd php-xml php-mbstring php-json mod_ssl php-intl php-apcu wget gnupg procps-ng&& \
    dnf clean all
   
# Download and install MediaWiki
WORKDIR /tmp

RUN wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz && \
    tar -zxf mediawiki-1.41.0.tar.gz -C /var/www && \
    ln -s /var/www/mediawiki-1.41.0 /var/www/mediawiki && \
    chown -R apache:apache /var/www/mediawiki-1.41.0 && \
    chmod 750 /var/www/mediawiki-1.41.0

RUN mkdir /run/php-fpm && \
    chown -R apache:apache /run/php-fpm /run/httpd && \
    chmod 750 /run/php-fpm /run/httpd


#disable ssl since we are not using ssl
RUN sed -i 's/^/#/g' /etc/httpd/conf.d/ssl.conf


# Configure Apache
RUN sed -i 's#DocumentRoot "/var/www/html"#DocumentRoot "/var/www/mediawiki"#g' /etc/httpd/conf/httpd.conf && \
    sed -i 's#<Directory "/var/www/html">#<Directory "/var/www/mediawiki">#g' /etc/httpd/conf/httpd.conf && \
    sed -i 's#DirectoryIndex index.html#DirectoryIndex index.html index.html.var index.php#g' /etc/httpd/conf/httpd.conf

# Copy custom entrypoint script
COPY entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
