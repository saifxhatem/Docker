#!/bin/sh
echo "Bash script received input: $1"
if [[ $1 =~ "alpine" ]]; then
    echo "Alpine imagine"
    apk add --no-cache unzip shadow nodejs npm nano && curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
else
    echo "Debian image"
    apt update && apt install -y unzip nodejs npm nano && curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi