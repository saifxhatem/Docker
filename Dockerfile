ARG IMAGE
# ARG VARIANT
FROM php:${IMAGE}
# RUN echo 'PHP VERSION: ' ${PHP_VERSION} ' --- VARIANT: ' ${VARIANT}
# RUN echo "VARIANT = " ${VARIANT}
# RUN echo "PHP VERSION = " ${PHP_VERSION}
# Get installer script
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY install_deps.sh .
# Install php exts && deps
RUN install-php-extensions gd pdo_mysql zip redis pcntl rdkafka && chmod u+x sh install_deps.sh && sh install_deps.sh ${IMAGE}
# Create user & group so docker doesn't run as root
WORKDIR /var/www/html
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev saif
# Change ownership to new user
COPY --chown=saif:dev . /var/www/html
# Run as new user
USER saif