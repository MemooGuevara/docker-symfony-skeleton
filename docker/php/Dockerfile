FROM php:fpm

ARG UID

# Create user and some useful stuff
RUN adduser -u ${UID} --disabled-password --gecos "" appuser
RUN mkdir /home/appuser/.ssh
RUN chown -R appuser:appuser /home/appuser/
RUN echo "StrictHostKeyChecking no" >> /home/appuser/.ssh/config
RUN echo "alias sf=/appdata/www/bin/console" >> /home/appuser/.bashrc

# Config PHP
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf

# Install packages and PHP extensions
RUN apt-get update \
    # common libraries and extensions
    && apt-get install -y git git-flow acl openssl openssh-client wget zip vim \
    && apt-get install -y libpng-dev zlib1g-dev libzip-dev libxml2-dev libicu-dev \
    && docker-php-ext-install intl pdo zip \
    # for MySQL
    && docker-php-ext-install pdo_mysql \
    # for XDEBUG
    && pecl install xdebug apcu \
    # enable Docker extensions
    && docker-php-ext-enable --ini-name 05-opcache.ini opcache xdebug apcu

# Install and update composer
RUN curl -sS https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer
RUN composer self-update

# Install symfony-cli
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Install php-cs-fixer
RUN wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O php-cs-fixer
RUN chmod a+x php-cs-fixer
RUN mv php-cs-fixer /usr/local/bin/php-cs-fixer

# Create main folder
RUN mkdir -p /appdata/www

# Config XDEBUG
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /appdata/www
