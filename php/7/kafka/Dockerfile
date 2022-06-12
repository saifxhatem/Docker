FROM php:7.4-fpm-alpine

# Get installer script
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
# Install php exts
RUN install-php-extensions gd curl dom mbstring pdo pdo_mysql posix zip redis
# Install deps
RUN apk add --no-cache unzip autoconf librdkafka-dev build-base shadow nodejs npm nano
# Get composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
# install php-rdkafka
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN pecl install rdkafka
# copy ini and enable rdkafka ext
RUN cd /usr/local/etc/php && cp php.ini-development php.ini && sed -i '940i extension=rdkafka.so' php.ini
# Create user & group so docker doesn't run as root
WORKDIR /var/www/html
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev saif
# Change ownership to new user
COPY --chown=saif:dev . /var/www/html
USER saif




