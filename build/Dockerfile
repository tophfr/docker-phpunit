ARG FROM=php:7.3-alpine
FROM $FROM

MAINTAINER toph <toph@toph.fr>

ENV COMPOSER_VERSION=1.8.0
RUN export COMPOSER_HOME=/tmp/composer \
    && cd /usr/local/bin \
    && EXPECTED_SIGNATURE=$(curl -sSL https://composer.github.io/installer.sig) \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');") \
    && if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then >&2 echo 'ERROR: Invalid installer signature'; exit 1; fi \
    && php composer-setup.php --version=$COMPOSER_VERSION \
    && php -r "unlink('composer-setup.php');" \
    && ln -s composer.phar composer \
    && rm -Rf $COMPOSER_HOME

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /usr/local/lib/composer
ENV COMPOSER_BIN_DIR /usr/local/bin

ARG XDEBUG_VERSION=2.7.0beta1
ENV PECL_EXT_XDEBUG_VERSION $XDEBUG_VERSION
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install -o -f xdebug-$PECL_EXT_XDEBUG_VERSION \
    && rm -rf /tmp/pear \
    && apk del .build-deps

ARG PHPUNIT_VERSION=7.5.1
ENV PHPUNIT_VERSION $PHPUNIT_VERSION
RUN composer global require -n phpunit/phpunit:$PHPUNIT_VERSION \
    && composer global clear-cache -n

#RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/zzz.ini

ENTRYPOINT ["/usr/local/bin/phpunit"]
