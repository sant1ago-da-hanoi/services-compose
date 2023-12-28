FROM php:8.2.13-fpm as php

# RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

# Set environment variables
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_ENABLE_CLI=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
ENV PHP_OPCACHE_REVALIDATE_FREQ=0

# Install dependencies.
RUN apt-get update \
    && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx supervisor libonig-dev \
    && apt-get install -y libmagickwand-dev --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions.
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions mysqli pdo pdo_mysql bcmath curl opcache mbstring

RUN install-php-extensions calendar exif gd intl memcached mongodb pdo_pgsql pgsql redis soap tidy uuid xdebug xsl zip pcntl imap

RUN pecl install imagick && docker-php-ext-enable imagick

# Copy latest composer executable.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy configuration files.
COPY ./php/php.ini /usr/local/etc/php/php.ini
COPY ./php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./php/supervisord.conf /etc/supervisord.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Set working directory to /var/www.
WORKDIR /var/www

# Copy files from current folder to container current folder (set in workdir).
COPY --chown=www-data:www-data . .

# Create laravel caching folders.
RUN mkdir -p /var/www/storage/framework
RUN mkdir -p /var/www/storage/framework/cache
RUN mkdir -p /var/www/storage/framework/testing
RUN mkdir -p /var/www/storage/framework/sessions
RUN mkdir -p /var/www/storage/framework/views

# Fix files ownership.
RUN chown -R www-data /var/www/storage
RUN chown -R www-data /var/www/storage/framework
RUN chown -R www-data /var/www/storage/framework/sessions

# Set correct permission.
RUN find /var/www/storage -type d -exec chmod -R 755 {} \;
# RUN chmod -R 755 /var/www/storage
# RUN chmod -R 755 /var/www/storage/logs
# RUN chmod -R 755 /var/www/storage/framework
# RUN chmod -R 755 /var/www/storage/framework/sessions
# RUN chmod -R 755 /var/www/bootstrap

# Adjust user permission & group
RUN usermod --uid 1000 www-data
RUN groupmod --gid 1001 www-data

# Change ownership of nginx log files.
RUN chown -R www-data:www-data /var/log/nginx
RUN chmod -R 755 /var/log/nginx

RUN chmod 777 /var/lib/nginx
RUN chmod -R 755 /var/log/nginx
RUN find /var/log/nginx -type f -exec chmod 666 {} \;
RUN find /var/log/nginx -type d -exec chmod 755 {} \;
RUN touch /run/nginx.pid \
    && chmod 777 /run/nginx.pid \
    && chown -R www-data:www-data /run/nginx.pid

# Run the entrypoint file.
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
