FROM php:8.1.6-fpm-alpine3.15

# Get installer script
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
# Install php exts
RUN install-php-extensions gd pdo_mysql zip redis xdebug
# Install deps
RUN apk add --no-cache unzip shadow nodejs npm nano
# Get composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
# copy ini
RUN cd /usr/local/etc/php && cp php.ini-development php.ini
# Create user & group so docker doesn't run as root
WORKDIR /var/www/html
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev saif
# Change ownership to new user
COPY --chown=saif:dev . /var/www/html
USER saif




