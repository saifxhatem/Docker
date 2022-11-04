ARG PHP_VERSION

FROM php:${PHP_VERSION}

# Get installer script
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY install_dep.sh .
# Install php exts
RUN install-php-extensions gd pdo_mysql zip redis pcntl rdkafka
# Install deps & composer
# RUN apk add --no-cache \ 
#     unzip \ 
#     shadow \ 
#     nodejs \
#     npm \
#     nano && curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN install_deps.sh php:${PHP_VERSION}
# Create user & group so docker doesn't run as root
WORKDIR /var/www/html
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev saif
# Change ownership to new user
COPY --chown=saif:dev . /var/www/html
# Run as new user
USER saif